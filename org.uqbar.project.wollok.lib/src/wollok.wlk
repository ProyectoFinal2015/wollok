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
			method getGameboard() native
			method setTittle(tittle) native
			method getTittle() native
			method setWidth(cant) native
			method getWidth() native
			method setHeight(cant) native
			method getHeight() native
			method addCharacter(wollokObject) native
			method addObject(wollokObject) native
			method agregarObjeto(wollokObject) native
			method alPresionarHacer(key, action) native
			method agregarPersonaje(object) native
			method getObjectsIn(posX, posY) native
			method addKeyboardListener(action) native
		}
	
	class Position { 
		method getX() native
		method setX(x) native
		method getY() native
		method setY(y) native
		method setWollokObject(anObject) native
		method sendMessage() native
	}
}
