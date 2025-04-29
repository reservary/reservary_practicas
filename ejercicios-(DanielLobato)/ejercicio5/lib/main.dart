import 'package:flutter/material.dart';

void main() {
  /*
  EJERCICIO 5: SUMA DE NUMEROS PARES EN UNA LISTA

  Objetivo:
  Escribe un programa dart que tome una lista de numeros enteros y calcule la suma de los numeros pares.
  */

  List<int> lista = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  calculadora(lista);
  
}

void calculadora(List<int> lista){
  int suma = 0;
  for(int i = 0; i < lista.length; i++){
    if(lista[i] % 2 == 0){
      suma += lista[i];
    }
  }
  print("La suma de los numeros pares es: $suma");
}


