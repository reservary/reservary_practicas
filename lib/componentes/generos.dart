import 'package:flutter/material.dart';
import 'package:primerappfuncionalflutter/nucleo/app_colores.dart';
import 'package:primerappfuncionalflutter/nucleo/styles_textos.dart';

class GenerosSelector extends StatefulWidget {
  const GenerosSelector({super.key});

  @override
  State<GenerosSelector> createState() => _GenerosSelectorState();
}

class _GenerosSelectorState extends State<GenerosSelector> {
  String? generoSeleccionado;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //Hombre
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                generoSeleccionado = "Hombre";
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10,
                top: 20,
                bottom: 20,
                right: 10,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color:
                      generoSeleccionado == "Hombre"
                          ? AppColores.backgroundComponentSelected
                          : AppColores.backgroundComponent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Image.asset("assets/images/hombre.png", height: 100),
                      SizedBox(height: 8),
                      Text(
                        "Hombre".toUpperCase(),
                        style: StylesTextos.bodyText,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        //Mujer
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                generoSeleccionado = "Mujer";
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(
                top: 16,
                bottom: 16,
                right: 16,
                left: 8,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color:
                      generoSeleccionado == "Mujer"
                          ? AppColores.backgroundComponentSelected
                          : AppColores.backgroundComponent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Image.asset("assets/images/mujer.png", height: 100),
                      SizedBox(height: 8),
                      Text("Mujer".toUpperCase(), style: StylesTextos.bodyText),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
