import Foundation

final class RetoCaso {

	// Atributos
	//---
	private var numArray: [String] = []

	// Propiedad computada
	private var numAscendente: Int {
		var num: String = ""
	    for caracter in numArray.sorted() {
	    	if caracter == "0" {
	    		num = num + "0"
	    	} else {
	    		num = num + caracter
	    	}
	    }
	    return Int(String(num.reversed()))!
	}
	// Propiedad computada
	private var numDescendente: Int {
		var num: String = ""
	    for caracter in numArray.sorted() {
	    	if caracter == "0" {
	    		num = num + "0"
	    	} else {
	    		num = num + caracter
	    	}
	    }
	    return Int(num)!
	}

	// Métodos
	//---
	
	// Método que se encarga de leer el número de casos que va a analizar el programa en total
	private func leerNumCasos() -> Int {
	
		while true {
			if let entrada: String = readLine(),
			let numCasos: Int = Int(entrada),
			numCasos > 0 {
				return numCasos
			} else {
				print("Error de formato. Introduce un número entero positivo, el cual representará el número de casos posteriores que quieres introducir.")
			}
		}
	
	}
	
	// Método encargado de leer los números de cuatro dígitos del usuario
	private func leerEntrada() {
	
		while true {
			if let entrada: String = readLine(),
			entrada.count == 4,
			let _ : Int = Int(entrada) {
				for numero in entrada {
					numArray.append(String(numero))
				}
				break
			} else {
				print("Error de formato. Introduce un número entero de cuatro dígitos. Ejemplo: 1342 o 0009.")
			}
		}
	
	}
	
	// Método que se ocupa de verificar si el número introducido por el usuario es un repdigit (aquellos cuyas cuatro cifras son iguales)
	private func esRepdigit() -> Bool {
		if numArray[0] == numArray[1], numArray[1] == numArray[2], numArray[2] == numArray[3] {
			return true
		} else {
			return false
		}
	}
	
	// Método que se encarga de verificar si el número introducido por el usuario es la propia constante de Kaprekar
	private func esConstanteKaprekar() -> Bool {
		if numArray[0] == "6", numArray[1] == "1", numArray[2] == "7", numArray[3] == "4" {
			return true
		} else {
			return false
		}
	}
	
	// Método que resta las dos propiedades computadas y devuelve el resultado
	private func calculoResta() -> Int {
		return numAscendente - numDescendente
	}
	
	// Método que se ocupa de limpiar el array que almacena los dígitos de los resultados y, seguidamente, de rellenar el array con un nuevo resultado
	private func reiniciarArrayYCargar(_ resultadoResta: Int) {
		// Elimina todos los elementos del array
		numArray.removeAll()
		
		// Rellenamos con 0s el array si el resultado tiene menos de 4 dígitos
		if String(resultadoResta).count == 3 {
			numArray.append("0")
		} else if String(resultadoResta).count == 2 {
			numArray.append("0")
			numArray.append("0")
		} else if String(resultadoResta).count == 3 {
			numArray.append("0")
			numArray.append("0")
			numArray.append("0")
		}
		// Volvemos a cargar nuestro array con el nuevo número, resultado de la resta
		for numero in String(resultadoResta) {
			numArray.append(String(numero))
		}
		
	}
	
	// Método donde se aplica la lógica principal del programa
	func caso() {
	
		let numCasos: Int = leerNumCasos()
		
		for _ in 1...numCasos {
			
			var contadorIteraciones: Int = 0
			leerEntrada()
			if esRepdigit() {
				contadorIteraciones = 7
				numArray.removeAll()
			} else if esConstanteKaprekar() {
				contadorIteraciones = -1
				numArray.removeAll()
			} else {
				var finCaso: Bool = false
				while !finCaso {
					let resultado: Int = calculoResta()
					if resultado != 6174 {
						contadorIteraciones += 1
						reiniciarArrayYCargar(resultado)
					} else {
						numArray.removeAll()
						finCaso = true
					}
				}
			}
			
			print(contadorIteraciones + 1)
			
		}
	
	}

}

// Main
var reto: RetoCaso = RetoCaso()
reto.caso()