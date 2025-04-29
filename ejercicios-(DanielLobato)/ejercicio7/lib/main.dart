import 'package:flutter/material.dart';

void main() {
  /*
  EJERCICIO 7: CONTAR LA FRECUENCIA DE PALABRAS EN UN MAP

  Objetivo:
  Escribe un programa dart que reciba una lista de palabras y cuente la frecuencia de cada palabra en un mapa.
  */
  
  List<String> palabras = ["manzana", "naranja", "manzana", "banana", "uva", "naranja", "manzana"];
  frecuencia(palabras);
}

void frecuencia(List<String> palabras){
  Map<String, int> frecuencia = {};
  for(int i = 0; i < palabras.length; i++){
    if(frecuencia.containsKey(palabras[i])){
      frecuencia[palabras[i]] = frecuencia[palabras[i]]! + 1;
    }else{
      frecuencia[palabras[i]] = 1;
    }
  } 
  print(frecuencia);
}

