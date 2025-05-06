/*
  Ejercicio 3: IDENTIFICAR NÚMEROS POSITIVOS Y NEGATIVOS

  Objetivo:
  Escribe un programa en Dart que determine si un número ingresado
  por el usuario es positivo,negativo o cero.
*/
  import 'dart:io';

void main(List<String> arguments) {
    print('Introduzca un numero');
    int numUsuario= int.parse(stdin.readLineSync()!);
    if(numUsuario>0){
      print('El numero es positivo');
    }else if(numUsuario<0){
      print('El numero es negativo');
    }else{
      print('El numero es cero');
    }

    //Operador ternario
    print("Prueba operador ternario");
    String resultado= numUsuario>0 ? 'El numero es positivo': numUsuario<0 ? 'El numero es negativo': 'El numero es cero';
    print(resultado);
  }
