package org.uqbar.project.wollok.game.gameboard;

import org.uqbar.project.wollok.game.VisualComponent;
import org.uqbar.project.wollok.game.listeners.GameboardListener;

import com.badlogic.gdx.ApplicationListener;
import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.InputMultiplexer;
import com.badlogic.gdx.graphics.GL20;
import com.badlogic.gdx.graphics.OrthographicCamera;
import com.badlogic.gdx.graphics.Texture;
import com.badlogic.gdx.graphics.Texture.TextureFilter;
import com.badlogic.gdx.graphics.g2d.BitmapFont;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.badlogic.gdx.scenes.scene2d.Stage;
import com.badlogic.gdx.scenes.scene2d.ui.Skin;

public class GameboardRendering implements ApplicationListener {

	private Gameboard gameboard;
	private OrthographicCamera camera;
	private SpriteBatch batch;
	private BitmapFont font;
	private Skin skin;
	private Stage stage;	
	
	public GameboardRendering(Gameboard gameboard) {
		this.gameboard = gameboard;
	}

	@Override
	public void create() {
		this.skin = new Skin(Gdx.files.internal("data/uiskin.json"));
		this.stage = new Stage();
		InputMultiplexer inputMultiplexer = new InputMultiplexer();		
		inputMultiplexer.addProcessor(this.stage);
		inputMultiplexer.addProcessor(new GameboardInputProcessor(skin, stage));
		Gdx.input.setInputProcessor(inputMultiplexer);
//		Gdx.input.setInputProcessor(this.stage);
		camera = new OrthographicCamera(0, 0);
		camera.setToOrtho(false, gameboard.width(), gameboard.height());
		batch = new SpriteBatch();
		font = new BitmapFont();
	}

	@Override
	public void render() {
		Gdx.gl.glClearColor(1, 1, 1, 1);
		Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT);
		batch.setProjectionMatrix(camera.combined);
		batch.begin();

		for (GameboardListener listener : gameboard.getListeners()) {
			listener.notify(gameboard);
		}

		for (Cell cell : gameboard.getCells()) {
			this.draw(cell);
		}

		for (VisualComponent component : gameboard.components) {
			this.draw(component);
		}
		if (gameboard.getCharacter()!= null)
			this.draw(gameboard.getCharacter());
		batch.end();
		stage.draw();
	}

	@Override
	public void dispose() {
		batch.dispose();
		stage.dispose();
	}

	private void draw(Cell cell) {
		Texture texture = cell.getTexture();
		texture.setFilter(TextureFilter.Linear, TextureFilter.Linear);
		batch.draw(texture, cell.getWidth(), cell.getHeight());
	}

	private void draw(VisualComponent aComponent) {
		aComponent.draw(batch, font);
	}

	@Override
	public void resize(int arg0, int arg1) {
		// TODO Auto-generated method stub

	}

	@Override
	public void resume() {
		// TODO Auto-generated method stub

	}

	@Override
	public void pause() {
		// TODO Auto-generated method stub

	}

}
