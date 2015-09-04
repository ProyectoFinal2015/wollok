package org.uqbar.project.wollok.game.gameboard

import com.badlogic.gdx.InputProcessor
import com.badlogic.gdx.scenes.scene2d.Stage
import com.badlogic.gdx.scenes.scene2d.ui.Skin
import java.util.Collection
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.project.wollok.game.VisualComponent

@Accessors
class GameboardInputProcessor implements InputProcessor {
	var Skin skin
	var Stage stage
	
	new (Skin aSkin, Stage aStage){
		this.skin = aSkin
		this.stage = aStage
	}
	
	override boolean keyDown(int keycode) {
		return false;
	}

	override boolean keyUp(int keycode) {
		return false;
	}

	override boolean keyTyped(char character) {
		return false;
	}

	override boolean touchDown(int x, int y, int pointer, int button) {

		var Collection<VisualComponent> lista = Gameboard.getInstance.getComponentsInPosition(x, y)
		System.out.println("Click en " + x + "," + y + " con boton" + button)
		System.out.println("Hay " + lista.size + " elementos")
		if (button == 1) {
			//Gameboard.getInstance.getStage.addActor(MenuBuilder.buildMenu(x, y))
			var MenuBuilder aBuilder = new MenuBuilder(skin,stage);
			aBuilder.positionX = x
			aBuilder.positionY = y
			aBuilder.createMenu
		}
		return true;
	}

	override boolean touchUp(int x, int y, int pointer, int button) {
		return false;
	}

	override boolean touchDragged(int x, int y, int pointer) {
		return false;
	}

	override boolean mouseMoved(int x, int y) {
		return false;
	}

	override boolean scrolled(int amount) {
		return false;
	}

}

