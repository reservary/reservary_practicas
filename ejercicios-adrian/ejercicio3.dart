import 'dart:io';

void main() {
  print("Ingrese un numero");
  int num = int.parse(stdin.readLineSync()!);
  if (num > 0) {
    print("El numero es positivo");
  } else if (num < 0) {
    print("El numero es negativo");
  } else {
    print("El numero es cero");
  }
}
