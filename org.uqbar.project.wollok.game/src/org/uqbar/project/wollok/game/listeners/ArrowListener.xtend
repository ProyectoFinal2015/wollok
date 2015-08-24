package org.uqbar.project.wollok.game.listeners

import com.badlogic.gdx.Input.Keys
import java.util.HashMap
import java.util.Iterator
import java.util.Map
import org.uqbar.project.wollok.game.gameboard.Gameboard

class ArrowListener implements GameboardListener {
	
	var diccionario = new HashMap<Integer, Runnable>()
	
	new(Gameboard aGameboard){
		diccionario.put(Keys.UP,[|aGameboard.character.position.incY(1)])
		diccionario.put(Keys.DOWN,[|aGameboard.character.position.incY(-1)])
		diccionario.put(Keys.LEFT,[|aGameboard.character.position.incX(-1)])
		diccionario.put(Keys.RIGHT,[|aGameboard.character.position.incX(1)])
	}
	
	override notify(Gameboard gameboard) {
    var Iterator<Map.Entry<Integer, Runnable>> it = diccionario.entrySet().iterator();
    while (it.hasNext()){
    	var Map.Entry<Integer,Runnable> pair = it.next() as Map.Entry<Integer,Runnable>;
		if (gameboard.isKeyPressed(pair.key.intValue))
			pair.value.run()			
		}		
	}
	
}
