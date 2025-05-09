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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 12,
                    top: 24,
                    right: 24,
                    bottom: 12,
                  ),
                  child: SizedBox(
                    child: Column(
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    top: 24,
                    right: 12,
                    bottom: 12,
                  ),
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
                              strokeWidth: 2,
                            ),
                          ],
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
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    top: 24,
                    right: 12,
                    bottom: 12,
                  ),
                  child: SizedBox(
                    height: 400,
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
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 12,
                    top: 12,
                    right: 24,
                    bottom: 24,
                  ),
                  child: SizedBox(
                    height: 200,
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 12,
                    top: 12,
                    right: 12,
                    bottom: 24,
                  ),
                  child: SizedBox(
                    height: 200,
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
                    left: 24,
                    top: 12,
                    right: 12,
                    bottom: 24,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 300,
                          height: 200,
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
                                  radius: touchedIndexPieChart3 == 0 ? 100 : 90,
                                ),
                                PieChartSectionData(
                                  value: 30,
                                  title: "30%",
                                  color: Colors.red,
                                  radius: touchedIndexPieChart3 == 1 ? 100 : 90,
                                ),
                                PieChartSectionData(
                                  value: 20,
                                  title: "20%",
                                  color: Colors.green,
                                  radius: touchedIndexPieChart3 == 2 ? 100 : 90,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: touchedIndexPieChart3 == 0 ? 15 : 10,
                                    height:
                                        touchedIndexPieChart3 == 0 ? 15 : 10,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
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
                                    width: touchedIndexPieChart3 == 1 ? 15 : 10,
                                    height:
                                        touchedIndexPieChart3 == 1 ? 15 : 10,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
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
                                    width: touchedIndexPieChart3 == 2 ? 15 : 10,
                                    height:
                                        touchedIndexPieChart3 == 2 ? 15 : 10,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
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
