void main() {
  var lista = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13];
  int resultado = 0;
  for (int i = 0; i < lista.length; i++) {
    if (lista[i] % 2 == 0) {
      resultado += lista[i];
    }
  }
  print("La suma de los numeros pares es: $resultado");
}
