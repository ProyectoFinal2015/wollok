class Asustador {
	var edad = 0
	var nivelMotivacion = 100
	
	method getEdad() { edad } method setEdad(e) { edad = e }
	
	method getNivelMotivacion() { nivelMotivacion }
	
	method entrarAPuerta(puerta) {
		puerta.entra(this)
	}
	
	method asustar(ninio) {
		val a = nivelMotivacion / 100
		val ptos = this.puntosDeTerror()
		a * (ptos / ninio.getEdad())
	}
	
	method /*abstract*/ puntosDeTerror()
	
	method reducirMotivacion(cuantoPorciento) {
		nivelMotivacion -= cuantoPorciento * nivelMotivacion
	}
}

class AsustadorNato extends Asustador {
	var puntosTerrorInnatos
	new (p) { 
		puntosTerrorInnatos = p
	}
	override method puntosDeTerror() {
		puntosTerrorInnatos * this.getEdad()
	}
}

class AsustadorPerseverante extends Asustador {
	var puntosDeTerror = 0
	method mejora(actividad) {
		puntosDeTerror += actividad.calcularMejora()
	}
	override method puntosDeTerror() { puntosDeTerror }
}

