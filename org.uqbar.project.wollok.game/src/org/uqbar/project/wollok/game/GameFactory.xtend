package org.uqbar.project.wollok.game

import com.badlogic.gdx.utils.Json
import java.io.IOException
import java.nio.charset.Charset
import java.nio.charset.StandardCharsets
import java.nio.file.Files
import java.nio.file.Paths
import org.uqbar.project.wollok.game.gameboard.Gameboard

class GameFactory {

	var Gameboard gameboard

	//Solo a fin de crear un prototipo de ejemplo
	def makeJson(){
		var config = new GameConfiguration()
		config.gameboardHeight = 5	
		config.gameboardTitle = "sokoban"
		config.gameboardWidth = 5
		config.imageCharacter = "jugador.png"
		config.imageGround = "flying_bird.png"
		config.arrowListener = true
		var Json json = new Json();
		System.out.println(json.toJson(config));		
	}
	
	def loadJson(){
		var Json json = new Json();
		var String text = readFile("config.json",StandardCharsets.UTF_8)
		var GameConfiguration config = json.fromJson(typeof(GameConfiguration), text);
		gameboard.configuration = config		
	}
	def void setGame(Gameboard aGameboard) {
		this.gameboard = aGameboard
		//makeJson()
		loadJson()
		aGameboard.configuration.build(aGameboard);
	}
	def String readFile(String path, Charset encoding) throws IOException 
	{
	  var byte[] encoded = Files.readAllBytes(Paths.get(path));
	  return new String(encoded, encoding);
	}
}
