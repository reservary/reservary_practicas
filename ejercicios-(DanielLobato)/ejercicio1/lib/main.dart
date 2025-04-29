
import 'package:flutter/material.dart';


void main() {
  /*
  Ejercicio 1: Calculadora
  Escribe un programa en Dart que pida al usuario su año de nacimiento y calcule su edad actual.

  Pasos:
  1. Pide al usuario su año de nacimiento(como String).
  2. Convertir el año de nacimiento a n numero entero.
  3.Calcular la edad restando el año de nacimiento a el año actual(2025).
  4. Mostrar el resultado.
  */

  String fechaString = "2003";
  int fechaActual = 2025;
  int fecha = int.parse(fechaString);
  int edad = fechaActual - fecha;
  print("Tienes $edad años");
  if (edad >= 18) {
    print("Eres mayor de edad");
  } else {
    print("Eres menor de edad");
  }

}





