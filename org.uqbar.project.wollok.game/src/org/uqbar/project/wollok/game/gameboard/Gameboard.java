package org.uqbar.project.wollok.game.gameboard;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.uqbar.project.wollok.game.GameConfiguration;
import org.uqbar.project.wollok.game.GameFactory;
import org.uqbar.project.wollok.game.Position;
import org.uqbar.project.wollok.game.VisualComponent;
import org.uqbar.project.wollok.game.listeners.GameboardListener;
import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.backends.lwjgl.LwjglApplication;
import com.google.common.base.Predicate;
import com.google.common.collect.Collections2;

public class Gameboard {

	public static final int CELLZISE = 32;
	private GameConfiguration configuration;
	private float keyboardCounter;
	private boolean marca;
	private List<Cell> cells = new ArrayList<Cell>();
	private VisualComponent character;
	private List<GameboardListener> listeners = new ArrayList<GameboardListener>();
	private List<VisualComponent> components = new ArrayList<VisualComponent>();

	public Gameboard() {
		marca = false;
		keyboardCounter = 0;
		this.character = new VisualComponent();
		this.character.setMyPosition(new Position(1, 1));
		GameFactory factory = new GameFactory();
		factory.setGame(this);
	}

	public void createCells(String groundImage) {
		for (int i = 0; i < configuration.getGameboardWidth(); i++) {
			for (int j = 0; j < configuration.getGameboardHeight(); j++) {
				cells.add(new Cell(i * CELLZISE, j * CELLZISE, groundImage));
			}
		}
	}

	public void start() {
		new LwjglApplication(new GameboardRendering(this),
				new GameboardConfiguration(this));
	}

	public int height() {
		return getCantCellY() * CELLZISE;
	}

	public int width() {
		return getCantCellX() * CELLZISE;
	}

	public boolean isKeyPressed(int key) {
		if (!marca){
			marca = Gdx.input.isKeyPressed(key);
			this.keyboardCounter = 0;
			}
		else {
			this.keyboardCounter += Gdx.graphics.getDeltaTime();
			if (this.keyboardCounter > 0.39f) {
				marca = Gdx.input.isKeyPressed(key);
				if (marca)
					this.keyboardCounter = 0;
			}
			else {
				return false;
			}
		}
			
		return marca;
	}

	public void addComponent(VisualComponent component) {
		this.components.add(component);
	}

	public Collection<VisualComponent> getComponentsInPosition(
			Position myPosition) {
		return Collections2.filter(components, new IsEqualPosition(myPosition));
	}

	// Getters & Setters

	public void setCharacterWollokObject(Object aCharacter) {
		this.character.setMyDomainObject(aCharacter);
	}

	public VisualComponent getCharacterVisualcomponent() {
		return this.character;
	}

	public String getTittle() {
		return configuration.getGameboardTitle();
	}

	public List<Cell> getCells() {
		return cells;
	}

	public List<GameboardListener> getListeners() {
		return listeners;
	}

	public List<VisualComponent> getComponents() {
		return this.components;
	}

	public void serListeners(List<GameboardListener> aList){
		this.listeners = aList;
	}
	public void addListener(GameboardListener aListener){
		this.listeners.add(aListener);
	}
	public void setComponents(List<VisualComponent> components) {
		this.components = components;
	}

	public int getCantCellX() {
		return configuration.getGameboardWidth();
	}

	public int getCantCellY() {
		return configuration.getGameboardHeight();
	}

	private class IsEqualPosition implements Predicate<VisualComponent> {

		private Position myPosition;

		public IsEqualPosition(Position p) {
			this.myPosition = p;
		}

		@Override
		public boolean apply(VisualComponent it) {
			return it.getMyPosition().equals(myPosition);
		}

	}

	private static Gameboard instance;

	public static Gameboard getInstance() {
		if (instance == null)
			instance = new Gameboard();
		return instance;
	}

	public GameConfiguration getConfiguration() {
		return configuration;
	}

	public void setConfiguration(GameConfiguration configuration) {
		this.configuration = configuration;
	}
}
