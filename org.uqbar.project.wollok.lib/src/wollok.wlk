/**
 * Base class for all Exceptions.
 * 
 * @author jfernandes
 * @since 1.0
 */
package lang {
 
	/**
	 * Base class for all Exceptions.
	 * 
	 * @author jfernandes
	 * @since 1.0
	 */
	class Exception {
		method printStackTrace() native	
	}
	
	/**
	 *
	 * @author jfernandes
	 * since 1.0
	 */
	class WObject {
		method identity() native
		
		method ==(other) {
			return this === other
		}
		
		method ->(other) {
			return new Pair(this, other)
		}
	}
	
	class Pair {
		val x
		val y
		new (_x, _y) {
			x = _x
			y = _y
		}
		method getX() { return x }
		method getY() { return y }
		method getKey() { this.getX() }
		method getValue() { this.getY() }
	}
 
}
 
package lib {
	object console {
		method println(obj) native
		method readLine() native
		method readInt() native
	}
	
	object assert {
		method that(value) native
		method notThat(value) native
		method equals(expected, actual) native
		method notEquals(expected, actual) native
	}

object wgame{
	method addVisual(element) native
	method addVisualCharacter(element) native
	method addVisualWithReference(element, property) native
	method whenKeyPressedDo(key, action) native
	method whenKeyPressedSay(key, function) native
	method whenCollideDo(element, action) native
	method getObjectsIn(position) native
	method clear() native
	method start() native
	
	method setTittle(tittle) native
	method getTittle() native
	method setWidth(cant) native
	method getWidth() native
	method setHeight(cant) native
	method getHeight() native
}

object keys {
	method getKeyCode(aKey) native
	
	method onPress(key) {
		return new ProtoKeyListener(this.getKeyCode(key))
	}
}

class ProtoKeyListener {
	val key

	new(_key) {
		key = _key
	}

	method characterSay(function){
		wgame.whenKeyPressedSay(key, function)
	}	
	method do(action) {
		wgame.whenKeyPressedDo(key, action)
	}
}

class Position {
	var x = 0
	var y = 0
	
	new() { }
	
	new(_x, _y) {
		x = _x
		y = _y
	}
	
	method moveLeft(num) {
		x = x - num
	}
	method moveRight(num) {
		x = x + num
	}
	method moveDown(num) {
		y = y - num
	}
	method moveUp(num) {
		y = y + num
	}
	
	method clone() = new Position(x, y)
	
	method == (other) {
		return x == other.getX() and y == other.getY()
	}
	
	method drawCharacterWithReferences(element, reference) {
		this.drawCharacter(element)
		wgame.addVisualWithReference(element, reference)
	}
	
	method drawCharacter(element) {
		element.setPosicion(this.clone())
		wgame.addVisualCharacter(element)
	}
	
	method drawElementWithReferences(element, reference) {
		this.drawElement(element)
		wgame.addVisualWithReference(element, reference)
	}
	
	method drawElement(element) {
		element.setPosicion(this.clone())
		wgame.addVisual(element)
	}
	
	method getAllElements() {
		return wgame.getObjectsIn(this)
	}
	
	method getX() {
		return x
	}
	method setX(_x) {
		x = _x
	}
	method getY() {
		return y
	}
	method setY(_y) {
		y = _y
	}
}

class GameException extends wollok.lang.Exception {

	var message
 
	new (_message) {
		message = _message
	}
	
	method getMessage() = message
}
}
