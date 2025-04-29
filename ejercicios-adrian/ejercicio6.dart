void main() {
  List<String> lista = [
    "Juan",
    "Maria",
    "Pedro",
    "Ana",
    "Luis",
    "Luis",
    "Juan",
    "Ivan",
    "Roberto",
  ];
  Set<String> noRepetir = lista.toSet();
  print(noRepetir);
}
