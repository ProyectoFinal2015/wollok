package org.uqbar.project.wollok.game.gameboard;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.files.FileHandle;
import com.badlogic.gdx.graphics.Texture;
import com.google.common.base.Objects;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.Pure;

@Accessors
@SuppressWarnings("all")
public class Cell {
  private int width;
  
  private int height;
  
  private String element;
  
  private Texture texture;
  
  public Cell(final int widthSize, final int heghtSize, final String groundImage) {
    this.width = widthSize;
    this.height = heghtSize;
    this.element = groundImage;
  }
  
  public Texture getTexture() {
    boolean _equals = Objects.equal(this.texture, null);
    if (_equals) {
      FileHandle _internal = Gdx.files.internal(this.element);
      Texture _texture = new Texture(_internal);
      return this.texture = _texture;
    }
    return this.texture;
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
  
  public void setTexture(final Texture texture) {
    this.texture = texture;
  }
}
