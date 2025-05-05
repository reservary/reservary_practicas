import 'package:calculadora_imc/nucleo/app_colores.dart';
import 'package:calculadora_imc/nucleo/text_styles.dart';
import 'package:flutter/material.dart';

class SelectorGenero extends StatefulWidget {
  const SelectorGenero({super.key});

  @override
  State<SelectorGenero> createState() => _SelectorGeneroState();
}

class _SelectorGeneroState extends State<SelectorGenero> {
  String? generoSeleccionado;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                generoSeleccionado = 'hombre';
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: generoSeleccionado == 'hombre' 
                  ? AppColores.componenteSeleccionado 
                  : AppColores.fondoComponentes, 
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column( //Hombre
                    children: [
                      Image.asset('assets/imagenes/hombre.png', width: 100, height: 100),
                      Text('Hombre', style: TextStyles.bodyText),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                generoSeleccionado = 'mujer';
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: generoSeleccionado == 'mujer' 
                  ? AppColores.componenteSeleccionado 
                  : AppColores.fondoComponentes, 
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column( //Mujer
                    children: [
                      Image.asset('assets/imagenes/mujer.png', width: 100, height: 100),
                      Text('Mujer', style: TextStyles.bodyText),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
  }
