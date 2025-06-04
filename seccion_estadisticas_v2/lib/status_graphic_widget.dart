import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:seccion_estadisticas_v2/services/statistic_screen_viewmodel.dart';

class StatusGraphicWidget extends StatefulWidget {
  final StatisticsScreenViewModel viewModel;
  const StatusGraphicWidget({super.key, required this.viewModel});

  @override
  State<StatusGraphicWidget> createState() => _StatusGraphicWidgetState();
}

class _StatusGraphicWidgetState extends State<StatusGraphicWidget> {
  int isTouched = -1;

  @override
  Widget build(BuildContext context) {
    final totalBookingsByStatus = widget.viewModel.filteredStats?.totalBookingsByStatus?? widget.viewModel.totalBookingsByStatus;
    final List<String> status = totalBookingsByStatus.keys.toList();
    final List<int> statusValues = totalBookingsByStatus.values.toList();
    return Column(
      children: [
        Text(
          "Reservas por estado",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
        Expanded(
          flex: 9,
          child: Row(
            children: [
              Flexible(
                flex: 7,
                child: Column(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 315,
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
                                title:"${statusValues[index]}",
                                titleStyle: TextStyle(
                                  fontWeight: isTouched == index ? FontWeight.bold : FontWeight.normal,
                                ),
                                color: _getColorByStatus(status[index]),
                                radius: isTouched == index ? 120 : 110,
                                borderSide: BorderSide(
                                  width: isTouched == index ? 3 : 0,
                                ),
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
                            padding: const EdgeInsets.only(left: 6),
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
                            padding: const EdgeInsets.only(left: 4),
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
