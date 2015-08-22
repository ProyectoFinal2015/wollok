//package org.uqbar.project.wollok.lib.game

import org.uqbar.project.wollok.interpreter.nativeobj.AbstractWollokDeclarativeNativeObject
import org.uqbar.project.wollok.interpreter.nativeobj.NativeMessage
import org.uqbar.project.wollok.game.gameboard.Gameboard
import org.uqbar.project.wollok.interpreter.nativeobj.WollokInteger
import org.uqbar.project.wollok.game.Position
import org.uqbar.project.wollok.interpreter.nativeobj.collections.WollokList
import org.uqbar.project.wollok.interpreter.WollokInterpreter
import org.uqbar.project.wollok.interpreter.core.WollokObject
import org.uqbar.project.wollok.game.VisualComponent
import java.io.Console

class WgameObject extends AbstractWollokDeclarativeNativeObject {
	
	@NativeMessage("getGameboard")
	def getGameboardMethod() {
		Gameboard.getInstance()
	}
	
	@NativeMessage("setTittle")
	def setTittleMethod(String title) {
		Gameboard.getInstance().configuration.gameboardTitle = title
	}
	
	@NativeMessage("getTittle")
	def getTittleMethod() {
		Gameboard.getInstance().tittle
	}
	
	@NativeMessage("setWidth")
	def setWeightMethod(WollokInteger cant) {
		Gameboard.getInstance().configuration.gameboardWidth =  cant.wrapped
	}
		
	@NativeMessage("getWidth")
	def getWeightMethod() {
		Gameboard.getInstance().cantCellX
	}
	
	@NativeMessage("setHeight")
	def setHeightMethod(WollokInteger cant) {
		Gameboard.getInstance().configuration.gameboardHeight = cant.wrapped
	}
	
	@NativeMessage("getHeight")
	def getHeightMethod() {
		Gameboard.getInstance().cantCellY
	}
	
	@NativeMessage("addCharacter")
	def addCharacterMethod(Object wollokObject) {
		Gameboard.getInstance().setCharacterWollokObject(wollokObject)
	}
	
	@NativeMessage("addObject")
	def addObjectMethod(Object object) {
		
		var wollokObject = WollokObject.cast(object)
		
		var x = WollokInteger.cast(wollokObject.call("getX")).wrapped
		var y = WollokInteger.cast(wollokObject.call("getY")).wrapped
		
		var gamePosition = new Position(x, y)
		var visualComponent = new VisualComponent(wollokObject, "caja.png", gamePosition)
		
		Gameboard.getInstance().addComponent(visualComponent)
	}
	
	@NativeMessage("getObjectsIn")
	def getObjectsInMethod(WollokInteger posX, WollokInteger posY) {
		var position = new Position(posX.wrapped, posY.wrapped)
		var list = Gameboard.getInstance().getComponentsInPosition(position).map[it.myDomainObject]
		new WollokList(WollokInterpreter.getInstance, list)
	}
}