import 'package:basic_flutter/core/app_colors.dart';
import 'package:basic_flutter/screens/imc_home_screen.dart';
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
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          title: Text("Imc Calculator")),
        backgroundColor: AppColors.background,
        body: ImcHomeScreen(),
      ),
    );
  }
}
