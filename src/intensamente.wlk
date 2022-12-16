object riley{
	var felicidad = 100
	var emocionDominante 
	var recuerdosDelDia = []
	var pensamientoCentral
	
	method esAlegre() = felicidad > 500
	
	method convertirPensamientCentral(pensamiento){
		pensamientoCentral = pensamiento
	}
	method disminuirFelicidad(porcentaje){
		felicidad = felicidad *( (100- porcentaje)/100)
		
		//if(felicidad<1){ trow new Exception(message = "la perdsona no puede soportar la tristeza")}
		
	}
	method aumentarFelicidad(cantidad){
		felicidad = (felicidad + cantidad).min(1000)
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
	
}
class Recuerdo {
	
	var descripcion 
	var fecha 
	var emocionDominante
	
	method asentarseEn(nena){
		emocion.consecuenciasEn(nena,self)
	}
	
}

class Emocion {
	method consecuenciasEn(nena,recuerdo){
		// noi hago nada (como es Furia , disgusto, temor
		}
	
}
