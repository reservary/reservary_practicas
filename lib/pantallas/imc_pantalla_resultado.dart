import 'package:flutter/material.dart';
import 'package:primerappfuncionalflutter/nucleo/app_colores.dart';
import 'package:primerappfuncionalflutter/nucleo/styles_textos.dart';

class ImcResultScreen extends StatelessWidget {
  final double altura;
  final int peso;

  const ImcResultScreen({super.key, required this.altura, required this.peso});

  double _calculateBMI() {
    // Convertir altura de cm a metros
    double alturaEnMetros = altura / 100;
    // Calcular IMC
    return peso / (alturaEnMetros * alturaEnMetros);
  }

  String _getBMICategory(double bmi) {
    if (bmi < 18.5) {
      return 'Bajo peso';
    } else if (bmi < 25) {
      return 'Peso normal';
    } else if (bmi < 30) {
      return 'Sobrepeso';
    } else {
      return 'Obesidad';
    }
  }

  @override
  Widget build(BuildContext context) {
    final bmi = _calculateBMI();
    final category = _getBMICategory(bmi);

    return Scaffold(
      appBar: AppBar(
        title: Text('Resultado IMC'),
        backgroundColor: AppColores.backgroundComponent,
      ),
      body: Container(
        color: AppColores.background,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Tu IMC es:', style: StylesTextos.bodyText),
              SizedBox(height: 20),
              Text(
                bmi.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: AppColores.primary,
                ),
              ),
              SizedBox(height: 20),
              Text(category, style: StylesTextos.bodyText),
            ],
          ),
        ),
      ),
    );
  }
}
