
import 'dart:math';

void main() {
  Random random = Random();
  int moneda = random.nextInt(2);
  int numero = random.nextInt(10);
  int n=0;
  if(moneda==1){
    n = numero-(numero*2);
  }else{
    n = numero;
  }
  print(n);
  if(n<0){
    print("El numero es negativo");
  }else if(n>0){
    print("El numero es positivo");
  }else{
    print("El numero es cero");
  }
}