import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seccion_estadisticas_v2/models/statistics.dart';

class PruebasPieChart extends StatefulWidget {
  const PruebasPieChart({super.key});

  @override
  State<PruebasPieChart> createState() => _PruebasPieChartState();
}

class _PruebasPieChartState extends State<PruebasPieChart> {
  Statistics? _stats;
  Future<void> _loadStats() async {
    final jsonString = await rootBundle.loadString('assets/data/data.json');
    final jsonMap = jsonDecode(jsonString);
    setState(() {
      _stats = Statistics.fromJson(jsonMap);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  @override
  Widget build(BuildContext context) {
    if (_stats == null) {
      return const Center(child: CircularProgressIndicator());
    }
    final dataEmployee = _stats!.totalBookingsPerEmployee;
    final pieSections =
        dataEmployee.entries.map((entry) {
          return PieChartSectionData(
            value: entry.value.toDouble(),
            title: "${entry.key}",
            color: _getColorFromId(entry.key),
            radius: 100,
            titleStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        }).toList();

    return Column(
      children: [
        Expanded(
          child: SizedBox(
            height: 295,
            child: PieChart(
              PieChartData(
                centerSpaceRadius: 0,
                sectionsSpace: 1,
                sections: pieSections,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Color _getColorFromId(String id) {
    switch (id) {
      case '123456':
        return Colors.blue;
      case '123457':
        return Colors.red;
      case '123458':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
