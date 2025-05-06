/*
  Ejercicio 7: CONTAR LA FRECUENCIA DE PALABRAS EN UN MAP
  Objetivo:
  Escribe un programa en Dart que reciba una lista de palabras y cuente cúantas 
  veces aparece cada una, almacenando el resultado en un Map
*/
void main(){
  //Mi solucion
  int contDart=0;
  int contFlutter=0;
  int contCodigo=0;
  int contMovil=0;
  List<String> palabras=["dart","flutter","dart","codigo","flutter","movil","dart"];
  for(String p in palabras){
    if(p.contains("dart")){
      contDart++;
    }
    if(p.contains("flutter")){
      contFlutter++;
    }
    if(p.contains("codigo")){
      contCodigo++;
    }
    if(p.contains("movil")){
      contMovil++;
    }
  }
  Map<String,int> frecuencia={"dart":contDart,"flutter":contFlutter,"codigo":contCodigo,"movil":contMovil};
  print(frecuencia);
  //Solución video
  Map<String,int> resultado={};
  for(String p in palabras){
    if(resultado.containsKey(p)){
      resultado[p] = resultado[p]! + 1;
    }else{
      resultado[p]=1;
    }
  }
}

