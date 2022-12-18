class Planeta{
	var habitantes
	method poderPlaneta(){
		return habitantes.sum{hab=>hab.poder()}
	}
	method poseeOrden(){
		return self.masPoderosos() >= self.poderPlaneta() / 2
	}
	method masPoderoso(){
		return habitantes.shortedBy{hab1,hab2=>hab1.poder()>=hab2.poder()}.take(3)
	}
	
}
class Habitantes{
	var valentia
	var inteligencia
	method poder() = valentia + inteligencia
}
class Soldados inherits Habitantes{
	var equipamiento = []
	override method poder(){
		return super() + equipamiento.filter{arma=>arma.esUtil()}.sum({arma=>arma.poder() })
	}
	method tomar(algo){
		equipamiento.add(algo)
	}
}
class Maestros inherits Habitantes{
	var midiclorianos
	var tipoFuerza 
	var sable
	
	override method poder(){
		return super() + midiclorianos/1000 + tipoFuerza.poder(sable)
	}
	//method vivirSuceso(suceso) {
		//ladoFuerza.vivirSuceso(suceso, self)
	//}
}
class Fuerza{
	var antiguedad
	method pasarTiempo(){
		antiguedad += 1
	}
	method vivirSuceso(){
		self.pasarTiempo()
		self.aceptarSuceso(suceso, maestro)
	}
	method aceptarSuceso(suceso, maestro)
}
class fuerzaluminosa inherits Fuerza{
	var fuerzaPaz = 1000
	method poder(sable){
		return sable.potencia() * antiguedad
	}
	method aceptarSuceso(suceso, maestro){
		self.alterarPazInterior(suceso.cargaEmocional())
		if(self.sinPaz()) 
			maestro.ladoFuerza(new FuerzaOscura()) 	
	}
	method sinPaz() = fuerzaPaz <= 0
	method alterarPazInterior(valor) {
		fuerzaPaz += valor	
	}
}
class FuerzaOscura inherits Fuerza{
	var odio
	method poder(sable){
		return sable.potencia() * 2 + antiguedad
	}
	method aceptarSuceso(suceso, maestro){
		if(suceso.cargaEmocional() > odio) 
			maestro.ladoFuerza(new Fuerzaluminoso())	
		else 
			self.aumentarOdio()
	}
	method aumentarOdio() {
		odio = odio * 1.1	
	}
}
class Sucesos{
	var property cargaEmocional
}
class Armas{
	var property potencia
	var disponible = true
	method esUtil() = potencia > 10 && disponible
	method usar() {
		disponible = false
	}
	method reparar() {
		disponible = true
	}
}