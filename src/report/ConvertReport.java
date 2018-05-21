package report;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FilenameFilter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ConvertReport {

	public static void main(String[] args) throws FileNotFoundException, IOException {
		List<String> problems = new ArrayList<String>();
//		problems.add("vladislavleva1");
//		problems.add("vladislavleva2");
//		problems.add("vladislavleva3");
//		problems.add("vladislavleva4");
//		problems.add("vladislavleva5");
//		problems.add("vladislavleva6");
//		problems.add("vladislavleva7");
//		problems.add("vladislavleva8");
//		problems.add("keijzer1");
//		problems.add("keijzer2");
//		problems.add("keijzer3");
//		problems.add("keijzer4");
//		problems.add("keijzer5");
//		problems.add("keijzer6");
//		problems.add("keijzer7");
//		problems.add("keijzer8");
//		problems.add("keijzer9");
//		problems.add("keijzer10");
//		problems.add("keijzer11");
//		problems.add("keijzer12");
//		problems.add("keijzer13");
//		problems.add("keijzer14");
//		problems.add("keijzer15");
		problems.add("pagie1");
//		problems.add("pagie2");

		List<String[]> solnTypes = new ArrayList<String[]>();
//		solnTypes.add(new String [] {"/exp-xover-prop", "-expansion1xover99", "Adjusted"});
//		solnTypes.add(new String [] {"/exp-xover-prop", "-expansion5xover95", "Adjusted"});
//		solnTypes.add(new String [] {"/exp-xover-prop", "-expansion10xover90", "Adjusted"});
//		solnTypes.add(new String [] {"/exp-xover-prop", "-expansion25xover75", "Adjusted"});
//		solnTypes.add(new String [] {"/exp-xover-prop", "-expansion50xover50", "Adjusted"});

//		solnTypes.add(new String [] {"/exp-max-dist", "-expMaxDistance3", "Adjusted"});
//		solnTypes.add(new String [] {"/exp-max-dist", "-expMaxDistance5", "Adjusted"});
//		solnTypes.add(new String [] {"/exp-max-dist", "-expMaxDistance8", "Adjusted"});
//		solnTypes.add(new String [] {"/exp-max-dist", "-expMaxDistance10", "Adjusted"});
//		solnTypes.add(new String [] {"/exp-max-dist", "-expMaxDistance12", "Adjusted"});
//		solnTypes.add(new String [] {"/exp-max-dist", "-expMaxDistance15", "Adjusted"});
//		solnTypes.add(new String [] {"/exp-max-dist", "-expMaxDistance20", "Adjusted"});
//		solnTypes.add(new String [] {"/exp-max-dist", "-expMaxDistance25", "Adjusted"});
//		solnTypes.add(new String [] {"/exp-max-dist", "-expMaxDistance40", "Adjusted"});

//		solnTypes.add(new String [] {"/exp-simulation", "-expSimulation1", "Adjusted"});
//		solnTypes.add(new String [] {"/exp-simulation", "-expSimulation5", "Adjusted"});
//		solnTypes.add(new String [] {"/exp-simulation", "-expSimulation10", "Adjusted"});
//		solnTypes.add(new String [] {"/exp-simulation", "-expSimulation20", "Adjusted"});
//		solnTypes.add(new String [] {"/exp-simulation", "-expSimulation40", "Adjusted"});
//		solnTypes.add(new String [] {"/exp-simulation", "-expSimulation80", "Adjusted"});
//		solnTypes.add(new String [] {"/exp-simulation", "-expSimulation120", "Adjusted"});
		
//		solnTypes.add(new String [] {"/expansionAll/test3", "-addInd-noFv", "Adjusted"});
//		solnTypes.add(new String [] {"/expansionAll/original/1000g", "", "Adjusted"});

		int dist[] = {3, 5, 8, 10};
		int sim[] = {1, 3, 5, 8, 10};
		for(int d : dist){
			for(int s : sim){
				solnTypes.add(new String [] {"/ex-param-diff", "-ex5xo95dist" + d + "sim" + s, "Adjusted"});
				solnTypes.add(new String [] {"/ex-param-diff", "-ex10xo90dist" + d + "sim" + s, "Adjusted"});
				solnTypes.add(new String [] {"/ex-param-diff", "-ex15xo85dist" + d + "sim" + s, "Adjusted"});
				solnTypes.add(new String [] {"/ex-param-diff", "-ex20xo80dist" + d + "sim" + s, "Adjusted"});
				solnTypes.add(new String [] {"/ex-param-diff", "-ex25xo75dist" + d + "sim" + s, "Adjusted"});
			}			
		}
		
		for(String problem : problems){
			for(String[] solnType : solnTypes){
				writeToFile(problem, solnType[0], solnType[1], solnType[2]);
			}
		}
	}

	private static void writeToFile(String problem, String dirName, String solnType, String strPattern) throws FileNotFoundException, IOException {
		String dirPath = "/home/mohiul/git/ecj-expansion/reports/" + dirName;		
		File dir = new File(dirPath);
		File [] files = dir.listFiles(new FilenameFilter() {
		    @Override
		    public boolean accept(File dir, String name) {
		        return name.startsWith("ecj-" + problem + solnType + ".sh.e");
		    }
		});
		BufferedWriter writer = Files.newBufferedWriter(Paths.get(dirPath + "/" + "ecj-" + problem + solnType));
		for (File file : files) {
			try (BufferedReader br = new BufferedReader(new FileReader(file))) {
			    String line;
			    boolean first = true;
			    String numPattern = "([0-9]+).([0-9]+)([eE][-+]?[0-9]+)?";
			    while ((line = br.readLine()) != null) {
			    	Pattern p = Pattern.compile(strPattern + "=" + numPattern);
			    	Matcher m = p.matcher(line);
			    	if (m.find()){
				    	Pattern p1 = Pattern.compile(numPattern);
				    	Matcher m1 = p1.matcher(m.group(0));
				    	if (m1.find()){
				    		if(!first){
				    			writer.write("\t");
				    		} else {
				    			first = false;
				    		}
				    		writer.write(m1.group(0));
				    	}
			    	}
			    }
			}
    		writer.write("\n");
		}
		writer.close();
	}
}
