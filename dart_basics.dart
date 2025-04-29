import 'dart:io';

import 'package:dart_basics/dart_basics.dart' as dart_basics;


void exercise1() {
  /*
    📌 EJERCICIO 1: CALCULADORA DE EDAD

    ✅ Objetivo:
    Escribe un programa en Dart que pida al usuario su año de nacimiento
    y calcule su edad actual.

    🔹 Pasos a seguir:
    1️⃣ Pedir al usuario su año de nacimiento (leerlo como String).
    2️⃣ Convertir el año de nacimiento a un número entero.
    3️⃣ Calcular la edad restando el año de nacimiento al año actual (2025).
    4️⃣ Mostrar el resultado en un mensaje como: "Tienes X años."
  */

  print('Ingrese su año de nacimiento:');
  String anioNacimiento = stdin.readLineSync() ?? '';
  int anioNacimientoInt = int.parse(anioNacimiento);
  int edad = 2025 - anioNacimientoInt;
  print('Tienes $edad años.');
}

void exercise2() {
  /*
    📌 EJERCICIO 2: CALCULADORA DE PROPINA

    ✅ Objetivo:
    Escribe un programa en Dart que calcule cuánto debe pagar cada persona 
    después de dividir la cuenta y agregar una propina.

    🔹 Pasos a seguir:
    1️⃣ Pedir al usuario el total de la cuenta.
    2️⃣ Pedir el porcentaje de propina a agregar.
    3️⃣ Calcular el total a pagar sumando la propina.
    4️⃣ Pedir el número de personas para dividir la cuenta.
    5️⃣ Calcular cuánto debe pagar cada persona.
    6️⃣ Mostrar el resultado en pantalla.
  */

  print('Ingrese el total de la cuenta:');
  String cuenta = stdin.readLineSync() ?? '';
  double totalCuenta = double.parse(cuenta);
  print('Ingrese el porcentaje de propina a agregar:');
  String propina = stdin.readLineSync() ?? '';
  double totalPropina = double.parse(propina);
  totalPropina = totalPropina / 100 * totalCuenta;
  double totalPagar = totalCuenta + totalPropina;

  print('Ingrese el número de personas para dividir la cuenta:');
  int numeroPersonas = int.parse(stdin.readLineSync() ?? '');
  double totalPorPersona = totalPagar / numeroPersonas;
  print('Cada uno tiene que pagar $totalPorPersona euros');

}

void exercise3(){

  /*
    📌 EJERCICIO 3: IDENTIFICAR NÚMEROS POSITIVOS Y NEGATIVOS

    ✅ Objetivo:
    Escribe un programa en Dart que determine si un número ingresado 
    por el usuario es positivo, negativo o cero.
  */
  
  print('Introduce un numero entero: ');
  int n = int.parse(stdin.readLineSync()!);
  if(n > 0){
    print('El numero es positivo');
  }
  else if(n < 0){
    print('El numero es negativo');
  }
  else{
    print('El numero es 0');
  }

}

void exercise4(){

  print('Introduce un numero entero: ');
  int n = int.parse(stdin.readLineSync()!);
  switch(n){
    case 1:
      print('Enero');
      break;
    case 2:
      print('Febrero');
      break;
    case 3:
      print('Marzo');
      break;
    case 4:
      print('Abril');
      break;
    case 5: 
      print('Mayo');
      break;
    case 6:
      print('Junio');
      break;
    case 7:
      print('Julio');
      break;
    case 8:
      print('Agosto');
      break;
    case 9:
      print('Septiembre');
      break;
    case 10:
      print('Octubre');
      break;
    case 11:
      print('Noviembre');
      break;
    case 12:
      print('Diciembre');
      break;
    default:
      print('Mes no valido');
  }
}

void exercise5(){

  /*
    📌 EJERCICIO 5: SUMA DE NÚMEROS PARES EN UNA LISTA

    ✅ Objetivo:
    Escribe un programa en Dart que tome una lista de números enteros 
    y calcule la suma de todos los números pares en la lista.

    🔹 Ejemplo:
    Entrada: [1, 2, 3, 4, 5, 6]
    Salida: La suma de los números pares es: 12

    TIP Si a un número le hacemos %2 == 0 es par.
  */


  List<int> numbers = [2,4,7,4,7,9,1];
  int sumaPares = 0;
  for(int i = 0; i < numbers.length; i++){
    if(numbers[i] % 2 == 0){
      sumaPares += numbers[i];
    }
  }
  print('La suma de los numeros pares es: $sumaPares');
}

void exercise6(){

   /*
    📌 EJERCICIO 6: FILTRAR PALABRAS ÚNICAS EN UN SET

    ✅ Objetivo:
    Escribe un programa en Dart que reciba una lista de palabras con 
    algunas repetidas y almacene solo las palabras únicas en un Set. 
    Luego, muestra el conjunto resultante.

    🔹 Ejemplo:
    Entrada: ["dart", "flutter", "dart", "codigo", "flutter", "movil"]
    Salida: {dart, flutter, codigo, movil}
*/

  List<String> words = [
    "dart",
    "flutter",
    "dart",
    "codigo",
    "flutter",
    "movil"
  ];
  Set<String> result = {};

  for (var element in words) {
    result.add(element);
  }
  print(result);
}

void exercise7(){

  List<String> words = [
    "dart",
    "flutter",
    "dart",
    "codigo",
    "flutter",
    "movil",
    "dart"
  ];

  Map<String, int> NumeroPalabras = {};
  Set<String> palabrasUnicas = {};
  palabrasUnicas.addAll(words);

  for (var element in palabrasUnicas) {
    int contador = 0;
    for (var element2 in words) {
      if(element == element2){
        contador++;
        NumeroPalabras[element] = contador;
      }
    }
  }
  print(NumeroPalabras);

}

void main(List<String> arguments) {
  //exercise1();
  //exercise2();
  //exercise3();
  //exercise4();
  //exercise5();
  //exercise6();
  exercise7();
}

