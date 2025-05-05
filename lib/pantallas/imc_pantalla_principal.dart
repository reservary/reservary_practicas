import 'package:flutter/material.dart';
import 'package:primerappfuncionalflutter/componentes/generos.dart';
import 'package:primerappfuncionalflutter/componentes/altura.dart';
import 'package:primerappfuncionalflutter/componentes/numeros.dart';
import 'package:primerappfuncionalflutter/nucleo/app_colores.dart';
import 'package:primerappfuncionalflutter/nucleo/styles_textos.dart';
import 'package:primerappfuncionalflutter/pantallas/imc_pantalla_resultado.dart';

class ImcPantallaPrincipal extends StatefulWidget {
  const ImcPantallaPrincipal({super.key});

  @override
  State<ImcPantallaPrincipal> createState() => _ImcPantallaPrincipalState();
}

class _ImcPantallaPrincipalState extends State<ImcPantallaPrincipal> {
  int edad = 20;
  int peso = 80;
  double altura = 160;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GenerosSelector(),
        Altura(
          onAlturaCambiada: (newHeight) {
            setState(() {
              altura = newHeight;
            });
          },
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Numeros(
                  titulo: "PESO",
                  onValorSumar: (valor) {
                    setState(() {
                      peso += valor;
                    });
                  },
                  onValorRestar: (valor) {
                    setState(() {
                      peso -= valor;
                    });
                  },
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Numeros(
                  titulo: "EDAD",
                  onValorSumar: (valor) {
                    setState(() {
                      edad += valor;
                    });
                  },
                  onValorRestar: (valor) {
                    setState(() {
                      edad -= valor;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: 60,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            ImcResultScreen(altura: altura, peso: peso),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColores.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text("Calcular tu imc", style: StylesTextos.bodyText),
            ),
          ),
        ),
      ],
    );
  }
}
