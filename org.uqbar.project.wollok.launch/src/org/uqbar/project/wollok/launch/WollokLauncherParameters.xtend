package org.uqbar.project.wollok.launch

import java.util.ArrayList
import java.util.List
import org.apache.commons.cli.CommandLine
import org.apache.commons.cli.GnuParser
import org.apache.commons.cli.Option
import org.apache.commons.cli.Options
import org.eclipse.xtend.lib.annotations.Accessors

class WollokLauncherParameters {
	@Accessors
	Integer requestsPort = null
	@Accessors
	Integer eventsPort = null
	@Accessors
	List<String> wollokFiles = new ArrayList();
	@Accessors
	boolean hasRepl = false;

	@Accessors
	Integer testPort = null;

	@Accessors
	boolean tests = false;
	
	def build(){
		val sb = new StringBuilder
		if(hasRepl)sb.append("-r").append(" ")
		if(requestsPort != null)sb.append("-requestsPort " + requestsPort.toString).append(" ")
		if(eventsPort != null)sb.append("-eventsPort " + eventsPort.toString).append(" ")
		if(testPort != null)sb.append("-testPort " + testPort.toString).append(" ")
		if(tests)sb.append("-t ")
		wollokFiles.forEach [ sb.append(it).append(" ") ]
		sb.toString
	}

	def parse(String[] args) {
		val parser = new GnuParser
		val cmdLine = parser.parse(options, args)
		hasRepl = cmdLine.hasOption("r")
		
		tests = cmdLine.hasOption("t")
		testPort = parseParameter(cmdLine, "testPort")

		requestsPort = parseParameter(cmdLine, "requestsPort")
		eventsPort = parseParameter(cmdLine, "eventsPort")

		if ((requestsPort == 0 && eventsPort != 0) || (requestsPort != 0 && eventsPort == 0)) {
			throw new RuntimeException("Both RequestsPort and EventsPort should be informed")
		}
		
		wollokFiles = cmdLine.argList
		
		if(!wollokFiles.empty && hasRepl && !wollokFiles.get(0).endsWith(".wlk")){
			throw new RuntimeException("Repl can only be used with .wlk files.")
		}
		
		this
	}

	def parseParameter(CommandLine cmdLine, String paramName) {
		if (cmdLine.hasOption(paramName)) {
			val s = cmdLine.getOptionValue(paramName)
			try {
				Integer::parseInt(s);
			} catch (NumberFormatException e) {
				throw new RuntimeException("Invalid number value for " + paramName)
			}
		}
	}
	
	def hasDebuggerPorts(){
		this.eventsPort != 0
	}

	def options() {
		val options = new Options
		options.addOption(new Option("r", "Starts an interactive REPL") => [longOpt = "repl"])
		options.addOption(new Option("t", "Running tests") => [longOpt = "tests"])
		options.addOption(
			new Option("testPort", "Server port for tests") => [
				argName = "port"
				args = 1
			])
		options.addOption(
			new Option("requestsPort", "Request ports") => [
				argName = "port"
				args = 1
			])
		options.addOption(
			new Option("eventsPort", "Events ports") => [
				argName = "port"
				args = 1
			])
	}
}
