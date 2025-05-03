import 'package:ejercicio8/core/colores_app.dart';
import 'package:ejercicio8/pantallas/pantalla_home.dart';
import 'package:flutter/material.dart';

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
          backgroundColor: ColoresApp.primary,
          foregroundColor: Colors.white,
          title: Text("Calculadora IMC"),
        ),
        backgroundColor: ColoresApp.background,
        body: PantallaHome(),
      ),
    );
  }
}
