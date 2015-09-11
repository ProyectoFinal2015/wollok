package org.uqbar.project.wollok.game;

import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.Pure;

@Accessors
@SuppressWarnings("all")
public class Component {
  private String image;
  
  private boolean solid;
  
  private boolean mayIMove;
  
  public Component() {
    super();
  }
  
  public Component(final String image, final boolean imSolid, final boolean mayIMove) {
    this.image = image;
    this.solid = imSolid;
    this.mayIMove = mayIMove;
  }
  
  @Pure
  public String getImage() {
    return this.image;
  }
  
  public void setImage(final String image) {
    this.image = image;
  }
  
  @Pure
  public boolean isSolid() {
    return this.solid;
  }
  
  public void setSolid(final boolean solid) {
    this.solid = solid;
  }
  
  @Pure
  public boolean isMayIMove() {
    return this.mayIMove;
  }
  
  public void setMayIMove(final boolean mayIMove) {
    this.mayIMove = mayIMove;
  }
}
