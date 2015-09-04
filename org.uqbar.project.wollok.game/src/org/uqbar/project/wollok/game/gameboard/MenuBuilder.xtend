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
		
		stage.addActor(table);
		table.setSize(100, 100);
		table.setPosition(positionX, positionY);
		// table.align(Align.right | Align.bottom);

		table.debug();

//		var TextureRegion upRegion = skin.getRegion("default-slider-knob");
//		var TextureRegion downRegion = skin.getRegion("default-slider-knob");
//		var BitmapFont buttonFont = skin.getFont("default-font");

		var TextButton button = new TextButton("Button 1", skin);
		button.addListener(new InputListener() {
			override boolean touchDown (InputEvent event, float x, float y, int pointer, int button) {
				System.out.println("touchDown 1 del menú loco");
				table = null;
				return false;
			}
		});
		table.add(button);
		// table.setTouchable(Touchable.disabled);

	}

}