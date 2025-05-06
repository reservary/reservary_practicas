/*
  Ejercicio 6: FILTRAR PALABRAS ÚNICAS EN UN SET
  Objetivos:
  Escribe un programa en Dart que reciba una lista de palabras con 
  algunas repetidas y almacene solo las palabras únicas en un set.
  Luego, muestra el conjunto resultante.
*/
void main(){
  List<String> palabras = ["Hola", "Hola", "Mundo", "Mundo", "Dart"];
  Set<String> palabrasUnicas = filtrarPalabras(palabras);
  print(palabrasUnicas);
}

Set<String> filtrarPalabras(List<String> palabras){
  Set<String> palabrasUnicas = {};
  palabrasUnicas=Set.from(palabras);
  return palabrasUnicas;
}
