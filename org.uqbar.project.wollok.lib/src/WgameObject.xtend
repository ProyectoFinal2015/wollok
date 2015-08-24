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
import org.uqbar.project.wollok.interpreter.core.WollokClosure
import org.uqbar.project.wollok.game.listeners.KeyboardListener

class WgameObject extends AbstractWollokDeclarativeNativeObject {
	
	@NativeMessage("whenKeyPressedDo")
	def whenKeyPressedDoMethod(Object key, WollokClosure action) {
		var num = WollokInteger.cast(key).wrapped
		var listener = new KeyboardListener(num, [ | action.apply() ])
		Gameboard.getInstance().addListener(listener)
	}
	
	@NativeMessage("addVisualCharacter")
	def addVisualCharacterMethod(Object object) {
		var wollokObject = WollokObject.cast(object)
		this.addCharacter(new VisualComponent(wollokObject))
	}
	
	@NativeMessage("addVisual")
	def addVisualMethod(Object element) {		
		var wollokObject = WollokObject.cast(element)
		this.addComponent(new VisualComponent(wollokObject))
	}
	
	@NativeMessage("addVisualWithReference")
	def addVisualWithReferenceMethod(Object element, String property) {		
		var wollokObject = WollokObject.cast(element)
		this.addComponent(new VisualComponent(wollokObject, property))
	}
	
	@NativeMessage("getObjectsIn")
	def getObjectsInMethod(WollokInteger posX, WollokInteger posY) {
		var position = new Position(posX.wrapped, posY.wrapped)
		var list = Gameboard.getInstance().getComponentsInPosition(position).map[it.myDomainObject]
		new WollokList(WollokInterpreter.getInstance, list)
	}
	
	@NativeMessage("start")
	def startMethod() {
		Gameboard.getInstance().start()
	}
	
	def addCharacter(VisualComponent component) {
		Gameboard.getInstance().addCharacter(component)
	}
	
	def addComponent(VisualComponent component) {
		Gameboard.getInstance().addComponent(component)
	}
	
	// accessors
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
	
}