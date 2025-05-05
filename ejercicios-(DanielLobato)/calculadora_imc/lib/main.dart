import 'package:calculadora_imc/nucleo/app_colores.dart';
import 'package:calculadora_imc/ventanas/ventana_home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Calculadora IMC'),
          backgroundColor: AppColores.fondo,
          foregroundColor: Colors.white,
        ),
        backgroundColor: AppColores.fondo,
        body: VentanaHome(),
        ),
      );
    
  }
}
        