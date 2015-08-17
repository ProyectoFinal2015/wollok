package org.uqbar.project.wollok.game.gameboard

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Cell {
	var int width;
	var int height;
	var String element;

	new (int widthSize,int heghtSize, String groundImage) {
		this.width = widthSize;
		this.height = heghtSize;
		this.element = groundImage;
	}
}