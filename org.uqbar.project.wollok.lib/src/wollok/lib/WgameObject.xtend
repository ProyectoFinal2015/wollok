package wollok.lib

import org.uqbar.project.wollok.game.VisualComponent
import org.uqbar.project.wollok.game.WPosition
import org.uqbar.project.wollok.game.gameboard.Gameboard
import org.uqbar.project.wollok.game.listeners.CollisionListener
import org.uqbar.project.wollok.game.listeners.KeyboardListener
import org.uqbar.project.wollok.interpreter.WollokInterpreter
import org.uqbar.project.wollok.interpreter.core.WollokClosure
import org.uqbar.project.wollok.interpreter.core.WollokObject
import org.uqbar.project.wollok.interpreter.nativeobj.AbstractWollokDeclarativeNativeObject
import org.uqbar.project.wollok.interpreter.nativeobj.NativeMessage
import org.uqbar.project.wollok.interpreter.nativeobj.WollokInteger
import org.uqbar.project.wollok.interpreter.nativeobj.collections.WollokList
import org.uqbar.project.wollok.game.listeners.CharacterSayListener
import org.uqbar.project.wollok.interpreter.nativeobj.collections.WollokSet

class WgameObject extends AbstractWollokDeclarativeNativeObject {
	
	@NativeMessage("addVisual")
	def addVisualMethod(Object element) {		
		var wollokObject = WollokObject.cast(element)
		this.addComponent(new VisualComponent(wollokObject))
	}
	
	@NativeMessage("addVisualCharacter")
	def addVisualCharacterMethod(Object object) {
		var wollokObject = WollokObject.cast(object)
		this.addCharacter(new VisualComponent(wollokObject))
	}
	
	@NativeMessage("addVisualWithReference")
	def addVisualWithReferenceMethod(Object element, WollokList property) {		
		var wollokObject = WollokObject.cast(element)
		this.addComponent(new VisualComponent(wollokObject, property.wrapped))
	}

	@NativeMessage("whenKeyPressedSay")
	def whenKeyPressedSayMethod(Object key, WollokClosure function) {
		var num = WollokInteger.cast(key).wrapped
		var listener = new CharacterSayListener(num,  [ | return function.apply().toString ])
		Gameboard.getInstance().addListener(listener)
	}
	
	@NativeMessage("whenKeyPressedDo")
	def whenKeyPressedDoMethod(Object key, WollokClosure action) {
		var num = WollokInteger.cast(key).wrapped
		var listener = new KeyboardListener(num, [ | action.apply() ])
		Gameboard.getInstance().addListener(listener)
	}

	@NativeMessage("whenCollideDo")
	def whenCollideDoMethod(Object object, WollokClosure action) {
		var visualObject = Gameboard.getInstance().components.findFirst[ c | c.domainObject.equals(WollokObject.cast(object))]
		var listener = new CollisionListener(visualObject, [ e | action.apply(e.domainObject) ])
		Gameboard.getInstance().addListener(listener)
	}
	
	@NativeMessage("getObjectsIn")
	def getObjectsInMethod(Object position) {
		var wollokObject = WollokObject.cast(position)
		var wPosition = new WPosition(wollokObject)
		var list = Gameboard.getInstance().getComponentsInPosition(wPosition).map[it.domainObject as Object]
		new WollokList(WollokInterpreter.getInstance, list)
	}
	
	@NativeMessage("clear")
	def clearMethod() {
		Gameboard.getInstance().clear()
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