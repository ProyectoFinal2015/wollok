package org.uqbar.project.wollok.launch.repl

import com.google.inject.Injector
import java.io.BufferedReader
import java.io.File
import java.io.InputStreamReader
import org.eclipse.emf.common.util.URI
import org.eclipse.emf.ecore.resource.ResourceSet
import org.eclipse.xtext.resource.XtextResourceSet
import org.eclipse.xtext.util.LazyStringInputStream
import org.uqbar.project.wollok.WollokConstants
import org.uqbar.project.wollok.interpreter.MessageNotUnderstood
import org.uqbar.project.wollok.interpreter.WollokInterpreter
import org.uqbar.project.wollok.interpreter.WollokInterpreterException
import org.uqbar.project.wollok.interpreter.stack.VoidObject
import org.uqbar.project.wollok.launch.WollokLauncher
import org.uqbar.project.wollok.wollokDsl.WFile

import static extension org.uqbar.project.wollok.model.WollokModelExtensions.*

class WollokRepl {
	val Injector injector
	val WollokLauncher launcher
	val WollokInterpreter interpreter
	val File mainFile
	val reader = new BufferedReader(new InputStreamReader(System.in))
	val prompt = ">>> "
	var whiteSpaces = ""
	val WFile parsedMainFile

	new(WollokLauncher launcher, Injector injector, WollokInterpreter interpreter, File mainFile, WFile parsedMainFile) {
		this.injector = injector
		this.launcher = launcher
		this.interpreter = interpreter
		this.mainFile = mainFile
		this.parsedMainFile = parsedMainFile
	}

	def void startRepl() {
		var String input

		println("Wollok interactive console (type \"quit\" to quit): ")
		print(prompt)
		
		while ((input = readInput) != "quit") {
			executeInput(input)
			print(prompt)
		}
	}
	
	def String readInput(){
		val input = reader.readLine.trim
		if(input == ""){
			print(prompt)
			readInput
		}
		else
			if(input.endsWith(";")) 
				input + " " + readInput
			else input
	}
	
	def executeInput(String input){
			try {
				val returnValue = interpreter.interpret(
					'''
						«FOR a : parsedMainFile.imports.map[importedNamespace]»
						import «a»
						«ENDFOR»
						import «parsedMainFile.fileName».*
						program repl {
						«input»
						}
					'''.parseRepl(mainFile),true)
				printReturnValue(returnValue)
			} catch (Exception e){
				resetIndent()
				handleException(e)
			}
	}
	
	def printReturnValue(Object obj){
		if(obj == null)
			println(obj)
		else 
			doPrintReturnValue(obj)
	}
	
	def dispatch doPrintReturnValue(Object obj){
		println(obj?.toString)
	}

	def dispatch doPrintReturnValue(String obj){
		println('"' + obj +'"')
	}

	def dispatch doPrintReturnValue(VoidObject obj){}

	def parseRepl(CharSequence content, File mainFile) {
		val resourceSet = injector.getInstance(XtextResourceSet)
		val resource = resourceSet.createResource(uriToUse(resourceSet));
		val in = new LazyStringInputStream(content.toString)

		launcher.createClassPath(mainFile, resourceSet)

		resourceSet.getResources().add(resource);

		resource.load(in, #{});
		launcher.validate(injector, resource, [], [throw new ReplParserException(it)])
		resource.getContents().get(0) as WFile;
	}

	def uriToUse(ResourceSet resourceSet) {
		var name = "__synthetic";
		for (var i = 0; i < Integer.MAX_VALUE; i++) {
			var syntheticUri = parsedMainFile.eResource.URI.trimFileExtension.trimSegments(1).appendSegment(name + i).appendFileExtension(WollokConstants.PROGRAM_EXTENSION)
			if (resourceSet.getResource(syntheticUri, false) == null){
				return syntheticUri;
			}
		}
		throw new IllegalStateException();
	}

	def <X> X printlnIdent(X obj){
		print(whiteSpaces)
		println(obj)
	}
	
	def indent(){
		whiteSpaces = whiteSpaces + "     "
	}
	
	def resetIndent(){
		whiteSpaces = ""
	}

	def dispatch void handleException(ReplParserException e){
		e.issues.forEach [
			printlnIdent("" + severity.name + ":" + message + "(line:" + (lineNumber - numberOfLinesBefore) + ")")
		]
	}

	def dispatch void handleException(Throwable e){
		e.printStackTrace
	}

	def dispatch void handleException(MessageNotUnderstood e){
		printlnIdent(e.internalMessage)
	}

	def getNumberOfLinesBefore(){
		2 + parsedMainFile.imports.size
	}

	def dispatch void handleException(WollokInterpreterException e){
		if(e.lineNumber > numberOfLinesBefore){
			printlnIdent('''Error in line (line:«e.lineNumber - numberOfLinesBefore»): «e.nodeText»:''')
		}
		
		if(e.cause != null){
			indent()
			handleException(e.cause)
		}
	}
}
