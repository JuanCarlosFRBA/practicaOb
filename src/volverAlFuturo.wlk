class Personaje{
	var property nombre 
	var edad
	var altura
	var elementos = []
	method esMayor() = edad >50
	method tieneElemento(elemento) = elementos.contains(elemento)
	method tieneElementoPropio(){
		return elementos.any{elemento => elemento.esDuenio(self)}
	}
	method reducirAltura(){
		altura -= 1
	}
	method rejuvenecer(){
		edad -= 10
	}
	method perderCosaAntigua(){
		elementos.remove{self.elementoMasAntiguo()}
	}
	method elementoMasAntiguo(){
 		return elementos.min{e => e.fecha()}
 	}
	method problemaCon(unPersonaje,unaFecha){
		elementos.filter{e => e.esMasReciente(unaFecha)}.forEach{e => e.problemaCon(unPersonaje)}
	}
	method esAntepesadoDe(alguien){
 		return nombre == alguien.nombre() && alguien.esMayor()
 	}
 }
class Elementos{
	var descripcion
	var property fecha
		
	method esDuenio(alguien) = false
	method esMasReciente(unaFecha){
 		return fecha < unaFecha
 	}
 	method problemaCon(alguien){
 		descripcion = "BTTF " + descripcion
 	}
	}

class ElementosEspecial inherits Elementos {
	var duenio
		
	method esDuenio(alguien) = duenio == alguien 
	 	
	}


object deLoreans{
	var property pasajeros = []
	var combustible
	
	method viajarA(unDestino,unaFecha){
		pasajeros.forEach{pasajero =>combustible.aplicarEfectos(pasajero)}
	}
	
	method cambiarCombustible(unCombustible){
		combustible = unCombustible
	}
	method subirPasajero(pasajero){
		pasajero.add(pasajero)
	}
	method bajarPasajero(pasajero){
		pasajeros.remove(pasajero)
	}
	method huboUnProblemaCon(unPersonaje,unaFecha){
 		pasajeros.forEach{pasajero => pasajero.problemaCon(unPersonaje,unaFecha)}
 	}
}
object radiactivo{
	method efectoSecundarios(personaje){
		personaje.reducirAltura()
	}
}
object nafta{
	method efectoSecundarios(personaje){
		personaje.rejuvenecer()
	}
}

object electricidad{
	method efectoSecundarios(personaje){
		personaje.perderCosaAntigua()
	}
}
object basura{
	method efectoSecundarios(personaje){
		//no hace nada
	}
}
class Destino{
	var personas = []
	method familiaresDe(personaje){
		return personas.filter{persona => persona.esAntepasadopersona(persona)}
	}
	
}
class Documentacion inherits Elementos{
 	var personajes
 
 	override method esDuenio(alguien){
 		return personajes.contains(alguien)
 	}
 	override method problemaCon(alguien){
 		super(alguien)
 		if(self.esDuenio(alguien))
 			personajes.remove(alguien)
 	}
 }