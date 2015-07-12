import org.uqbar.project.wollok.interpreter.WollokInterpreter
import org.uqbar.project.wollok.interpreter.nativeobj.AbstractWollokDeclarativeNativeObject
import org.uqbar.project.wollok.interpreter.nativeobj.NativeMessage
import org.uqbar.project.wollok.game.Launcher

class JuanceteObject extends AbstractWollokDeclarativeNativeObject {
	
	@NativeMessage("sayMyName")
	def diMiNombre(){
		WollokInterpreter.getInstance().getConsole().logMessage("Juancete")
	}

	@NativeMessage("launchWollokGame")
	def launchGame(){
		new Launcher().launch()
	}
}