import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:seccion_estadisticas_v2/services/statistic_screen_viewmodel.dart';
import 'package:seccion_estadisticas_v2/statistics_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StatisticsScreen(viewModel: StatisticsScreenViewModel()),
      supportedLocales: [Locale('es', 'US'), Locale('es', 'ES')],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
