import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seccion_estadisticas_v2/models/statistics.dart';

class EmployeeData extends StatefulWidget {
  const EmployeeData({super.key});

  @override
  State<EmployeeData> createState() => _EmployeeDataState();
}

class _EmployeeDataState extends State<EmployeeData> {
  int isTouched = -1;
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
    final List<String> employe = dataEmployee.keys.toList();
    final List<int> bookings = dataEmployee.values.toList();
    return Expanded(
      child: Row(
        children: [
          Column(
            children: [
              SizedBox(
                width: 300,
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
                              isTouched = -1;
                              return;
                            }
                            isTouched =
                                pieTouchResponse
                                    .touchedSection!
                                    .touchedSectionIndex;
                          });
                        },
                      ),
                      centerSpaceRadius: 0,
                      sectionsSpace: 1,
                      sections: List.generate(dataEmployee.length, (index) {
                        return PieChartSectionData(
                          value: bookings[index].toDouble(),
                          color: _getColorFromId(employe[index]),
                          radius: isTouched == index ? 130 : 120,
                          borderSide: BorderSide(
                            width: isTouched == index ? 3 : 0,
                          ),
                          badgePositionPercentageOffset: 1.23,
                          badgeWidget: Container(
                            width: isTouched == index ? 60 : 0,
                            height: isTouched == index ? 60 : 0,
                            decoration: BoxDecoration(
                              //color: const Color.fromARGB(255, 12, 12, 12),
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: isTouched == index ? 2 : 0,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                employe[index],
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(dataEmployee.length, (index) {
              final name = employe[index];
              final color = _getColorFromId(name);

              return Row(
                children: [
                  Container(
                    width: isTouched == index ? 20 : 15,
                    height: isTouched == index ? 20 : 15,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: color,
                    ),
                  ),
                  Text(
                    name.toUpperCase(),
                    style: TextStyle(
                      fontSize: isTouched == index ? 18 : 14,
                      fontWeight:
                          isTouched == index
                              ? FontWeight.bold
                              : FontWeight.normal,
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
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
