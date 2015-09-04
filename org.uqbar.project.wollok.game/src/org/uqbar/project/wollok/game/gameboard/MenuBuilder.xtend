package org.uqbar.project.wollok.game.gameboard

import com.badlogic.gdx.scenes.scene2d.InputEvent
import com.badlogic.gdx.scenes.scene2d.InputListener
import com.badlogic.gdx.scenes.scene2d.Stage
import com.badlogic.gdx.scenes.scene2d.ui.Skin
import com.badlogic.gdx.scenes.scene2d.ui.Table
import com.badlogic.gdx.scenes.scene2d.ui.TextButton
import org.eclipse.xtend.lib.annotations.Accessors

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
	}
	
	def createMenu(){
		val alto = 50
		val ancho = 50
		stage.addActor(table);
		table.setSize(ancho, alto);
		table.setPosition(positionX, Gameboard.getInstance.height - positionY - alto);
		// table.align(Align.right | Align.bottom);

		//table.debug();

		val TextButton button = new TextButton("Button 1", skin);
		button.addListener(new InputListener() {
			override boolean touchDown (InputEvent event, float x, float y, int pointer, int button) {
				System.out.println("touchDown 1 del menú loco");
				table.remove
				return false;
			}
		});
		table.add(button);
		// table.setTouchable(Touchable.disabled);

	}

}