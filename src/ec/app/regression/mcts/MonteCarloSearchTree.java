package ec.app.regression.mcts;

import java.util.ArrayList;
import java.util.List;

import ec.EvolutionState;
import ec.Individual;
import ec.Problem;
import ec.app.regression.Benchmarks;
import ec.gp.GPIndividual;
import ec.gp.GPInitializer;
import ec.gp.GPNode;
import ec.gp.GPTree;
import ec.gp.koza.KozaBuilder;
import ec.gp.koza.KozaFitness;
import ec.util.Parameter;

public class MonteCarloSearchTree {
	
    protected ArrayList<Individual> newIndividuals;

	protected MCTSNode root;
	
	protected EvolutionState state;
	protected Individual individual;
	protected int subpopulation;
	protected int threadnum;
	
	protected GPInitializer initializer;
	protected KozaBuilder builder;
	protected Problem problem;
	
	protected int noOfSimulations;
	protected int maxDistance;
	protected double reductionIndex;
	protected boolean addIndividual;

	protected int noOfReductionSimulations;
	protected int maxReductionDistance;
	
	protected Individual bestIndv;
	
    public MonteCarloSearchTree(EvolutionState state, 
    		Individual ind, 
    		int subpopulation, 
    		int threadnum,
    		Problem problem, Individual bestIndv) {
    	this.newIndividuals = new ArrayList<Individual>();
    	this.state = state;
    	this.individual = ind;
    	this.subpopulation = subpopulation;
    	this.threadnum = threadnum;	
    	this.root = new MCTSNode(((GPIndividual)ind).trees[0].child);
    	this.problem = problem;
    	this.bestIndv = bestIndv;
    	
    	noOfSimulations = state.parameters.getIntWithDefault(new Parameter("gp.koza.expansion.mcts.simulation"), null, 25);
    	maxDistance = state.parameters.getIntWithDefault(new Parameter("gp.koza.expansion.mcts.maxDistance"), null, 10);
    	reductionIndex = state.parameters.getDoubleWithDefault(new Parameter("gp.koza.expansion.mcts.reductionIndex"), null, 0.25);
    	addIndividual = state.parameters.getBoolean(new Parameter("gp.koza.expansion.mcts.addIndividual"), null, false);

    	noOfReductionSimulations = state.parameters.getIntWithDefault(new Parameter("gp.koza.reduction.mcts.simulation"), null, 25);
    	maxReductionDistance = state.parameters.getIntWithDefault(new Parameter("gp.koza.reduction.mcts.maxDistance"), null, 10);
    	
    	initializer = ((GPInitializer)state.initializer);
    	builder = (KozaBuilder)((GPIndividual)ind).trees[0].constraints(initializer).init;
	}
    
	public double getFutureValue() {
		double futureValue = 0;
		for(int s = 0; s < noOfSimulations; s++){
			int randomDistance = state.random[threadnum].nextInt(maxDistance) + 1;
			futureValue += simulate(root, randomDistance);
		}
		return futureValue/noOfSimulations;
	}
	
	public void simulate() {
		for(int s = 0; s < noOfSimulations; s++){
			simulate(root, state.random[threadnum].nextInt(maxDistance) + 1);
		}
	}
	
	public double simulate(MCTSNode node, int randomDistance) {
		double fitness = 0;
		if(randomDistance == 0) {
			fitness = evaluateIndividual(node.gpNode);
		} else {
			GPNode program = (GPNode)node.gpNode.clone();
			MCTSNode childNode = new MCTSNode(program);
			node.addChild(childNode);
			
			List<GPNode> terminals = new ArrayList<GPNode>();
			findTerminals(program, terminals);
			GPNode randomTerminal = terminals.get(state.random[threadnum].nextInt(terminals.size()));
			
			GPNode gpNode = builder.growNodeNonTerminals(state, 0, 2, 
					((GPIndividual)individual).trees[0].constraints(initializer).treetype, 
					threadnum, randomTerminal.parent, 0, 
					((GPIndividual)individual).trees[0].constraints(initializer).functionset, true);
			
			if(randomTerminal.parent instanceof GPTree){
				((GPTree)randomTerminal.parent).child = gpNode;
			} else if(randomTerminal.parent instanceof GPNode){
				for(int i = 0; i < ((GPNode)randomTerminal.parent).children.length; i++){
					GPNode child = ((GPNode)randomTerminal.parent).children[i];
					if(child.equals(randomTerminal)){
						((GPNode)randomTerminal.parent).children[i] = gpNode;
						break;
					}
				}				
			}
			double childFitness = evaluateIndividual(childNode.gpNode);
			fitness = (childFitness + simulate(childNode, --randomDistance))*reductionIndex;
		}
		return fitness;
	}

	public void reduce() {
		for(int s = 0; s < noOfReductionSimulations; s++){
			reduce(root, state.random[threadnum].nextInt(maxReductionDistance) + 1);
		}
	}
	
	public void reduce(MCTSNode node, int randomDistance) {
		if(randomDistance > 0) {
			GPNode program = (GPNode)node.gpNode.clone();
			MCTSNode childNode = new MCTSNode(program);
			node.addChild(childNode);
			
			List<GPNode> terminals = new ArrayList<GPNode>();
			findTerminalsToReduce(program, terminals);
			if(terminals.size() == 0) return;
			GPNode randomTerminal = terminals.get(state.random[threadnum].nextInt(terminals.size()));
			
			GPNode terminalParent = (GPNode)randomTerminal.parent;
			
			if(terminalParent.parent instanceof GPTree){
				((GPTree)terminalParent.parent).child = randomTerminal;
			} else if(terminalParent.parent instanceof GPNode){
				for(int i = 0; i < ((GPNode)terminalParent.parent).children.length; i++){
					GPNode child = ((GPNode)terminalParent.parent).children[i];
					if(child.equals(terminalParent)){
						((GPNode)terminalParent.parent).children[i] = randomTerminal;
						randomTerminal.parent = terminalParent.parent;
						break;
					}
				}
			}
			evaluateIndividual(childNode.gpNode);
			reduce(childNode, --randomDistance);
		}
	}
	
    private double evaluateIndividual(GPNode gpNode) {
		GPIndividual newIndividual = (GPIndividual)individual.clone();
		newIndividual.evaluated = false;
		newIndividual.trees[0] = ((GPIndividual)individual).trees[0].lightClone();
		newIndividual.trees[0].owner = newIndividual;
		newIndividual.trees[0].child = gpNode;		
		newIndividual.trees[0].child.parent = newIndividual.trees[0];
		newIndividual.trees[0].child.argposition = 0;
		
		((Benchmarks)problem).evaluate(state, newIndividual, subpopulation, threadnum);
		state.incrementEvaluations(1);
		double fitness = ((KozaFitness)newIndividual.fitness).adjustedFitness();
		if(addIndividual && newIndividual.fitness.betterThan(bestIndv.fitness)){
			newIndividuals.add(newIndividual);
		}
		return fitness;
	}

	protected void findTerminals(GPNode node, List<GPNode> terminals) {
		if(node.children.length == 0){
			terminals.add(node);
		} else {
			for(GPNode child : node.children){
				findTerminals(child, terminals);				
			}
		}
	}
    
	protected void findTerminalsToReduce(GPNode node, List<GPNode> terminals) {
		if(node.children.length == 0 && !(node.parent instanceof GPTree)){
			terminals.add(node);
		} else {
			for(GPNode child : node.children){
				findTerminalsToReduce(child, terminals);				
			}
		}
	}
	
	public ArrayList<Individual> getNewIndividuals() {
		return newIndividuals;
	}

}
