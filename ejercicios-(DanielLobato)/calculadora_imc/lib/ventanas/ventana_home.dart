import 'package:calculadora_imc/componentes/selector_altura.dart';
import 'package:calculadora_imc/componentes/selector_genero.dart';
import 'package:calculadora_imc/componentes/selector_numero.dart';
import 'package:calculadora_imc/nucleo/app_colores.dart';
import 'package:calculadora_imc/ventanas/ventana_resultado.dart';
import 'package:flutter/material.dart';

class VentanaHome extends StatefulWidget {
  const VentanaHome({super.key});

  @override
  State<VentanaHome> createState() => _VentanaHomeState();
}

class _VentanaHomeState extends State<VentanaHome> {
  int edadSeleccionada = 18;
  int pesoSeleccionado = 70;
  double alturaSeleccionada = 170;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SelectorGenero(),
          SelectorAltura(alturaSeleccionada: alturaSeleccionada, cambiarAltura:(nuevaAltura){
            setState(() {
              alturaSeleccionada = nuevaAltura;
            });
          } ,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(child: SelectorNumero(titulo: "PESO", value: pesoSeleccionado, 
                onDecrement:(){
                  setState(() {
                    pesoSeleccionado--;
                  });

                } ,
                onIncrement: () {
                  setState(() {
                    pesoSeleccionado++;
                  });
                })),
                SizedBox(width: 10),
                Expanded(child: SelectorNumero(titulo: "EDAD", value: edadSeleccionada, 
                onDecrement:(){
                  setState(() {
                    edadSeleccionada--;
                  });
                },onIncrement: () {
                  setState(() {
                    edadSeleccionada++;
                  });
                })),
                
              ],
            ),
          ),
        
        Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed:(){
                Navigator.push(context, MaterialPageRoute(builder: (context) => VentanaResultado(peso: pesoSeleccionado, altura: alturaSeleccionada)));
              }, 
              style:ButtonStyle(backgroundColor: WidgetStateProperty.all(AppColores.componenteSeleccionado)),
              child: Text("Calcular", style: TextStyle(color: Colors.white),))),
        ),
        ],
      ),
    );
  }
}