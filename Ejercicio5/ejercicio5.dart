void main(){
  
    List<int> numeros = [1,2,3,4,5,6,7,8,9,10];

int contador=0;
int sumanumeros=0;

while(contador<numeros.length){
if(numeros[contador]%2==0){
sumanumeros=sumanumeros+numeros[contador];
print(sumanumeros);
}
contador++;
}
print("La suma final es $sumanumeros");
}