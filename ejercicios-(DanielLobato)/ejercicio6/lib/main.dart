import 'package:flutter/material.dart';

void main() {
  /*
  EJERCICIO 6: FILTRAR PALABRAS UNICAS EN UN SET

  Objetivo:
  Escribe un programa dart que reciba una lista de palabras con algunas repetidas y almacene solo las palabras unicas en un set.
  Luego, muestra el set resultante.
  */

  List<String> palabras = ["manzana", "naranja", "manzana", "banana", "uva", "naranja", "manzana"];
  filtrador(palabras);
}
 void filtrador(List<String> palabras){
  Set<String> palabrasUnicas = palabras.toSet();
  print(palabrasUnicas);
  
 }

