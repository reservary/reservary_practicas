import 'dart:math' as math;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:seccion_estadisticas_v2/services/statistic_screen_viewmodel.dart';

class ServicesGraphicWidget extends StatefulWidget {
  final StatisticsScreenViewModel viewModel;
  const ServicesGraphicWidget({super.key, required this.viewModel});

  @override
  State<ServicesGraphicWidget> createState() => _ServicesGraphicWidgetState();
}

class _ServicesGraphicWidgetState extends State<ServicesGraphicWidget> {
  List<String> selectedServices = [];

  @override
  Widget build(BuildContext context) {
    final servicesNames =
        widget.viewModel.totalBookingsPerService.keys.toList();
    final servicesBookings =
        widget.viewModel.totalBookingsPerService.values.toList();

    if (servicesNames.isEmpty || servicesBookings.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        Expanded(
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
                        if (value.toInt() < 0 ||
                            value.toInt() >= servicesNames.length) {
                          return SizedBox.shrink();
                        }
                        final serviceName = servicesNames[value.toInt()];
                        return Transform.rotate(
                          angle: -math.pi / 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              serviceName,
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                barGroups: List.generate(servicesBookings.length, (index) {
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: servicesBookings[index].toDouble(),
                        color: Colors.blue,
                        width: 10,
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
