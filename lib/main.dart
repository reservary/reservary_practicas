import 'package:flutter/material.dart';
import 'package:primerappfuncionalflutter/nucleo/app_colores.dart';
import 'package:primerappfuncionalflutter/pantallas/imc_pantalla_principal.dart';

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
          backgroundColor: AppColores.primary,
          foregroundColor: Colors.white,
          title: Text("Calculadora de Imc Personalizada"),
        ),
        backgroundColor: AppColores.background,
        body: ImcPantallaPrincipal(),
      ),
    );
  }
}
