package org.uqbar.project.wollok.game;

import org.uqbar.project.wollok.game.gameboard.Gameboard;

public class Position {

	private int x;
	private int y;
	
	
	public Position(int x, int y) {
		this.x = x;
		this.y = y;
	}
	
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + x;
		result = prime * result + y;
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Position other = (Position) obj;
		if (x != other.x)
			return false;
		if (y != other.y)
			return false;
		return true;
	}
	
	public int getX() {
		return x;
	}
	public int getXinPixels(){
		return x * Gameboard.CELLZISE;
	}
	public void setX(int x) {
		this.x = x;
	}
	public int getY() {
		return y;
	}
	public int getYinPixels(){
		return y * Gameboard.CELLZISE;
	}
	public void setY(int y) {
		this.y = y;
	}
	
	public void incX(int spaces){
		this.x = this.x + spaces;
	}
	public void incY(int spaces){
		this.y = this.y + spaces;
	}	
}
