import 'package:calculadora_imc/nucleo/app_colores.dart';
import 'package:calculadora_imc/nucleo/text_styles.dart';
import 'package:flutter/material.dart';


class SelectorAltura extends StatefulWidget {
  final double alturaSeleccionada;
  final Function(double) cambiarAltura;

  const SelectorAltura({super.key, required this.alturaSeleccionada, required this.cambiarAltura});

  @override
  State<SelectorAltura> createState() => _SelectorAlturaState();
}

class _SelectorAlturaState extends State<SelectorAltura> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColores.fondoComponentes,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("ALTURA", style: TextStyles.bodyText),
            ),
            Text("${widget.alturaSeleccionada.toStringAsFixed(0)} cm", style: TextStyles.numeros, ),
            Slider(value: widget.alturaSeleccionada, onChanged:(nuevaAltura){        
                widget.cambiarAltura(nuevaAltura);
              }, 
            min: 100, 
            max: 250, 
            divisions: 150,
            label: "${widget.alturaSeleccionada.toStringAsFixed(0)} cm",
            activeColor: AppColores.componenteSeleccionado,
            
            ),
          ],
        ),
      ),
    ); 
    
  }
}

