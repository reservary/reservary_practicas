import 'package:flutter/material.dart';
import 'package:primerappfuncionalflutter/nucleo/app_colores.dart';
import 'package:primerappfuncionalflutter/nucleo/styles_textos.dart';

class Altura extends StatefulWidget {
  final Function(double)? onAlturaCambiada;
  const Altura({super.key, this.onAlturaCambiada});

  @override
  State<Altura> createState() => _AlturaState();
}

class _AlturaState extends State<Altura> {
  double altura = 150;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          color: AppColores.backgroundComponent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text("Altura", style: StylesTextos.bodyText),
              const SizedBox(height: 8),
              Text(
                "${altura.toStringAsFixed(0)} cm",
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Slider(
                value: altura,
                min: 100,
                max: 210,
                divisions: 110,
                label: "${altura.toStringAsFixed(0)} cm",
                activeColor: AppColores.primary,
                onChanged: (value) {
                  setState(() => altura = value);
                  widget.onAlturaCambiada?.call(value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
