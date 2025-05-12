import 'dart:math';
void main(){

Random random = Random();
int numero = random.nextInt(12)+1;
print(numero);
String mes="";
if(numero==1)
mes="Enero";
if(numero==2)
mes="Febrero";
if(numero==3)
mes="Marzo";
if(numero==4)
mes="Abril";
if(numero==5)
mes="Mayo";
if(numero==6)
mes="Junio";
if(numero==7)
mes="Julio";
if(numero==8)
mes="Agosto";
if(numero==9)
mes="Septiembre";
if(numero==10)
mes="Octubre";
if(numero==11)
mes="Noviembre";
if(numero==12)
mes="Diciembre";

print("Estamos en "+ mes);
}