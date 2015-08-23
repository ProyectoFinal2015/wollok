package org.uqbar.project.wollok.launch.tests

import com.google.inject.Inject
import java.util.ArrayList
import java.util.List
import net.sf.lipermi.handler.CallHandler
import net.sf.lipermi.net.Client
import org.eclipse.emf.common.util.URI
import org.uqbar.project.wollok.launch.WollokLauncherParameters
import org.uqbar.project.wollok.wollokDsl.WTest
import wollok.lib.AssertionException

class WollokRemoteTestReporter implements WollokTestsReporter {
	
	@Inject
	var WollokLauncherParameters parameters
	
	var Client client
	var CallHandler callHandler = new CallHandler
	var WollokRemoteUITestNotifier remoteTestNotifier
	
	@Inject
	def init(){
		client = new Client("localhost", parameters.testPort, callHandler)
		remoteTestNotifier = client.getGlobal(WollokRemoteUITestNotifier) as WollokRemoteUITestNotifier
	}
	
	
	override reportTestAssertError(WTest test, AssertionException assertionError, int lineNumber, URI resource) {
		remoteTestNotifier.assertError(test.name, assertionError.message, assertionError.expected, assertionError.actual, lineNumber, resource.toString)
	}
	
	override reportTestOk(WTest test) {
		remoteTestNotifier.testOk(test.name)
	}
	
	override testsToRun(List<WTest> tests) {
		remoteTestNotifier.testsToRun(new ArrayList(tests.map[ name ]))
	}
	
	override testStart(WTest test) {
		remoteTestNotifier.testStart(test.name)
	}
	
}