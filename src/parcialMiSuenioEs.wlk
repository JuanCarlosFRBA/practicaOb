class Persona{
	var edad
	var hijos
	var felicidad
	const carrerasQueQuiereEstudiar = []
	const carrerasCompletadas = []
	var lugaresVisitados = []
	var suenios = []
	method cumplirSuenio(suenio){
		if(self.esAlgoPendiente(suenio)){
			suenio.cumplir(self)
		}else{error.throwExceptionWithMessage("El sueño " + suenio + " no está pendienté")
}
	} 
	method esAlgoPendiente(unsuenio){
		return suenios.filter{suenio=>suenio.pendiente()}
	}
	method tieneHijos() = hijos>0
	method sumarHijos(cantidad){
		hijos += cantidad
	}	
	method viajar(lugar){
		lugaresVisitados.add(lugar)
	} 
	method quiereEstudiar(carrera) = carrerasQueQuiereEstudiar.contains(carrera)
	method completarCarrera(carrera) {
		carrerasCompletadas.add(carrera)
	}
}
class Suenio{
	var felicidonios
	var property pendiente = true
	method cumplir(){pendiente=false}
}
class TenerHijos inherits Suenio{
	var hijosAAdoptar
	method validar(persona){
		return persona.tieneHijos()
	}
	method realizar(persona){
		persona.sumarHijos(hijosAAdoptar)
	}
}
class Viajar inherits Suenio{
	var lugar
	method validar(persona){}
	method realizar(persona){
		persona.viajar(lugar)
	}
}
class Recibirse inherits Suenio{
	var carrera
	method validar(persona){
		if(persona.quiereEstudiar(carrera)){}
	}
	method realizar(persona){
		persona.completarCarera(carrera)
	}
}


