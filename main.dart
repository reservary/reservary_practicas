import 'package:flutter/material.dart';
import 'package:test_1/ejercicio1.dart';

void main() {
  
  runApp(const ValidacionNumeroApp());
}

class ValidacionNumeroApp extends StatelessWidget {
  const ValidacionNumeroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'Validación de Número',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const ValidacionNumeroPage(),
    );
  }
}
