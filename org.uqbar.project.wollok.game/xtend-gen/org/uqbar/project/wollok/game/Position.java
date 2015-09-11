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
  
  public Position() {
  }
  
  public Position(final int x, final int y) {
    this.x = x;
    this.y = y;
  }
  
  public int hashCode() {
    final int prime = 31;
    int result = 1;
    int _x = this.getX();
    int _plus = ((prime * result) + _x);
    result = _plus;
    int _y = this.getY();
    int _plus_1 = ((prime * result) + _y);
    result = _plus_1;
    return result;
  }
  
  public boolean equals(final Object obj) {
    boolean _equals = Objects.equal(obj, null);
    if (_equals) {
      return false;
    }
    Position other = ((Position) obj);
    int _x = this.getX();
    int _x_1 = other.getX();
    boolean _notEquals = (_x != _x_1);
    if (_notEquals) {
      return false;
    }
    int _y = this.getY();
    int _y_1 = other.getY();
    boolean _notEquals_1 = (_y != _y_1);
    if (_notEquals_1) {
      return false;
    }
    return true;
  }
  
  public int getXinPixels() {
    int _x = this.getX();
    return (_x * Gameboard.CELLZISE);
  }
  
  public int getYinPixels() {
    int _y = this.getY();
    return (_y * Gameboard.CELLZISE);
  }
  
  public void incX(final int spaces) {
    int _x = this.getX();
    int _plus = (_x + spaces);
    this.setX(_plus);
  }
  
  public void incY(final int spaces) {
    int _y = this.getY();
    int _plus = (_y + spaces);
    this.setY(_plus);
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
