import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seccion_estadisticas_v2/models/statistics.dart';

class StatusData extends StatefulWidget {
  const StatusData({super.key});

  @override
  State<StatusData> createState() => _StatusDataState();
}

class _StatusDataState extends State<StatusData> {
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
    
    final totalBookingsByStatus = _stats!.totalBookingsByStatus;
    final List<String> status = totalBookingsByStatus.keys.toList();
    final List<int> statusValues = totalBookingsByStatus.values.toList();
    return Row(
      children: [
        Flexible(
          flex: 7,
          child: Column(
            children: [
              SizedBox(
                height: 315,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
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
                      sections: List.generate(status.length, (index) {
                        return PieChartSectionData(
                          value: statusValues[index].toDouble(),
                          title:
                              isTouched == index ? "${statusValues[index]}" : "",
                          color: _getColorByStatus(status[index]),
                          radius: 120,
                          borderSide: BorderSide(
                            width: isTouched==index? 3:0,
                          )
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Flexible(
          flex: 3,
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(status.length, (index) {
                final name = status[index];
                final color = _getColorByStatus(name);
                  
                return Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Container(
                        width: isTouched == index ? 20 : 15,
                        height: isTouched == index ? 20 : 15,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: color,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        name.toUpperCase(),
                        style: TextStyle(
                          fontSize: isTouched == index ? 16 : 14,
                          fontWeight:
                              isTouched == index
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ],
    );
  }

  Color _getColorByStatus(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'pending':
        return Colors.blue;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
