import 'package:calculadora_imc/nucleo/app_colores.dart';
import 'package:calculadora_imc/nucleo/text_styles.dart';
import 'package:flutter/material.dart';

class SelectorNumero extends StatefulWidget {
  final String titulo;
  final int value;
  final Function() onDecrement;
  final Function() onIncrement;


  const SelectorNumero({super.key, required this.titulo, required this.value, required this.onDecrement, required this.onIncrement});

  @override
  State<SelectorNumero> createState() => _SelectorNumeroState();
}

class _SelectorNumeroState extends State<SelectorNumero> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColores.fondoComponentes,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(widget.titulo, style: TextStyles.bodyText,),
            Text(widget.value.toString(),style: TextStyles.numeros,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  heroTag: null,
                  onPressed:(){widget.onDecrement();}, 
                  shape: CircleBorder(), 
                  backgroundColor: AppColores.componenteSeleccionado, 
                  child: Icon(Icons.remove, color: Colors.white,)),
                SizedBox(width: 10),
                FloatingActionButton(
                  heroTag: null,
                  onPressed:(){widget.onIncrement();}, 
                  shape: CircleBorder(), 
                  backgroundColor: AppColores.componenteSeleccionado, 
                  child: Icon(Icons.add, 
                  color: Colors.white,)),
              ],
            )
          ],
        ),
      ),
    );
  }
}