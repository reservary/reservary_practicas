import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seccion_estadisticas_v2/models/progress.dart';
import 'package:seccion_estadisticas_v2/services/statistic_screen_viewmodel.dart';

class BookingsGraphicWidget extends StatefulWidget {
  final StatisticsScreenViewModel viewModel;
  const BookingsGraphicWidget({super.key, required this.viewModel});

  @override
  State<BookingsGraphicWidget> createState() => _BookingsGraphicWidgetState();
}

class _BookingsGraphicWidgetState extends State<BookingsGraphicWidget> {
  List<Progress> _filteredProgress = [];

  @override
  void initState() {
    super.initState();
    _filteredProgress = List.from(
      widget.viewModel.allProgress,
    )..sort((a, b) => DateTime.parse(a.date).compareTo(DateTime.parse(b.date)));
  }

  //

  // List<Progress> _getFilteredProgress() {
  //   if (_startDate == null || _endDate == null) {
  //     return List.from(widget.stats.progress)..sort(
  //       (a, b) => DateTime.parse(a.date).compareTo(DateTime.parse(b.date)),
  //     );
  //   }

  //   return widget.stats.progress.where((p) {
  //       final filteredDates = DateTime.parse(p.date);
  //       return filteredDates.isAfter(_startDate!.subtract(Duration(days: 1))) &&
  //           filteredDates.isBefore(_endDate!.add(Duration(days: 1)));
  //     }).toList()
  //     ..sort(
  //       (a, b) => DateTime.parse(a.date).compareTo(DateTime.parse(b.date)),
  //     );
  // }

  @override
  Widget build(BuildContext context) {
    final spots = List<FlSpot>.generate(_filteredProgress.length, (index) {
      return FlSpot(
        index.toDouble(),
        _filteredProgress[index].bookings.toDouble(),
      );
    });
    return Column(
      children: [
        Expanded(
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 8,
                left: 16,
                right: 16,
                bottom: 16,
              ),
              child: LineChart(
                LineChartData(
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map((LineBarSpot touchedSpot) {
                          final index = touchedSpot.x.toInt();
                          final entry = _filteredProgress[index];
                          return LineTooltipItem(
                            "Billed amount: ${entry.billedAmount}€",
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
                        minIncluded: false,
                        showTitles: true,
                        interval: 5,
                        reservedSize: 25,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        minIncluded: true,
                        showTitles: true,
                        reservedSize: 20,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index >= 0 && index < _filteredProgress.length) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                widget.viewModel.formatDateFromString(
                                  _filteredProgress[index].date,
                                ),
                                style: TextStyle(fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          }
                          return Text("");
                        },
                      ),
                    ),
                    show: true,
                  ),
                  extraLinesData: ExtraLinesData(
                    horizontalLines: [
                      HorizontalLine(y: 0, color: Colors.black, strokeWidth: 2),
                    ],
                    verticalLines: [
                      VerticalLine(x: 0, color: Colors.black, strokeWidth: 2),
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
                      belowBarData: BarAreaData(show: true),
                      spots: spots,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
