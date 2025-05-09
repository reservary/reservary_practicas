import 'package:basic_flutter/core/app_colors.dart';
import 'package:basic_flutter/core/text_styles.dart';
import 'package:flutter/material.dart';

class ImcResultScreen extends StatelessWidget {
  final double height;
  final int weight;

  const ImcResultScreen({
    super.key,
    required this.height,
    required this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: toolbarResult(),
      body: bodyResult(context),
    );
  }

  Padding bodyResult(BuildContext context) {
    double fixedHeight = height / 100;
    double imcResult = weight / (fixedHeight * fixedHeight);
    return Padding(
      padding: const EdgeInsets.all(16),
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
                  color: AppColors.backgroundComponent,
                  borderRadius: BorderRadius.circular(18),
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
                      "Tu IMC es ${imcResult.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 56,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18),
                      child: Text(getDescriptionByImc(imcResult), style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w200,
                          color: Colors.white,
                        )),
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
                backgroundColor: WidgetStateProperty.all(AppColors.primary),
              ),
              child: Text("Finalizar", style: TextStyles.bodyText),
            ),
          ),
        ],
      ),
    );
  }

  AppBar toolbarResult() {
    return AppBar(
      title: Text("Resultado"),
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
    );
  }
  
  getColorByImc(double imcResult) {
    return switch(imcResult){
      < 18.5 => Colors.blue, //imc bajo
      < 24.9 => Colors.green, //imc normal
      < 29.99 => Colors.orange, //sobrepeso
      _ => Colors.red //obesidad
    };
  }
  
  String getTitleByImc(double imcResult) {
    return switch(imcResult){
      < 18.5 =>"Imc bajo",
      < 24.9 => "Imc normal",
      < 29.99 => "Sobrepeso",
      _ => "Obesidad"
    };
  }
  
  String getDescriptionByImc(double imcResult) {
    return switch(imcResult){
      < 18.5 =>"Debes subir un poco de peso, cómete un buen cocido y déjate de lechuga.",
      < 24.9 => "Estás en el punto perfecto, como un buen filete poco hecho.",
      < 29.99 => "Debes bajar un poco de peso, quítate la hamburguesa del viernes y cena una ensalada.",
      _ => "Macho, a lechuga y purés hasta que bajes."
    };
  }
}
