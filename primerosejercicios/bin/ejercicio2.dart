/*
  Ejercicio 2: CALCULADORA DE PROPINA
  Objetivo:
  Escribe un programa en Dart que calcule cuánto debe pagar cada persona
  después de dividir la cuenta y agregar una propina
  
  Pasos a seguir:
  1.Pedir al usuario el total de la cuenta
  2.Pedir el porcentaje de propina a agregar
  3.Calcular el total a pagar sumando la propina
  4.Pedir el número de personas para dividir la cuenta
  5.Calcular cúanto debe pagar cada persona
  6.Mostrar el resultado en pantallla
  
*/
import 'dart:io';

void main(List<String> arguments) {
  print('Introduzca el total de la cuenta:');
  double cuenta = double.parse(stdin.readLineSync()!);
  print('Introduzca el porcentaje de propina:');
  double propina = double.parse(stdin.readLineSync()!);

  double totalPropina = 1 + (propina / 100);
  double totalCuenta = cuenta * totalPropina;

  print("El total a pagar es: ${totalCuenta.toStringAsFixed(2)}");
  print('Introduzca el número de personas:');
  int personas = int.parse(stdin.readLineSync()!);
  double pagoPorPersona = totalCuenta / personas;
  print('Cada persona debe pagar ${pagoPorPersona.toStringAsFixed(2)} euros');
}
