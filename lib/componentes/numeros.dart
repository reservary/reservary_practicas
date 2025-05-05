import 'package:flutter/material.dart';
import 'package:primerappfuncionalflutter/nucleo/app_colores.dart';
import 'package:primerappfuncionalflutter/nucleo/styles_textos.dart';

class Numeros extends StatefulWidget {
  final String titulo;
  final Function(int) onValorSumar;
  final Function(int) onValorRestar;
  const Numeros({
    super.key,
    required this.titulo,
    required this.onValorSumar,
    required this.onValorRestar,
  });

  @override
  State<Numeros> createState() => _NumerosState();
}

class _NumerosState extends State<Numeros> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColores.backgroundComponent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(widget.titulo, style: StylesTextos.bodyText),
          Text(""),
          Row(
            children: [
              FloatingActionButton(
                onPressed: () {
                  widget.onValorRestar(1);
                },
                shape: CircleBorder(),
                backgroundColor: AppColores.backgroundComponent,
                child: Icon(Icons.remove),
              ),
              FloatingActionButton(
                onPressed: () {
                  widget.onValorSumar(1);
                },
                shape: CircleBorder(),
                backgroundColor: AppColores.backgroundComponent,
                child: Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
