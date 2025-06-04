import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:seccion_estadisticas_v2/services/statistic_screen_viewmodel.dart';

class EmployeeGraphicWidget extends StatefulWidget {
  final StatisticsScreenViewModel viewModel;
  const EmployeeGraphicWidget({super.key, required this.viewModel});

  @override
  State<EmployeeGraphicWidget> createState() => _EmployeeGraphicWidgetState();
}

class _EmployeeGraphicWidgetState extends State<EmployeeGraphicWidget> {
  int isTouched = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, _) {
        final selectedEmployeeId = widget.viewModel.selectedEmployeeId;
        final employeesData = widget.viewModel.filteredStats?.totalBookingsPerEmployee ?? widget.viewModel.totalBookingsPerEmployee;

        final employeesNames =
            selectedEmployeeId != null
                ? [selectedEmployeeId]
                : employeesData.keys.toList();
        final employessBookings =
            selectedEmployeeId != null
                ? [
                  employeesData[selectedEmployeeId] ?? 0,
                ]
                : employeesData.values.toList();

        if (employeesNames.isEmpty || employessBookings.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 7,
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
                        sections: List.generate(employeesNames.length, (index) {
                          return PieChartSectionData(
                            value: employessBookings[index].toDouble(),
                            color: _getColorFromId(employeesNames[index]),
                            radius: isTouched == index ? 120 : 110,
                            borderSide: BorderSide(
                              width: isTouched == index ? 3 : 0,
                            ),
                            badgePositionPercentageOffset: 1.23,
                          );
                        }),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(employeesNames.length, (index) {
                        final idEmploye = employeesNames[index];
                        final color = _getColorFromId(idEmploye);

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
                              idEmploye.toUpperCase(),
                              style: TextStyle(
                                fontSize: isTouched == index ? 18 : 14,
                                fontWeight:
                                    isTouched == index
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
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
