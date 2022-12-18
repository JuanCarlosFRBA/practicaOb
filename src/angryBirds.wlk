/////////pajaros//////////////
class Pajaros{
	var ira
	method enojarse(){
		ira *= 2		
	}
	method fuerza() = ira * 2 
	method tranquilizarse(){
		ira -= 5
	}
	method puedeDerribar(obstaculo){
		return self.fuerza() > obstaculo.resistencia()
	}
}
class Red inherits Pajaros{
	var cantEnojo
	override method fuerza() = ira * 10 * cantEnojo
}
class Bomb inherits Pajaros{
	var topeMax = 9000
	override method fuerza(){
		return topeMax.min(super()) 
	}
	method cambiarTopeMax(nro){
		topeMax = nro
	}
}
class Chuck inherits Pajaros{
	var velocidad
	override method fuerza(){
		if(velocidad <=80){
			return 150
		}else {return 150 + 5 * (velocidad-150)}
	}
	override method enojarse(){
		velocidad *= 2
	}
	override method tranquilizarse() {}
}

class Terence inherits Pajaros{
	var cantEnojo
	var multiplicador
	override method fuerza(){
		return ira * cantEnojo * multiplicador
	}	
}
class Matilda inherits Pajaros{
	var huevos = []
	override method fuerza(){
		return super( )+ huevos.sum{huevo=>huevo.fuerza()}
	}
	override method enojarse(){
		self.ponerDosHuevos()
	}
	method ponerDosHuevos(){
		huevos.add(new Huevo(peso = 2))
		huevos.add(new Huevo(peso = 2))
	}
	
}
class Huevo{
	var peso 
	method fuerza() = peso
}
///////////////isla//////////////
class IslaPajaro{
	var pajaros
	method agregar(pajaro){
		pajaros.add(pajaro)
	}
	method pajarosFuertes(){
		return pajaros.filter{pajaro=>pajaro.fuerza() > 50}
	}
	method fuerza(){
		self.pajarosFuertes().sum{pajaro=>pajaro.fuerza()}
	}
	method sucedeEvento(evento){
		pajaros.forEach{pajaro => evento.aplicarEvento(pajaro)}
	}
	method atacarIsla(isla){
		pajaros.forEach{pajaro=>isla.recibirAtaque(pajaro)}
	}
}
/////////////eventos///////////
object manejoIra{
	method aplicarEvento(pajaro){
		pajaro.tranquilizarse()
	}
}
object invasionCerdito{
	var cerditos
	method aplicarEvento(pajaro){
		var cada100 = (cerditos/100).round()
		cada100.times{i=>pajaro.enojarse()}
	}
}
object fiestaSorpresa{
	var homenajeados
	method aplicarEvento(pajaro){
		if(homenajeados.contains(pajaro)){
		pajaro.enojarse()}else if (homenajeados.isEmpty()){
			throw new Exception(message="no hay fiesta sorpresa")
		}
	}
}
object desafortunados{
	var eventos = []
	method aplicarEvento(pajaro){
		eventos.forEach{evento=>evento.aplicarEvento(pajaro)}
	}
}
/////////////islaCerdito/////////
object islaCerdito{
	var obstaculos=[]
	method agregarObstaculos(obstaculo){
		obstaculos.add(obstaculo)
	}
	method recibirAtaque(pajaro){
		var obstaculo= obstaculos.head()
		if(pajaro.puedeDerribar(obstaculo) && !self.libreObtaculos()){
			obstaculos.remove(obstaculo)
		}
	}
	method libreObtaculos(){
		return obstaculos.isEmpty()
	}
	
}
//////////////Obstaculos///////////
class Pared{
	var ancho
	method resistencia() = ancho
	
}
class Vidrio inherits Pared{
	override method resistencia() = super() * 10
}
class Madera inherits Pared{
	override method resistencia() = super() * 25
}
class Piedra inherits Pared{
	override method resistencia() = super() * 50
}
object cerditosObreros{
	method resistencia() = 50
}
class CerditosArmados{
	var proteccion
	method resistencia() = 10 * proteccion.resistencia()
}
class Proteccion {
	var property resistencia
}