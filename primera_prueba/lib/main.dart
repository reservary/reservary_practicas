import 'package:flutter/material.dart';

void main() {
  /*
  print("Hola mundo");

  var name = "Daniel";
  var edad = 21;

  print(name + " " + edad.toString());
  */

  print("Hola mundo");

  String name = "Daniel";
  int edad = 21;

  print(name + " " + edad.toString());

  String fullText = "Soy $name y tengo $edad años";

  print(fullText);

  fullText = "Me llamo " + name + " y tengo " + edad.toString() + " años";
  
  print(fullText);

  bool soyFeliz = false;
  dynamic ejemplo = "Ejemplo";

  if (soyFeliz == true) {   
    ejemplo = "Hola";
  } else {
    ejemplo = 0;
  }

  print(ejemplo);
  
  /*
  String numero = "26";
  int n = int.parse(numero);

  int n2 = 2;
  String numero2 = n2.toString();
  */

  int n1 = 3;
  int n2 = 2;

  int suma = n1 + n2;
  int resta = n1 - n2;
  int multiplicacion = n1 * n2;
  double division = n1 / n2;
  int division2 = n1 ~/ n2;
  int resto = n1 % n2;

  print("La suma es $suma");
  print("La resta es $resta");
  print("La multiplicacion es $multiplicacion");
  print("La division es $division");
  print("La division sin decimales es $division2");
  print("El resto es $resto");

  int n3 = 10;
  
  print(n3);
  print(n3++);
  print(++n3);
  
}

