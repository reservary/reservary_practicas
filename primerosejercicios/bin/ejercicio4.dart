/*
  Ejercicio 4: MESES DEL AÑO

  Objetivo:
  Escribe un programa en Dart que reciba un numero entre 1 y 12
  e imprima el nombre del mes correspondiente del año
*/

import 'dart:io';

void main(List<String> arguments) {
  print('Introduzca un numero entre 1 y 12:');
  int numUsuario = int.parse(stdin.readLineSync()!);
  switch (numUsuario) {
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
      print('Numero invalido');
  }
}
