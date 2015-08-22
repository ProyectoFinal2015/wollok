package org.uqbar.project.wollok.game;

import com.google.common.base.Objects;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.Pure;
import org.uqbar.project.wollok.game.gameboard.Gameboard;

@Accessors
@SuppressWarnings("all")
public class Position {
  private int x;
  
  private int y;
  
  public Position(final int x, final int y) {
    this.x = x;
    this.y = y;
  }
  
  public int hashCode() {
    final int prime = 31;
    int result = 1;
    result = ((prime * result) + this.x);
    result = ((prime * result) + this.y);
    return result;
  }
  
  public boolean equals(final Object obj) {
    boolean _equals = Objects.equal(this, obj);
    if (_equals) {
      return true;
    }
    boolean _equals_1 = Objects.equal(obj, null);
    if (_equals_1) {
      return false;
    }
    Class<? extends Position> _class = this.getClass();
    Class<?> _class_1 = obj.getClass();
    boolean _notEquals = (!Objects.equal(_class, _class_1));
    if (_notEquals) {
      return false;
    }
    Position other = ((Position) obj);
    if ((this.x != other.x)) {
      return false;
    }
    if ((this.y != other.y)) {
      return false;
    }
    return true;
  }
  
  public int getXinPixels() {
    return (this.x * Gameboard.CELLZISE);
  }
  
  public int getYinPixels() {
    return (this.y * Gameboard.CELLZISE);
  }
  
  public void incX(final int spaces) {
    this.x = (this.x + spaces);
  }
  
  public void incY(final int spaces) {
    this.y = (this.y + spaces);
  }
  
  @Pure
  public int getX() {
    return this.x;
  }
  
  public void setX(final int x) {
    this.x = x;
  }
  
  @Pure
  public int getY() {
    return this.y;
  }
  
  public void setY(final int y) {
    this.y = y;
  }
}
