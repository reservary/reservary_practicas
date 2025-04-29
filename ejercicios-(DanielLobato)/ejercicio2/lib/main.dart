import 'package:flutter/material.dart';

void main() {
  /*
  EJERCICIO 2: CALCULADORA DE PROPINA

  Objetivo: 
  Escribe un programa en Dart que calcule cuanto debe pagar cada persona despues de divisir la cuenta y agregar una propina

  Pasos:
  1. Pedir al usuario el total de la cuenta.
  2. Pedir el porcentaje de propina a agregar.
  3. Calcular el total a pagar sumando la propina.
  4. Pedir el numero de personas.
  5. Calcular cuanto debe pagar cada persona.
  6. Mostrar el resultado.
  */

  double precio = 99.99;
  double propina = 10;
  int personas = 6;
  double precioTotal = precio + propina;
  double resultado = precioTotal / personas;
  print("Cada persona debe pagar ${resultado.toStringAsFixed(2)}");


}






 
