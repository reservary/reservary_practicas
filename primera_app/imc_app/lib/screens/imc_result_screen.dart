import 'package:flutter/material.dart';
import 'package:imc_app/core/app_colors.dart';
import 'package:imc_app/core/text_styles.dart';

class ImcResultScreen extends StatelessWidget {
  final double weight;
  final double age;
  const ImcResultScreen({super.key,required this.weight,required this.age});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: toolbarResult(),
      body: bodyResult(),
    );
  }

  Padding bodyResult() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text("Tu resultado",style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          )
          ),
          Container(
            width: double.infinity,
            height: ,
            decoration: BoxDecoration(
              color: AppColors.backgroundComponent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text("Prueba"),
          )
        ],
      ),
    );
  }

  AppBar toolbarResult() {
    return AppBar(
      title: Text("Resultado"),
      backgroundColor: AppColors.backgroundComponent,
      foregroundColor: Colors.black,
    );
  }
}