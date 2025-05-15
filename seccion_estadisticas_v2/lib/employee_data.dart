import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:seccion_estadisticas_v2/models/statistics.dart';

class EmployeeData extends StatefulWidget {
  final Statistics stats;
  const EmployeeData({super.key, required this.stats});

  @override
  State<EmployeeData> createState() => _EmployeeDataState();
}

class _EmployeeDataState extends State<EmployeeData> {
  int isTouched = -1;

  @override
  Widget build(BuildContext context) {
    final dataEmployee = widget.stats.totalBookingsPerEmployee;
    final List<String> employe = dataEmployee.keys.toList();
    final List<int> bookings = dataEmployee.values.toList();
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(dataEmployee.length, (index) {
              final name = employe[index];
              final color = _getColorFromId(name);

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
                        fontSize: isTouched == index ? 18 : 14,
                        fontWeight:
                            isTouched == index
                                ? FontWeight.bold
                                : FontWeight.normal,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ],
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
