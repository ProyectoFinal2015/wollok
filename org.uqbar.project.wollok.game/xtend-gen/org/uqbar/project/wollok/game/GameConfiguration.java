package org.uqbar.project.wollok.game;

import java.util.ArrayList;
import java.util.List;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.Pure;
import org.uqbar.project.wollok.game.Component;
import org.uqbar.project.wollok.game.gameboard.Gameboard;
import org.uqbar.project.wollok.game.listeners.GameboardListener;

@Accessors
@SuppressWarnings("all")
public class GameConfiguration {
  private String gameboardTitle;
  
  private int gameboardHeight;
  
  private int gameboardWidth;
  
  private String imageCharacter;
  
  private String imageGround;
  
  private boolean arrowListener;
  
  private List<Component> components;
  
  private List<GameboardListener> listeners = new ArrayList<GameboardListener>();
  
  public GameConfiguration() {
    ArrayList<Component> _arrayList = new ArrayList<Component>();
    this.components = _arrayList;
  }
  
  public boolean addComponent(final Component aComponent) {
    return this.components.add(aComponent);
  }
  
  public void build(final Gameboard aBoard) {
    aBoard.createCells(this.imageGround);
  }
  
  public boolean addListener(final GameboardListener aListener) {
    return this.listeners.add(aListener);
  }
  
  @Pure
  public String getGameboardTitle() {
    return this.gameboardTitle;
  }
  
  public void setGameboardTitle(final String gameboardTitle) {
    this.gameboardTitle = gameboardTitle;
  }
  
  @Pure
  public int getGameboardHeight() {
    return this.gameboardHeight;
  }
  
  public void setGameboardHeight(final int gameboardHeight) {
    this.gameboardHeight = gameboardHeight;
  }
  
  @Pure
  public int getGameboardWidth() {
    return this.gameboardWidth;
  }
  
  public void setGameboardWidth(final int gameboardWidth) {
    this.gameboardWidth = gameboardWidth;
  }
  
  @Pure
  public String getImageCharacter() {
    return this.imageCharacter;
  }
  
  public void setImageCharacter(final String imageCharacter) {
    this.imageCharacter = imageCharacter;
  }
  
  @Pure
  public String getImageGround() {
    return this.imageGround;
  }
  
  public void setImageGround(final String imageGround) {
    this.imageGround = imageGround;
  }
  
  @Pure
  public boolean isArrowListener() {
    return this.arrowListener;
  }
  
  public void setArrowListener(final boolean arrowListener) {
    this.arrowListener = arrowListener;
  }
  
  @Pure
  public List<Component> getComponents() {
    return this.components;
  }
  
  public void setComponents(final List<Component> components) {
    this.components = components;
  }
  
  @Pure
  public List<GameboardListener> getListeners() {
    return this.listeners;
  }
  
  public void setListeners(final List<GameboardListener> listeners) {
    this.listeners = listeners;
  }
}
