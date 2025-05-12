import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StadisticsScreen extends StatefulWidget {
  const StadisticsScreen({super.key});

  @override
  State<StadisticsScreen> createState() => _StadisticsScreenState();
}

class _StadisticsScreenState extends State<StadisticsScreen> {
  int touchedIndexPieChart1 = -1;
  int touchedIndexPieChart2 = -1;
  int touchedIndexPieChart3 = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                            "300",
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
                            "2500",
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
                      child: PieChart(
                        PieChartData(
                          centerSpaceRadius: 0.5,
                          sectionsSpace: 1,
                          sections: [
                            PieChartSectionData(
                              value: 40,
                              title: "40%",
                              color: Colors.blue,
                              radius: 100,
                            ),
                            PieChartSectionData(
                              value: 30,
                              title: "30%",
                              color: Colors.red,
                              radius: 100,
                            ),
                            PieChartSectionData(
                              value: 20,
                              title: "20%",
                              color: Colors.green,
                              radius: 100,
                            ),
                          ],
                        ),
                      ),
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
                  child: SizedBox(
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
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                reservedSize: 50,
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  String text;
                                  switch (value.toInt()) {
                                    case 0:
                                      text = "Servicio 1";
                                      break;
                                    case 1:
                                      text = "Servicio 2";
                                    default:
                                      text = "";
                                  }
                                  return Transform.rotate(
                                    angle: -math.pi / 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        text,
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          barGroups: [
                            BarChartGroupData(
                              x: 0,
                              barRods: [
                                BarChartRodData(toY: 8, color: Colors.amber),
                              ],
                            ),
                            BarChartGroupData(
                              x: 1,
                              barRods: [
                                BarChartRodData(toY: 8, color: Colors.amber),
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
                    top: 12,
                    bottom: 24,
                    left: 12,
                    right: 12,
                  ),
                  child: SizedBox(
                    width: 200,
                    height: 295,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: PieChart(
                        PieChartData(
                          pieTouchData: PieTouchData(
                            touchCallback: (
                              FlTouchEvent event,
                              PieTouchResponse? pieTouchResponse,
                            ) {
                              setState(() {
                                if (!event.isInterestedForInteractions ||
                                    pieTouchResponse == null ||
                                    pieTouchResponse.touchedSection == null) {
                                  return;
                                }
                                touchedIndexPieChart2 =
                                    pieTouchResponse
                                        .touchedSection!
                                        .touchedSectionIndex;
                              });
                            },
                          ),
                          sections: [
                            PieChartSectionData(
                              value: 20,
                              title: "20%",
                              color: const Color(0xFF2196F3),
                              radius: touchedIndexPieChart2 == 0 ? 120 : 100,
                              titleStyle: TextStyle(
                                fontSize: touchedIndexPieChart2 == 0 ? 16 : 12,
                              ),
                              borderSide: BorderSide(
                                color:
                                    touchedIndexPieChart2 == 0
                                        ? Colors.black
                                        : Color(0xFF2196F3),
                                width: 2,
                              ),
                              badgeWidget: Container(
                                width: touchedIndexPieChart2 == 0 ? 50 : 45,
                                height: touchedIndexPieChart2 == 0 ? 50 : 45,
                                decoration: BoxDecoration(
                                  //color: const Color.fromARGB(255, 12, 12, 12),
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage("icons/ios.png"),
                                    fit: BoxFit.cover,
                                  ),
                                  border: Border.all(
                                    width: touchedIndexPieChart2 == 0 ? 2 : 0,
                                  ),
                                ),
                              ),
                              badgePositionPercentageOffset: 1.1,
                            ),
                            PieChartSectionData(
                              value: 30,
                              title: "30%",
                              color: Colors.red,
                              radius: touchedIndexPieChart2 == 1 ? 120 : 100,
                              titleStyle: TextStyle(
                                fontSize: touchedIndexPieChart2 == 1 ? 16 : 12,
                              ),
                              borderSide: BorderSide(
                                color:
                                    touchedIndexPieChart2 == 1
                                        ? Colors.black
                                        : Colors.red,
                                width: 2,
                              ),
                              badgeWidget: Container(
                                width: touchedIndexPieChart2 == 1 ? 50 : 45,
                                height: touchedIndexPieChart2 == 1 ? 50 : 45,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage("icons/android.png"),
                                    fit: BoxFit.cover,
                                  ),
                                  border: Border.all(
                                    width: touchedIndexPieChart2 == 1 ? 2 : 0,
                                  ),
                                ),
                              ),
                              badgePositionPercentageOffset: 1.1,
                            ),
                            PieChartSectionData(
                              value: 50,
                              title: "50%",
                              color: Colors.green,
                              radius: touchedIndexPieChart2 == 2 ? 120 : 100,
                              titleStyle: TextStyle(
                                fontSize: touchedIndexPieChart2 == 2 ? 16 : 12,
                              ),
                              borderSide: BorderSide(
                                color:
                                    touchedIndexPieChart2 == 2
                                        ? Colors.black
                                        : Colors.green,
                                width: 2,
                              )
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
                    left: 12,
                    top: 12,
                    right: 24,
                    bottom: 24,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 300,
                          height: 295,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 16,
                              bottom: 16,
                              left: 16,
                            ),
                            child: PieChart(
                              PieChartData(
                                centerSpaceRadius: 0,
                                pieTouchData: PieTouchData(
                                  touchCallback: (
                                    FlTouchEvent event,
                                    PieTouchResponse? pieTouchResponse,
                                  ) {
                                    setState(() {
                                      if (!event.isInterestedForInteractions ||
                                          pieTouchResponse == null ||
                                          pieTouchResponse.touchedSection ==
                                              null) {
                                        touchedIndexPieChart3 = -1;
                                        return;
                                      }
                                      touchedIndexPieChart3 =
                                          pieTouchResponse
                                              .touchedSection!
                                              .touchedSectionIndex;
                                    });
                                  },
                                ),
                                sections: [
                                  PieChartSectionData(
                                    value: 40,
                                    title: "40%",
                                    color: Colors.blue,
                                    radius:
                                        touchedIndexPieChart3 == 0 ? 100 : 90,
                                    borderSide: BorderSide(
                                      width: touchedIndexPieChart3 == 0 ? 2 : 0,
                                    ),
                                  ),
                                  PieChartSectionData(
                                    value: 30,
                                    title: "30%",
                                    color: Colors.red,
                                    radius:
                                        touchedIndexPieChart3 == 1 ? 100 : 90,
                                    borderSide: BorderSide(
                                      width: touchedIndexPieChart3 == 1 ? 2 : 0,
                                    ),
                                  ),
                                  PieChartSectionData(
                                    value: 20,
                                    title: "20%",
                                    color: Colors.green,
                                    radius:
                                        touchedIndexPieChart3 == 2 ? 100 : 90,
                                    borderSide: BorderSide(
                                      width: touchedIndexPieChart3 == 2 ? 2 : 0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 295,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 16,
                              bottom: 16,
                              right: 16,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width:
                                          touchedIndexPieChart3 == 0 ? 15 : 10,
                                      height:
                                          touchedIndexPieChart3 == 0 ? 15 : 10,
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: SizedBox(
                                        child: Text(
                                          "Estado 1",
                                          style: TextStyle(
                                            fontSize:
                                                touchedIndexPieChart3 == 0
                                                    ? 25
                                                    : 20,
                                            fontWeight:
                                                touchedIndexPieChart3 == 0
                                                    ? FontWeight.bold
                                                    : FontWeight.normal,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width:
                                          touchedIndexPieChart3 == 1 ? 15 : 10,
                                      height:
                                          touchedIndexPieChart3 == 1 ? 15 : 10,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: SizedBox(
                                        child: Text(
                                          "Estado 2",
                                          style: TextStyle(
                                            fontSize:
                                                touchedIndexPieChart3 == 1
                                                    ? 25
                                                    : 20,
                                            fontWeight:
                                                touchedIndexPieChart3 == 1
                                                    ? FontWeight.bold
                                                    : FontWeight.normal,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width:
                                          touchedIndexPieChart3 == 2 ? 15 : 10,
                                      height:
                                          touchedIndexPieChart3 == 2 ? 15 : 10,
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 5,
                                        right: 16,
                                      ),
                                      child: SizedBox(
                                        child: Text(
                                          "Estado 3",
                                          style: TextStyle(
                                            fontSize:
                                                touchedIndexPieChart3 == 2
                                                    ? 25
                                                    : 20,
                                            fontWeight:
                                                touchedIndexPieChart3 == 2
                                                    ? FontWeight.bold
                                                    : FontWeight.normal,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
