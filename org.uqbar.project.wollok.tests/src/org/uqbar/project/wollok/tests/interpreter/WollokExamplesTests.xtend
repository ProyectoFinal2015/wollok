package org.uqbar.project.wollok.tests.interpreter

import java.io.File
import org.junit.Test
import org.junit.runners.Parameterized.Parameter
import org.junit.runners.Parameterized.Parameters
import org.uqbar.project.wollok.tests.base.AbstractWollokParameterizedInterpreterTest

/**
 * Runs all the examples in the wollok-example project that works as a unit test
 * 
 * @author tesonep
 * @author npasserini
 */
class WollokExamplesTests extends AbstractWollokParameterizedInterpreterTest {
	static val path = EXAMPLES_PROJECT_PATH + "/src/"
	static val libPath = EXAMPLES_PROJECT_PATH + "/src/lib"

	@Parameter(0)
	public File program

	@Parameters(name="{0}")
	static def Iterable<Object[]> data() {
		val files = newArrayList => [
			addAll(path.listWollokPrograms)
			addAll(libPath.listWollokPrograms)
		]
		
		files.asParameters
	}
	
	@Test
	def void runWollok() throws Exception {
		program.interpretPropagatingErrors
	}
	
	@Test
	def void canSetGameboardsTittle() {
		#[		
		'''
			program p {
				wgame.setTittle("un Titulo")

				tester.assertEquals("un Titulo", wgame.getTittle())
			}
		'''].interpretPropagatingErrors
	}
	
	@Test
	def void canSetGameboardsDimentions() {
		#[		
		'''
			program p {
				wgame.setWeight(2)
				wgame.setHeight(3)
				
				tester.assertEquals(2, wgame.getWeight())
				tester.assertEquals(3, wgame.getHeight())
			}
		'''].interpretPropagatingErrors
	}
	
	@Test
	def void canAddVisualObjects() {
		#[
		'''
			object pepita {
				var energia = 0
				method come(cantidad){
					energia = energia + cantidad * 10
				}
				method energia(){
					return energia
				}
			}
		''',
		'''
			program p {
				wgame.addObject(pepita, "pepita.png", 1, 1)
				
				tester.assertEquals(1, wgame.getObjectsIn(1, 1).size())
				tester.assert(wgame.getObjectsIn(1, 1).contains(pepita))
			}
		'''].interpretPropagatingErrors
	}

	// ********************************************************************************************
	// ** Helpers
	// ********************************************************************************************
	
	static def listWollokPrograms(String path) {
		new File(path).listFiles[isFile && name.endsWith(".wlk")]
	}
}
