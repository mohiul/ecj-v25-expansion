package ec.app.regression.mcts;

import java.util.ArrayList;
import java.util.List;

import ec.gp.GPNode;

public class MCTSNode {

	public GPNode gpNode;
	
	public List<MCTSNode> children;
	
	public double value;

	public MCTSNode(GPNode gpNode) {
		this.gpNode = gpNode;
		children = new ArrayList<MCTSNode>();
	}
	
	public void addChild(MCTSNode node) {
		children.add(node);
	}
	
}
