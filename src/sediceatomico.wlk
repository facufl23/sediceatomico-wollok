object region {
	const ciudades = [springfield,albuquerque]
	method centralesMasProductivas() {
		return ciudades.map({ciudad=>ciudad.centralMasProductiva()})
	}
}
object springfield {
	const property vientosEnMS = 10
	const property riqueza = 0.9
	var property necesidadEnergetica = 20
	const centrales = [centralAtomica,centralCarbon,centralEolica]
	method tieneCentral(unaCentral) {
		return centrales.contains(unaCentral)
	}
	method produccionEnergetica(unaCentral) {
		if (not self.tieneCentral(unaCentral)) {
			self.error("No existe esta Central en esta ciudad")
		}
		return unaCentral.produccionEnergetica(self)
	}
	method centralesContaminantes() {
		return centrales.filter({central=>central.contaminacion()})
	}
	method produccionDe(unasCentrales) {
		return unasCentrales.sum({central=>self.produccionEnergetica(central)})
	}
	method cubrioNecesidades() {
		const produccionTotal = self.produccionDe(centrales)
		return produccionTotal >= necesidadEnergetica
	}
	method estaAlHorno() {
		const produccionCentralesContaminantes = self.produccionDe(self.centralesContaminantes())
		const aportanMasDeLoNecesario = produccionCentralesContaminantes > 0.5*necesidadEnergetica
		const todasSonContaminantes = centrales.all({central=>central.contaminacion()})
		return aportanMasDeLoNecesario || todasSonContaminantes
	}
	method centralMasProductiva() {
		const producciones = centrales.map({central=>self.produccionEnergetica(central)})
		const cantidadMasProductiva = producciones.max()
		return centrales.find({central=>self.produccionEnergetica(central) == cantidadMasProductiva})
	}
}
object albuquerque {
	const property caudalRio = 150
	const centrales = [centralHidroelectrica]
	method tieneCentral(unaCentral) {
		return centrales.contains(unaCentral)
	}
	method produccionEnergetica(unaCentral) {
		if (not self.tieneCentral(unaCentral)) {
			self.error("No existe esta Central en esta ciudad")
		}
		return unaCentral.produccionEnergetica(self)
	}
	method centralMasProductiva() {
		const producciones = centrales.map({central=>self.produccionEnergetica(central)})
		const cantidadMasProductiva = producciones.max()
		return centrales.find({central=>self.produccionEnergetica(central) == cantidadMasProductiva})
	}
}
object centralAtomica {
	const property nombre = "Burns"
	var property cantidadVarillasUranio = 10
	method produccionEnergetica(unaCiudad) {
		return 0.1 * cantidadVarillasUranio
	}
	method contaminacion() {
		return cantidadVarillasUranio > 20
	}
}
object centralCarbon {
	const property nombre = "Ex-bosque"
	var property capacidadEnToneladas = 20
	method produccionEnergetica(unaCiudad) {
		return 0.5 + capacidadEnToneladas * unaCiudad.riqueza()
	}
	method contaminacion() {
		return true
	}
}
object centralEolica {
	const property nombre = "El Suspiro"
	var property turbinas = [turbina1]
	method produccionEnergetica(unaCiudad) {
		return turbinas.sum({turbina => turbina.produccionEnergetica(unaCiudad)})
	}
	method contaminacion() {
		return false
	}
}
object centralHidroelectrica {
	method produccionEnergetica(unaCiudad) {
		return 2 * unaCiudad.caudalRio()
	}
}
object turbina1 {
	method produccionEnergetica(unaCiudad) {
		return 0.2 * unaCiudad.vientosEnMS()
	}
}