import 'dart:io';

/*
  Ejercicio 1: CALCULADORA DE EDAD
  Objetivo:
  Escribe un programa en DArt que pida al usuario su año de nacimiento
  y calcule su edad actual.

  Pasos a seguir:
  1.Pedir al usuario su año de nacimiento(leerlo como String)
  2.Convertir el año de nacimiento a un número entero
  3.Calcular la edad restando el año de nacimiento al año actual
  4.Mostrar el resultado en un mensaje como : "Tienes X años."
*/
void main(List<String> arguments) {
  print("Introduzca su año de nacimiento:");

  String anioNacimiento = stdin.readLineSync()!;

  String anioActual = "2025";

  int edad = int.parse(anioActual) - int.parse(anioNacimiento);

  print("Tienes $edad años.");
}
