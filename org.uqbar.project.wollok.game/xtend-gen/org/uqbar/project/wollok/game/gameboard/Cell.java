package org.uqbar.project.wollok.game.gameboard;

import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.Pure;

@Accessors
@SuppressWarnings("all")
public class Cell {
  private int width;
  
  private int height;
  
  private String element;
  
  public Cell(final int widthSize, final int heghtSize, final String groundImage) {
    this.width = widthSize;
    this.height = heghtSize;
    this.element = groundImage;
  }
  
  @Pure
  public int getWidth() {
    return this.width;
  }
  
  public void setWidth(final int width) {
    this.width = width;
  }
  
  @Pure
  public int getHeight() {
    return this.height;
  }
  
  public void setHeight(final int height) {
    this.height = height;
  }
  
  @Pure
  public String getElement() {
    return this.element;
  }
  
  public void setElement(final String element) {
    this.element = element;
  }
}
