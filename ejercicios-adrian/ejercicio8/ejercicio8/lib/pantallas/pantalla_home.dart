import 'package:ejercicio8/componentes/altura.dart';
import 'package:ejercicio8/componentes/genero.dart';
import 'package:ejercicio8/componentes/numero.dart';
import 'package:ejercicio8/core/colores_app.dart';
import 'package:ejercicio8/core/estilos.dart';
import 'package:ejercicio8/pantallas/resultado_imc.dart';
import 'package:flutter/material.dart';

class PantallaHome extends StatefulWidget {
  const PantallaHome({super.key});

  @override
  State<PantallaHome> createState() => _PantallaHomeState();
}

class _PantallaHomeState extends State<PantallaHome> {
  int selectedEdad = 20;
  int selectedPeso = 80;
  double selectedAltura = 160;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GeneroSelector(),
        AlturaSelector(
          selectedAltura: selectedAltura,
          onAlturaChange: (newAltura) {
            setState(() {
              selectedAltura = newAltura;
            });
          },
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: NumeroSelector(
                  title: "PESO",
                  value: selectedPeso,
                  onDecrement: () {
                    setState(() {
                      selectedPeso--;
                    });
                  },
                  onIncrement: () {
                    setState(() {
                      selectedPeso++;
                    });
                  },
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: NumeroSelector(
                  title: "EDAD",
                  value: selectedEdad,
                  onDecrement: () {
                    setState(() {
                      selectedEdad--;
                    });
                  },
                  onIncrement: () {
                    setState(() {
                      selectedEdad++;
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
                        (context) => ResultadoImc(
                          altura: selectedAltura,
                          peso: selectedPeso,
                          edad: selectedEdad,
                        ),
                  ),
                );
              },
              style: ButtonStyle(
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                backgroundColor: WidgetStateProperty.all(ColoresApp.primary),
              ),
              child: Text("Calcular", style: Estilos.bodyText),
            ),
          ),
        ),
      ],
    );
  }
}
