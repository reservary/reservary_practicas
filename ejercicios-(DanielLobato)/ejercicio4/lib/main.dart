import 'package:flutter/material.dart';

void main() {
  /*
  EJERCICIO 4: MESES DEL AÑO

  Objetivo: Escribe un programa que pida al usuario un numero del 1 al 12 y muestre el mes correspondiente.
  */

  int n = 12;
  switch(n){
    case 1:
      print("Enero");
      break;
    case 2:
      print("Febrero");
      break;
    case 3:
      print("Marzo");
      break;
    case 4:
      print("Abril");
      break;
    case 5:
      print("Mayo");
      break;
    case 6:
      print("Junio");
      break;
    case 7:
      print("Julio");
      break;
    case 8:
      print("Agosto");  
      break;
    case 9:
      print("Septiembre");
      break;
    case 10:
      print("Octubre");
      break;
    case 11:
      print("Noviembre");
      break;
    case 12:
      print("Diciembre");
      break;
    default:
      print("Numero invalido");
  }
}


