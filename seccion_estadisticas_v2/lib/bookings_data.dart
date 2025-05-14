import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seccion_estadisticas_v2/models/statistics.dart';

class BookingsData extends StatefulWidget {
  const BookingsData({super.key});

  @override
  State<BookingsData> createState() => _BookingsDataState();
}

class _BookingsDataState extends State<BookingsData> {
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
      return Center(child: CircularProgressIndicator());
    }
    final progress = _stats!.progress;
    final spots = List<FlSpot>.generate(progress.length, (index) {
      return FlSpot(index.toDouble(), progress[index].bookings.toDouble());
    });
    final dates = progress.map((p) => p.date).toList();
    return SizedBox(
      height: 295,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: LineChart(
          LineChartData(
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                getTooltipItems: (touchedSpots) {
                  return touchedSpots.map((LineBarSpot touchedSpot) {
                    final index = touchedSpot.x.toInt();
                    final entry = progress[index];
                    return LineTooltipItem(
                      "Billed amount: ${entry.billedAmount}",
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
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 10,
                  reservedSize: 30,
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 20,
                  interval:0.4,
                  getTitlesWidget: (value, meta) {
                    final index = value.toInt();
                    if (index >= 0 && index < dates.length) {
                      return Text(dates[index], style: TextStyle(fontSize: 10));
                    }
                    return Text("");
                  },
                ),
              ),
              show: true,
            ),
            extraLinesData: ExtraLinesData(
              horizontalLines: [
                HorizontalLine(y: 0, color: Colors.black, strokeWidth: 2),
              ],
              verticalLines: [
                VerticalLine(x: 0, color: Colors.black, strokeWidth: 2),
              ],
            ),
            borderData: FlBorderData(
              border: Border.all(color: Colors.transparent),
              show: true,
            ),
            lineBarsData: [
              LineChartBarData(
                isCurved: true,
                color: Colors.blue,
                barWidth: 3,
                dotData: FlDotData(show: true),
                belowBarData: BarAreaData(show: false),
                spots: spots,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
