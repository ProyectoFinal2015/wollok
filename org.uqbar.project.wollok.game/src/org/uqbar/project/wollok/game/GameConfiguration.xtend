package org.uqbar.project.wollok.game

import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.project.wollok.game.gameboard.Gameboard
import org.uqbar.project.wollok.game.listeners.GameboardListener

@Accessors
class GameConfiguration {
	var String gameboardTitle
	var int gameboardHeight
	var int gameboardWidth
	var String imageCharacter
	var String imageGround
	var boolean arrowListener
	var List<Component> components
	var List<GameboardListener> listeners = new ArrayList<GameboardListener>();
	
	new (){
		components = new ArrayList<Component>()
	}
	def addComponent(Component aComponent){
		components.add(aComponent)
	}
	def build (Gameboard aBoard){
		aBoard.createCells(imageGround)
	}
	
	def addListener(GameboardListener aListener){
		listeners.add(aListener)
	}
	
}