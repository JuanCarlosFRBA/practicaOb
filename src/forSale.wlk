class Inmueble{
	var tamanio
	var ambientes
	var zona
	method valor() = zona.valor()
}
class Zona {
	var valor
	
	method valor() = valor
	method valor(nuevoValor){
		valor = nuevoValor
	}
}

class Casa inherits Inmueble{
	var valor
	override method valor() = super() +  valor
}
class Ph inherits Inmueble{
	
	override method valor() {
		return super() + (14000 * tamanio).max(500000)
	}
}
class Departamento inherits Inmueble{
	
	override method valor() {
		return super() + 350000 * ambientes
	}
}
class Empleado{
	var nombre
	var comisiones = []
}	
object Inmobiliaria{
	var comision
	var empleados
	
}
	
	}