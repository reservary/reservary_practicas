import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seccion_estadisticas_v2/models/statistics.dart';
import 'package:seccion_estadisticas_v2/employee_data.dart';
import 'package:seccion_estadisticas_v2/platform_data.dart';
import 'package:seccion_estadisticas_v2/services_data.dart';
import 'package:seccion_estadisticas_v2/status_data.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreen();
}

class _StatisticsScreen extends State<StatisticsScreen> {
  Statistics? _stats;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  int touchedIndexPieChart1 = -1;
  int touchedIndexPieChart2 = -1;
  int touchedIndexPieChart3 = -1;
  Future<void> _loadStats() async {
    final jsonString = await rootBundle.loadString('assets/data/data.json');
    final jsonMap = jsonDecode(jsonString);
    setState(() {
      _stats = Statistics.fromJson(jsonMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          _stats == null
              ? const Center(child: CircularProgressIndicator())
              : Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 24,
                          bottom: 12,
                          left: 24,
                          right: 12,
                        ),
                        child: Expanded(
                          child: SizedBox(
                            height: 295,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Total reservas:",
                                    style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "${_stats!.totalBookings}",
                                    style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "Total facturado:",
                                    style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "${_stats!.totalBilledAmount}",
                                    style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 24,
                            bottom: 12,
                            left: 12,
                            right: 12,
                          ),
                          child: SizedBox(
                            height: 295,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: LineChart(
                                LineChartData(
                                  lineTouchData: LineTouchData(
                                    touchTooltipData: LineTouchTooltipData(
                                      getTooltipItems: (touchedSpots) {
                                        return touchedSpots.map((
                                          LineBarSpot touchedSpot,
                                        ) {
                                          return LineTooltipItem(
                                            "x: ${touchedSpot.x},y :${touchedSpot.y}",
                                            TextStyle(color: Colors.white),
                                          );
                                        }).toList();
                                      },
                                    ),
                                  ),
                                  minY: 0,
                                  minX: 0,
                                  gridData: FlGridData(show: true),
                                  titlesData: FlTitlesData(
                                    topTitles: AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    rightTitles: AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    leftTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        interval: 0.5,
                                        reservedSize: 30,
                                      ),
                                    ),
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 30,
                                        interval: 1,
                                      ),
                                    ),
                                    show: true,
                                  ),
                                  extraLinesData: ExtraLinesData(
                                    horizontalLines: [
                                      HorizontalLine(
                                        y: 0,
                                        color: Colors.black,
                                        strokeWidth: 2,
                                      ),
                                    ],
                                    verticalLines: [
                                      VerticalLine(
                                        x: 0,
                                        color: Colors.black,
                                        strokeWidth: 2,
                                      ),
                                    ],
                                  ),
                                  borderData: FlBorderData(
                                    border: Border.all(
                                      color: Colors.transparent,
                                    ),
                                    show: true,
                                  ),
                                  lineBarsData: [
                                    LineChartBarData(
                                      isCurved: true,
                                      color: Colors.blue,
                                      barWidth: 3,
                                      dotData: FlDotData(show: true),
                                      belowBarData: BarAreaData(show: false),
                                      spots: [
                                        FlSpot(0, 1),
                                        FlSpot(1, 1.5),
                                        FlSpot(2, 1.4),
                                        FlSpot(3, 3.4),
                                        FlSpot(4, 2),
                                        FlSpot(5, 2.2),
                                        FlSpot(6, 1.8),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 24,
                            bottom: 12,
                            left: 12,
                            right: 24,
                          ),
                          child: SizedBox(
                            height: 295,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: PruebasPieChart(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 12,
                            bottom: 24,
                            left: 24,
                            right: 12,
                          ),
                          child: ServicesData(),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 12,
                            bottom: 24,
                            left: 12,
                            right: 12,
                          ),
                          child: PlatformData(),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 12,
                            top: 12,
                            right: 24,
                            bottom: 24,
                          ),
                          child: StatusData(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
    );
  }


}
