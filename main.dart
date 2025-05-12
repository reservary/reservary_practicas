import 'dart:math';

void main() {
  Random random = Random();
  double precio = 35.25;
  double propina = 25;
  int personas = random.nextInt(10) + 1; // Número aleatorio entre 1 y 10
  double precioTotal = precio + propina;
  double resultado = precioTotal / personas;
  print("Número de personas: $personas");
  print("Cada uno paga ${resultado.toStringAsFixed(2)}");
}