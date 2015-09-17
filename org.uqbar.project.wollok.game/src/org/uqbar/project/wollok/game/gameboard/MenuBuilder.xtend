package org.uqbar.project.wollok.game.gameboard

import com.badlogic.gdx.scenes.scene2d.InputEvent
import com.badlogic.gdx.scenes.scene2d.InputListener
import com.badlogic.gdx.scenes.scene2d.Stage
import com.badlogic.gdx.scenes.scene2d.ui.Skin
import com.badlogic.gdx.scenes.scene2d.ui.Table
import com.badlogic.gdx.scenes.scene2d.ui.TextButton
import org.eclipse.xtend.lib.annotations.Accessors
import com.badlogic.gdx.scenes.scene2d.ui.Label

@Accessors
class MenuBuilder {
	var Stage stage
	var Skin skin
	var int positionX
	var int positionY
	var Table table
	
	new(Skin aSkin, Stage aStage){
		this.stage = aStage
		this.skin = aSkin
		this.table = new Table();
		table.add(new Label("Menu",this.skin))
	}

	
	def createMenu(){
		val alto = 50
		val ancho = 50
		
		if (table.rows==0)
			return;
		stage.addActor(table);
		table.setSize(ancho, alto);
		table.setPosition(positionX, Gameboard.getInstance.height - positionY - alto);
		//table.debug();

	}
	
	def addButton(String caption){
		if (caption == "")
			return;
		var name = caption.substring(0,caption.indexOf("["))
		val TextButton button = new TextButton(name, skin);
		button.addListener(new InputListener() {
			override boolean touchDown (InputEvent event, float x, float y, int pointer, int button) {
				System.out.println("touchDown en el botón " +  caption + " del menú loco");
				table.remove
				return false;
			}
		});
		this.table.row();
		this.table.add(button);
		
	}

}