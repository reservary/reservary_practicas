import 'package:flutter/material.dart';
import 'package:progresos_checks/ventanas/ventana_progresos_cheks.dart';

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
          title: Text('Progresos Checks'),
        ),
        body: VentanaProgresosChecks(),
      ),
    );
  }
}
