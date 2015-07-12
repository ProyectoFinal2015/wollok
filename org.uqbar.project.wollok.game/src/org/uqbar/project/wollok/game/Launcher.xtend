package org.uqbar.project.wollok.game

import com.badlogic.gdx.backends.lwjgl.LwjglApplicationConfiguration
import com.badlogic.gdx.backends.lwjgl.LwjglApplication
import org.uqbarproject.sokobanui.game.SokobanGame

class Launcher {
	
	LwjglApplicationConfiguration cfg
	
	def void launch(){
		cfg = new LwjglApplicationConfiguration();
		cfg.title = "sokoban";
		cfg.useGL30 = false;
		cfg.width = 480;
		cfg.height = 320;
		
		new LwjglApplication(new SokobanGame(), cfg);
	}
}