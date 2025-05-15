//import 'dart:convert';

import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seccion_estadisticas_v2/models/statistics.dart';
//import 'package:flutter/services.dart';
//import 'package:seccion_estadisticas_v2/models/statistics.dart';

class PlatformData extends StatefulWidget {
  const PlatformData({super.key});

  @override
  State<PlatformData> createState() => _PlatformDataState();
}

class _PlatformDataState extends State<PlatformData> {
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
    final totalBookingsPerPlatform = _stats!.totalBookingsPerPlatform;
    final List<String> namePlatform = totalBookingsPerPlatform.keys.toList();
    final List<int> numBookings = totalBookingsPerPlatform.values.toList();
    return SizedBox(
      height: 315,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: PieChart(
          PieChartData(
            centerSpaceRadius: 55,
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
                  isTouched =
                      pieTouchResponse.touchedSection!.touchedSectionIndex;
                });
              },
            ),
            sections: List.generate(numBookings.length, (index) {
              return PieChartSectionData(
                value: numBookings[index].toDouble(),
                title: isTouched == index ? "${numBookings[index]}" : "",
                color: _getColorPerPlatform(namePlatform[index]),
                radius: isTouched == index ? 75 : 70,
                borderSide: BorderSide(width: isTouched == index ? 3 : 0),
                badgeWidget: Container(
                  width: isTouched == index ? 75 : 0,
                  height: isTouched == index ? 75 : 0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: isTouched == index ? 2 : 0),
                  ),
                  child: Center(
                    child: Text(
                      _getStringPerPlatform(namePlatform[index]),
                      style: TextStyle(
                        fontSize: isTouched == index ? 15 : 0,
                        fontWeight:
                            isTouched == index
                                ? FontWeight.bold
                                : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                badgePositionPercentageOffset: 1.5,
              );
            }),
          ),
        ),
      ),
    );
  }

  Color _getColorPerPlatform(String nomPlatform) {
    switch (nomPlatform.toLowerCase()) {
      case 'ios':
        return Colors.grey;
      case 'android':
        return Colors.green;
      case 'adminweb':
        return Colors.blue;
      case 'clienteweb':
        return Colors.lime;
      default:
        return Colors.red;
    }
  }

  String _getStringPerPlatform(String nomPlatform) {
    switch (nomPlatform.toLowerCase()) {
      case 'ios':
        return 'iOS';
      case 'android':
        return 'Android';
      case 'adminweb':
        return 'Admin web';
      case 'clienteweb':
        return 'Cliente web';
      default:
        return 'Not defined';
    }
  }
}
