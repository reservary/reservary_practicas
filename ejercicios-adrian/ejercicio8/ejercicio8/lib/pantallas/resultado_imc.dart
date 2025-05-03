import 'package:ejercicio8/core/colores_app.dart';
import 'package:ejercicio8/core/estilos.dart';
import 'package:flutter/material.dart';

class ResultadoImc extends StatelessWidget {
  final int peso;
  final double altura;
  final int edad;

  const ResultadoImc({
    super.key,
    required this.peso,
    required this.altura,
    required this.edad,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColoresApp.background,
      appBar: toolbarResult(),
      body: bodyResult(context),
    );
  }

  Padding bodyResult(BuildContext context) {
    double fixedAltura = altura / 100;
    double imcResult = peso / (fixedAltura * fixedAltura);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tu resultado",
            style: TextStyle(
              fontSize: 38,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 32, bottom: 32),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColoresApp.backgroundComponent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      getTitleByImc(imcResult),
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: getColorByImc(imcResult),
                      ),
                    ),
                    Text(
                      imcResult.toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 76,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        getDescriptionByImc(imcResult),
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 60,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ButtonStyle(
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                backgroundColor: WidgetStateProperty.all(ColoresApp.primary),
              ),
              child: Text("Finalizar", style: Estilos.bodyText),
            ),
          ),
        ],
      ),
    );
  }

  AppBar toolbarResult() {
    return AppBar(
      title: Text("Resultado"),
      backgroundColor: ColoresApp.primary,
      foregroundColor: Colors.white,
    );
  }

  Color getColorByImc(double imcResult) {
    return switch (imcResult) {
      < 18.5 => const Color(0xFF1477C9), //IMC Bajo
      < 24.9 => const Color(0xFF2DE734), //IMC normal
      < 29.99 => const Color(0xFFF5970B), //Sobrepeso
      _ => const Color(0xFFE72517), //Obesidad
    };
  }

  String getTitleByImc(double imcResult) {
    return switch (imcResult) {
      < 18.5 => "Imc Bajo",
      < 24.9 => "Imc Normal",
      < 29.99 => "Sobrepeso",
      _ => "Obesidad",
    };
  }

  String getDescriptionByImc(double imcResult) {
    return switch (imcResult) {
      < 18.5 => "Tu peso está por debajo de lo recomendado.",
      < 24.9 => "Tu peso está en el rango saludable.",
      < 29.99 => "Tienes sobrepeso, cuida tu alimentación.",
      _ => "Tienes obesidad, consulta con un especialista.",
    };
  }
}
