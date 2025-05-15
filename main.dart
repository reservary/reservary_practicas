import 'package:flutter/material.dart';
import 'package:ejerciciointerfaz1/core/tema.dart';
import 'package:ejerciciointerfaz1/pantallas/principal.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: AppColors.primary, 
            foregroundColor: Colors.white,
            title: Text("Calculadora IMC")),
        backgroundColor: AppColors.background,
        body: ImcHomeScreen(),
      ),
    );
  }
}