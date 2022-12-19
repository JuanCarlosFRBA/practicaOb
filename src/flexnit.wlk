class Contenido{
	var titulo
	var calificaciones=[]
	method agregarCalificacion(calificacion){
		calificacion.add(calificacion)
	}
	method promedioCalificacion(){
		return calificaciones.sum()/calificaciones.size()
	}
	method tieneActor(persona) = false
	method tieneDirector(persona) = false
}
class PeliculaSerie inherits Contenido{
	var duracion
	var property director
	var actores = []
	
	override method tieneActor(persona) = actores.contains(persona)
	override method tieneDirector(persona) = persona == director
	method trabajoActor(actor){
		return actores.contains(actor) 
	}
	
	method trabajo(persona){
		return self.trabajoActor(persona) or director == persona
	}
	
}
class Saga inherits Contenido{
	var capitulos = []
	override method agregarCalificacion(estrellas){
		super(estrellas)
		capitulos.forEach({unCap => unCap.calificar(estrellas)})	
	}

	method trabajo(persona){
		return capitulos.any({unCapitulo => unCapitulo.trabajo(persona)})
	}	
	
}
class Usuario{
	var nombre
	var edad
	var contenidoVistas=[]
	var calificaciones = []
	var perfil
	
	method calificar(contenido,calificacion){
		calificaciones.add(new Calificacion(contenido=contenido,calificacion=calificacion) )
		contenido.agregarCalificacion(calificacion)
	}
	method ver(contenido){
		contenidoVistas.add(contenido)
	}
	method mejorPeli(){
		//if(calificacionesVistas.isEmpty())
			//throw new NoHaySugerenciasException()
		return calificaciones.max{calif=>calif.calificacion()}.pelicula()
	}
	method sinCalificar() = calificaciones.isEmpty()
	
	method elegirNoVisto(propuestas) {
		return propuestas.findOrElse(
			{contenido => !contenidoVistas.contains(contenido)},
			{throw new NoHaySugerenciasException()}
		)
	}
	
}
class NoVioNadaException inherits Exception {}
class NoHaySugerenciasException inherits Exception {}
class Calificacion{
	var property contenido
	var property calificacion
}

object flexnit{
	var contenidos = []
	method sinCalificar(){
		return contenidos.filter{peli=>peli.sinCalificar()}
	}
	method contieneDirector(persona){
		return contenidos.filter{peli=>peli.tieneDirector(persona)}
	}
	method contieneActor(persona){
		return contenidos.filter{peli=>peli.tieneActor(persona)}
	}
	method sugerenciaEstandar(contenido){
		return contenidos.take(3)
	}
}
object distinguido{
	method sugerir(contenido){
		return flexnit.contieneDirector(contenido)
	}
}
object fanatico{
	method sugerir(contenido){
		return flexnit.contieneActor(contenido)
	}
}
object aburrido{
	method sugerir(contenido){
		return flexnit.sugerenciaEstandar(contenido)
	}
}
