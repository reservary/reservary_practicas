void main(){
  List<String> palabras = [];
  palabras.add("casa");
  palabras.add("coche");
  palabras.add("casa");
  palabras.add("delfin");
  palabras.add("casa");
  palabras.add("coche");
  palabras.add("alfredo");
  palabras.add("cosa");

  print(palabras);

  Map<String,int> conteo = {};

  for (var palabra in palabras){
    if(conteo.containsKey(palabra)){
      conteo[palabra] = conteo[palabra]! +1;
    }else{
      conteo[palabra] = 1;
    }
  }
print(conteo);
}