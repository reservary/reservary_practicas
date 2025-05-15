import 'package:flutter/material.dart';
import '../core/estilosyfuentes.dart';
import '../core/tema.dart';

class ImcResultScreen extends StatelessWidget {
  final int weight;
  final double height;

  const ImcResultScreen(
      {super.key, required this.weight, required this.height});

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
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tu resultado",
            style: TextStyle(
                fontSize: 38, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 32, bottom: 32),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.backgroundComponent,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(getTitleByImc(imcResult),
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: getColorByImc(imcResult))),
                    Text(
                      imcResult.toStringAsFixed(2),
                      style: TextStyle(
                          fontSize: 76,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(getDescriptionByImc(imcResult),
                          style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                              textAlign: TextAlign.center,),
                    )
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
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                    backgroundColor:
                        WidgetStateProperty.all(AppColors.primary)),
                child: Text(
                  "Finalizar",
                  style: TextStyles.bodyText,
                )),
          )
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

  Color getColorByImc(double imcResult) {
    return switch (imcResult) {
      < 18.5 => Colors.blue, //IMC Bajo
      < 24.9 => Colors.green, //IMC normal
      < 29.99 => Colors.orange, //Sobrepeso
      _ => Colors.red //Obesidad
    };
  }

  String getTitleByImc(double imcResult){
    return switch (imcResult) {
      < 18.5 => "Deberias de comer mas",
      < 24.9 => "Perfe",
      < 29.99 => "Te pillas 2 menús de normal",
      _ => "Diablo loco relaja"
    };
  }

  String getDescriptionByImc(double imcResult){
    return switch (imcResult) {
      < 18.5 => "Deberias de comer mas",
      < 24.9 => "Estas de puta madre",
      < 29.99 => "Has pillado kilillos, cuidao",
      _ => "Definitivamente tenemos un problema"
    };
  }
}