package ec.gp.koza;

import java.util.ArrayList;
import java.util.HashMap;

import ec.EvolutionState;
import ec.Individual;
import ec.app.regression.mcts.MonteCarloSearchTree;
import ec.gp.GPBreedingPipeline;
import ec.gp.GPIndividual;
import ec.util.Parameter;
import ec.util.QuickSort;
import ec.util.SortComparatorL;

public class ReductionPipeline extends GPBreedingPipeline {

	private static final long serialVersionUID = 1L;
	
	public static final String P_REDUCTION = "reduction";
	public static final int NUM_SOURCES = 1;

	@Override
	public Parameter defaultBase() { return GPKozaDefaults.base().push(P_REDUCTION); }

	@Override
	public int numSources() { return NUM_SOURCES; }

	@Override
	public int produce(int min, int max, int subpopulation, ArrayList<Individual> inds, EvolutionState state,
			int thread, HashMap<String, Object> misc) {
        int start = inds.size();
        
        // grab individuals from our source and stick 'em right into inds.
        // we'll modify them from there
        int n = sources[0].produce(min,max,subpopulation,inds, state,thread, misc);

        // should we bother?
        if (!state.random[thread].nextBoolean(likelihood))
            {
            return n;
            }

		int[] sortedInd = sort(inds);
		ArrayList<Individual> newIndividuals = new ArrayList<Individual>();
        // now let's expand 'em
        for(int q=start; q < n+start; q++)
            {
            GPIndividual i = (GPIndividual)inds.get(q);
            MonteCarloSearchTree mcts = new MonteCarloSearchTree(state, 
					i, 
					subpopulation, 
					thread, 
					state.evaluator.p_problem,
					inds.get(sortedInd[sortedInd.length-1]));
            mcts.reduce();
            newIndividuals.addAll(mcts.getNewIndividuals());
            if(newIndividuals.size() > 0)
            	{
            	int[] sortedNewInd = sort(newIndividuals);
            	Individual newIndividual = newIndividuals.get(sortedNewInd[sortedNewInd.length-1]);
            	inds.set(q, newIndividual);
            	}
            }
        
        
        return n;
	}
	
	protected int[] sort(final ArrayList<Individual> i) {
		int[] sortedPop = new int[i.size()];
        for(int x=0;x<sortedPop.length;x++) sortedPop[x] = x;

        // sort sortedPop in increasing fitness order
        QuickSort.qsort(sortedPop, 
            new SortComparatorL()
                {
                public boolean lt(long a, long b)
                    {
                    return ((Individual)(i.get((int)b))).fitness.betterThan(
                        ((Individual)(i.get((int)a))).fitness);
                    }

                public boolean gt(long a, long b)
                    {
                    return ((Individual)(i.get((int)a))).fitness.betterThan(
                        ((Individual)(i.get((int)b))).fitness);
                    }
                });
        return sortedPop;
	}

}
