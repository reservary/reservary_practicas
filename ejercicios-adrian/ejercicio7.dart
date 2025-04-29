void main() {
  List<String> palabras = [
    "Hola",
    "Mundo",
    "Dart",
    "Programacion",
    "Dart",
    "Programacion",
    "Mundo",
    "Dart",
  ];
  Map<String, int> conteo = {};
  for (String palabra in palabras) {
    if (conteo.containsKey(palabra)) {
      conteo[palabra] = conteo[palabra]! + 1;
    } else {
      conteo[palabra] = 1;
    }
  }
  print(conteo);
}
