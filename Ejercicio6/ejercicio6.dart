void main(){
  List<String> words = [];
  words.add("Cosa1");
  words.add("Cosa2");
  words.add("Cosa3");
  words.add("Cosa4");
  words.add("Cosa2");
  words.add("Cosa4");
  print(words);

  Set<String> words2 = Set.from(words);
  print(words2);
}