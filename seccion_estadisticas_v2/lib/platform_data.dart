import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seccion_estadisticas_v2/models/statistics.dart';

class PlatformData extends StatefulWidget {
  const PlatformData({super.key});

  @override
  State<PlatformData> createState() => _PlatformDataState();
}

class _PlatformDataState extends State<PlatformData> {
  int touchedIndexPieChart2 = -1;
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
    
    return SizedBox(
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
                      pieTouchResponse.touchedSection!.touchedSectionIndex;
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
                  color: touchedIndexPieChart2 == 1 ? Colors.black : Colors.red,
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
                title: touchedIndexPieChart2 == 2 ? "50%" : "",
                color: Colors.green,
                radius: touchedIndexPieChart2 == 2 ? 120 : 100,
                titleStyle: TextStyle(
                  fontSize: touchedIndexPieChart2 == 2 ? 16 : 12,
                ),
                borderSide: BorderSide(
                  color:
                      touchedIndexPieChart2 == 2 ? Colors.black : Colors.green,
                  width: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
