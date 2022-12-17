class Persona{
	var felicidad = 100
	var property emocionDominante //puede variar
	var recuerdosDelDia = []
	var pensamientosCentrales = []
	var pensamientoActual 
	var procesosMentales = []
	var largoPlazo = []
		
	method esAlegre() = felicidad > 500
	
	method convertirPensamientCentral(pensamiento){
		pensamientosCentrales.add(pensamiento) 
	}
	method disminuirFelicidad(porcentaje){
		felicidad = felicidad *( (100- porcentaje)/100)
		
		//if(felicidad<1){ trow new Exception(message = "la perdsona no puede soportar la tristeza")}
		
	}
	method aumentarFelicidad(cantidad){
		felicidad = (felicidad + cantidad).min(1000)
	}
	method tienePensamientoCentral(recuerdo){
		return pensamientosCentrales.contains(recuerdo)
	}
	method tieneLargoPlazo(recuerdo){
		return largoPlazo.contains(recuerdo)
	}
	//punto 1 
	method vivirEvento(unaDescripcion){
		const recuerdo = new Recuerdo(descripcion = unaDescripcion, fecha=new Date(), emocionDominante = emocionDominante)
		recuerdosDelDia.add(recuerdo)	
	}
	//punto 2
	method asentar(recuerdo){
		recuerdo.asentarseEn(self)
	}
	//punto 3
	method ultimosRecuerdos(){
		recuerdosDelDia.reverse().take(5)
	}
	//punto 4
	method pensamientosCentrales() = pensamientosCentrales
	//punto 5 
	method pensamientosDiciles(){
		return pensamientosCentrales.filter({recuerdo=>recuerdo.esDificil()})
	}
	//punto 6
	method niega(recuerdo){
		return emocionDominante.niega(recuerdo)
	} 
	// punto 7
	method dormir(){
		procesosMentales.forEach{ proceso => proceso.desencadenar(self)}
	}
	method asentarRecuerdos(recuerdos){
		recuerdos.forEach{recuerdo=>self.asentar(recuerdo)}
	}
	method recuerdosCon(palabra){
		return recuerdosDelDia.filter{recuerdo=>recuerdo.dice(palabra)}
	}
	method recuerdosProfundos(){
		return recuerdosDelDia.filter{recuerdo=>!self.tienePensamientoCentral(recuerdo) &&
			!self.niega(recuerdo)
		}
	}
	method desequlibrarseEmocionalmente(palabra){
		felicidad *= 0.85
		3.times{i=>pensamientosCentrales.remove{self.pensamientoCentralMasAntiguo()}}
		
	}
	method pensamientCentralMasAntiguo(){
		return pensamientosCentrales.min{p=>p.fecha()}
	}
	method mismaEmocionEnElDia(palabra){
		return recuerdosDelDia.all{recuerdo=>recuerdo.emocionDominante()==recuerdosDelDia.head().emocionDominate()}
	}
	method centralEnLargoPlazo(){
		return pensamientosCentrales.any{recuerdo=>self.tieneLargoPlazo(recuerdo)}
	}
	method liberarRecuerdos(){
		recuerdosDelDia.clear()
	}
	//punto 8
	method rememorar(){
		pensamientoActual = largoPlazo.findOrElse({
			recuerdo=>recuerdo.esRememorable(self)},
			{throw new Exception(message="nada para rememoprar")
		})
	}
	// Rememorar 9
	method repeticionesLargoPlazoDe(recuerdo){
		return largoPlazo.occurrencesOf(recuerdo)
	}
	// Rememorar 10
	method dejaVu(){	
		return self.tieneLargoPlazo(pensamientoActual)
	}
	
}
class Recuerdo {
	
	var property descripcion ="" 
	var fecha = new Date()
	var property emocionDominante
	
	method asentarseEn(nena){
		emocionDominante.consecuenciasEn(nena,self)
	}
	method esDificil(){
		return descripcion.words().size() > 10
	}
	method dice(palabra){
		return descripcion.contains(palabra)
	}
	method esRememorable(nena){
		return (new Date().year() - fecha.year()) > (nena.edad()/2)
	}
	
}

class Emocion {
	method consecuenciasEn(nena,recuerdo){
		// noi hago nada (como es Furia , disgusto, temor
		}
	method niega(recuerdo) = false
	method esAlegre() = false
	
}
class EmocionCompuesta {
	var emociones
	
	method consecuenciasEn(nena,recuerdo){
		// noi hago nada (como es Furia , disgusto, temor
		}
	method niega(recuerdo){
		return emociones.all{emocion=>emocion.niega(recuerdo)}
	}
	method esAlegre(){
		return emociones.any{emocion=>emocion.esAlegre()}
	}
	
}

object asentamiento{
	method desencadenarse(nena){
		nena.asentarRecuerdos(nena.recuerdosDelDia())
	}
}

class AsentamientoSelectivo{
	var palabra
	method desencadenarse(nena){
		nena.asentarRecuerdos(nena.recuerdosCon(palabra))
	}
}
object profundizacion {
	method desencadenarse(nena){
		nena.agregarLargoPlazo(nena.recuerdosProfundos())
	}
}

object controlHormonal {
	method desencadenarse(nena){
		if(nena.mismaEmocionEnElDia() || nena.centralEnLargoPlazo())
			nena.desequilibrarseHormonalmente()
	}
}

object restauracionCognitiva{
	method desencadenarse(nena){
		nena.aumentarFelicidad(100)
	}
}

object liberacionDeRecuerdos{
	method desencadenarse (nena){
		nena.liberarRecuerdos()
	}
}
