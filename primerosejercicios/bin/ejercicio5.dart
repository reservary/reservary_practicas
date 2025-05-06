/*
  Ejercicio 5: SUMA DE NUMEROS PARES EN UNA LISTA
  Objetivo:
  Escribe un programa en Dart que tome una lista de números enteros
  y calcule la suma de todos los números pares en la lista.

 */
void main() {
  List<int> lista = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  print('La suma de los numeros pares es ${sumaPares(lista)}');

}

int sumaPares(List<int> lista) {
  int suma = 0;
  for (int num in lista) {
    if(num%2==0){
      suma+=num;
    }
  }
  return suma;
}
