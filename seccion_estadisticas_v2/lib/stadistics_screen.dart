import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StadisticsScreen extends StatefulWidget {
  const StadisticsScreen({super.key});

  @override
  State<StadisticsScreen> createState() => _StadisticsScreenState();
}

class _StadisticsScreenState extends State<StadisticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Estadísticas")),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    height: 200,
                    child: LineChart(
                      LineChartData(
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
                              strokeWidth: 2)
                          ]
                        ),
                        borderData: FlBorderData(
                          border: Border.all(color: Colors.transparent),
                          show: true,
                        ),
                        lineTouchData: LineTouchData(enabled: true),
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
              Expanded(
                child: Container(
                  height: 200,
                  color: Colors.redAccent,
                  child: Text("data"),
                ),
              ),
              Expanded(
                child: Container(
                  height: 200,
                  color: Colors.redAccent,
                  child: Text("data"),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 200,
                  color: Colors.redAccent,
                  child: Text("data"),
                ),
              ),
              Expanded(
                child: Container(
                  height: 200,
                  color: Colors.redAccent,
                  child: Text("data"),
                ),
              ),
              Expanded(
                child: Container(
                  height: 200,
                  color: Colors.redAccent,
                  child: Text("data"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
