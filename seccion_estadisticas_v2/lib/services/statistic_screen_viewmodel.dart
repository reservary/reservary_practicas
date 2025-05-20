import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:seccion_estadisticas_v2/models/statistics.dart';

class StatisticsScreenViewModel {
  Statistics? stats;

  Future<void> loadStats() async {
    try {
      final jsonString = await rootBundle.loadString('assets/data/data.json');
      final jsonMap = jsonDecode(jsonString);
      stats = Statistics.fromJson(jsonMap);
    } catch (e) {
      print('Error: $e');
    }
  }
  

}
