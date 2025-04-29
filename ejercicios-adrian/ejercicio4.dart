import 'dart:io';

void main() {
  print("Ingrese el numero de su mes: ");
  int mes = int.parse(stdin.readLineSync()!);
  switch (mes) {
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
      print("Mes invalido");
  }
}
