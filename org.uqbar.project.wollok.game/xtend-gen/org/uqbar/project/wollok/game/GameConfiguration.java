package org.uqbar.project.wollok.game;

import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.Pure;
import org.uqbar.project.wollok.game.VisualComponent;
import org.uqbar.project.wollok.game.gameboard.Gameboard;
import org.uqbar.project.wollok.game.listeners.ArrowListener;

@Accessors
@SuppressWarnings("all")
public class GameConfiguration {
  private String gameboardTitle;
  
  private int gameboardHeight;
  
  private int gameboardWidth;
  
  private String imageCharacter;
  
  private String imageGround;
  
  private boolean arrowListener;
  
  public void build(final Gameboard aBoard) {
    aBoard.createCells(this.imageGround);
    if (this.arrowListener) {
      ArrowListener _arrowListener = new ArrowListener(aBoard);
      aBoard.addListener(_arrowListener);
    }
    VisualComponent _characterVisualcomponent = aBoard.getCharacterVisualcomponent();
    _characterVisualcomponent.setImage(this.imageCharacter);
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
}
