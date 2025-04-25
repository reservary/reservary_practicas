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

void main(List<String> arguments) {
  exercise1();
  exercise2();
}

