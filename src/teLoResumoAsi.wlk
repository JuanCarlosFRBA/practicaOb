class Resumen{
	var introduccion 
	var secciones=[]
	method agregar(seccion){
		secciones.add(seccion)
	}
	method duracionIntroduccion(){
		return introduccion.words().size()
	}	
	method duracionResumen(){
		return self.duracionIntroduccion() + secciones.sum{sec=>sec.duracion()}
	}
	method tieneCancion(cancion){
		return secciones.any{sec=>sec.tieneCancion(cancion)}
	}
	method tieneReferenciaResumen(resumen) = secciones.any{sec=>sec.tieneResumen(resumen)}
	method libreto(){
	return introduccion + ". " + secciones.map{ seccion => seccion.speech() }.join(". ")
	}
		
	
	
}
class Seccion{
	var property duracion
	var property speech
	method tieneCancion(cancion)=false
	method tieneResumen(cancion)=false
	method tieneReferencia(cancion)=false
}
class Musicalizado inherits Seccion{//
	var cancion
	method tieneCancion(tema) = cancion == tema
}
class Referenciada inherits Seccion{
	var referencia
	override method duracion(){
		return super()+referencia.duracion()
		}
	override 0method tieneResumen(resumen)= referencia == resumen
	override method tieneReferencia(cancion)=true
	override method speech(){
		return super()+" . "+referencia.speech()
	} 
}
class Espectador{
	var property duracionSoportada = 600
	var property tipo
	const property cancionesFavoritas = #{}
	const resumenesPendientes = #{}
	const resumenesVistos = #{}
	
	method leGusta(resumen){
		return resumen.duracion()<duracionSoportada && tipo.requisito(resumen,self)
	}
}
object nuevos{
	method requisito(resumen,espectador) = true
}
object followers{
	method requisito(resumen,espectador){
		return espectador.cancionesFavoritas().any{cancion=>resumen.tieneCancion(cancion)}
	}
}
object fans{
	method requisito(resumen,espectador){
		return self.tieneTodasLasCancionesFavoritas(resumen, espectador) && self.referenciaAOtroResumen(resumen)
	}

	method tieneTodasLasCancionesFavoritas(resumen, espectador) = espectador.cancionesFavoritas().all{ cancion => resumen.tieneCancion(cancion) }

	method referenciaAOtroResumen(resumen) = resumen.tieneReferencia()
	/*
	 method duracionAcorde(resumen) {
		return resumen.duracion() <= duracionSoportada
	}

	method agregarCancionFavorita(cancion) {
		cancionesFavoritas.add(cancion)
	}
	
	method marcarComoPendiente(resumen) {
		resumenesPendientes.add(resumen)
	}
	
	method esAdicto(resumenes) = resumenesVistos.size() / resumenes.size() > 0.8
	
	method ver(resumen){
		resumenesVistos.add(resumen)
		
		if (self.leGusta(resumen)) {
			resumen.darLike()
		} else {
			resumen.darDislike()
		}
	}
	 */
}
class ResumenAsiNomas inherits Resumen {

	const property resumenes = #{}
	var property factorDeVelocidad

	override method duracionResumen() {
		return super() * factorDeVelocidad
	}

}
/*
 object canalYoutube {

	const suscriptores = #{}
	const resumenes = #{}

	method agregarSuscriptor(suscriptor) {
		suscriptores.add(suscriptor)
	}

	method agregarResumen(resumen) {
		const suscriptoresQueGustan = self.suscriptoresQueGustan(resumen)
		if (not suscriptoresQueGustan.isEmpty()) {
			resumenes.add(resumen)
			suscriptoresQueGustan.forEach {suscriptor => suscriptor.marcarPendiente(resumen)}
		} else {
			self.error('El resumen es una cagada')
		}
	}
	
	method suscriptoresQueGustan(resumen) = suscriptores.filter {suscriptor => suscriptor.leGusta(resumen)}
	
	method suscriptoresAdictos() = suscriptores.filter {suscriptor => suscriptor.esAdicto(resumenes)}
	
	method cancionesSolicitadas() = suscriptores.flatMap {suscriptor => suscriptor.cancionesFavoritas()}.asSet()
	
	method resumenConMasLikes() = resumenes.max {resumen => resumen.likes() }
	
	method resumenConMasDislikes() = resumenes.max {resumen => resumen.dislikes() }
}

 
 */