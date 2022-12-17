///////////////////agresiones////////////////////////
class Agresiones {
	const lugar
	const property agresor
	const palabras
		
	method esGrave(){
		return palabras.any{palabra=>diccionario.esInaceptable(palabra)	}	
	}
	method esIgnea(){
		return palabras.contains("fuego")
	}
}

class AgresionFisica inherits Agresiones{
	var elemento
	override method esGrave() = true
}

object diccionario{
	var palabrasInaceptables = ["matar","asesinar","quemar"]
	
	method esInaceptable(palabra){
		palabrasInaceptables.contains(palabra)
	}
	}
	
////////////////denuncias/////////////////


class Denuncia{
	var victima 
	var agresion
	var nroDenuncia
	
}
object policia {
	var denuncias =[]
	var numeroDenuncia
	method recibirDenuncia(persona,agresion){
		numeroDenuncia += 1
		denuncias.add( new Denuncia(
				victima = persona,
				agresion = agresion,
				nroDenuncia = numeroDenuncia
				))
	}
	method denunciaRegistradaPor(unaVictima){
		return !denuncias.isEmpty() and denuncias.get(numeroDenuncia-1).victima() == unaVictima
	}
}
/////////////persona/////////////////////
class Persona{
	var agresiones
	var familiares
	var property actitud
	
	method agragarFamiliar(familiar){
		familiares.add(familiar)
	}
	method recibirAgresion(agresion){
		if(self.analizaSiDenunciar(agresion)){
			self.hacerDenuncia(agresion)
		}
		agresiones.add(agresion)
	}
	method analizaSiDenunciar(agresion){
		return agresion.esGrave() && self.agresionDeFamiliar(agresion)	&& actitud.permiteDenuncia(self,agresion)
	}
	method agresionDeFamiliar(agresion){
		return familiares.contains(agresion.agresor()) && agresion.esGrave()
	}
	method agresionGraveDeFamiliar(agresion){
		return agresiones.any{self.agresionDeFamiliar(agresion)}
	}
	method cantidadAgresiones(agresor){
		return agresiones.count{agresion=>agresion.agresor()==agresor}
	}
	method hacerDenuncia(agresion){
		policia.recibirDenuncia(self,agresion)
	}
	method participarDeOrganizacion(){
		actitud = militante
	}
	method recibirAcompaniamiento(persona){
		actitud = persona.actitud()
	}
	method recibeAmenaza(){
		actitud.actitudALaAmenaza()
	}
}

///////////////////acititudes////////////////

object miedosa{
	method permiteDenuncia(persona,agresion) = false
	method actitudALaAmenaza() = self
	}
class Paciente{
	var tolerancia
	method permiteDenuncia(persona,agresion) {
		return persona.cantidadAgresiones(agresion.agresor()) > tolerancia
	}
	method actitudALaAmenaza() {
		tolerancia *= 2
		return self
	}
}
object aguerrida{
	method permiteDenuncia(persona,agresion) {
		return persona.agresionGraveDeFamiliar(agresion)  
	}
	method actitudFrenteALaAmenaza(){
		return new Paciente(tolerancia = 5)
	}
}
object militante{
	method permiteDenuncia(persona,agresion) {
		return true
	}
	method actitudFrenteALaAmenaza(){
		return aguerrida
	}
}

///////////////concientizacon///////////////////////////////
