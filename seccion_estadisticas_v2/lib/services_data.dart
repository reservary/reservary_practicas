import 'dart:convert';
import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seccion_estadisticas_v2/models/statistics.dart';

class ServicesData extends StatefulWidget {
  const ServicesData({super.key});

  @override
  State<ServicesData> createState() => _ServicesDataState();
}

class _ServicesDataState extends State<ServicesData> {
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
    final servicesNames = _stats!.totalBookingsPerService.keys.toList();
    final servicesValues = _stats!.totalBookingsPerService.values.toList();
    return SizedBox(
      height: 295,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BarChart(
          BarChartData(
            rotationQuarterTurns: 45,
            gridData: FlGridData(show: false),
            borderData: FlBorderData(
              show: true,
              border: Border(
                top: BorderSide.none,
                right: BorderSide.none,
                left: BorderSide(width: 1),
                bottom: BorderSide(width: 1),
              ),
            ),
            titlesData: FlTitlesData(
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  reservedSize: 50,
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    String services = servicesNames[value.toInt()];
                    return Transform.rotate(
                      angle: -math.pi / 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(services, style: TextStyle(fontSize: 10)),
                      ),
                    );
                  },
                ),
              ),
            ),
            barGroups: List.generate(servicesNames.length, (index) {
              return BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    toY: servicesValues[index].toDouble(),
                    color: Colors.blue,
                    width: 10,
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
