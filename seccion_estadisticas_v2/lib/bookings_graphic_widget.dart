import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seccion_estadisticas_v2/models/progress.dart';
import 'package:seccion_estadisticas_v2/models/statistics.dart';

class BookingsGraphicWidget extends StatefulWidget {
  final Statistics stats;
  const BookingsGraphicWidget({super.key, required this.stats});

  @override
  State<BookingsGraphicWidget> createState() => _BookingsGraphicWidgetState();
}

class _BookingsGraphicWidgetState extends State<BookingsGraphicWidget> {
  DateTime? _startDate;
  DateTime? _endDate;
  final _dateFormat = DateFormat('dd/MM/yyyy');
  List<Progress> _filteredProgress = [];

  @override
  void initState() {
    super.initState();
    _filteredProgress = List.from(
      widget.stats.progress,
    )..sort((a, b) => DateTime.parse(a.date).compareTo(DateTime.parse(b.date)));
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? selectedRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDateRange:
          _startDate != null && _endDate != null
              ? DateTimeRange(start: _startDate!, end: _endDate!)
              : DateTimeRange(
                start: DateTime(2025, 01, 01),
                end: DateTime.now(),
              ),
      initialEntryMode: DatePickerEntryMode.input,
      helpText: "Selecciona el rango",
      locale: Locale("es", "ES"),
    );
    if (selectedRange != null) {
      setState(() {
        _startDate = selectedRange.start;
        _endDate = selectedRange.end;
        _filteredProgress = _getFilteredProgress();
      });
    }
  }

  String _formatDate(DateTime date) {
    return _dateFormat.format(date);
  }

  String _formatDateFromString(String dateStr) {
    final date = DateTime.parse(dateStr);
    return _formatDate(date);
  }

  List<Progress> _getFilteredProgress() {
    if (_startDate == null || _endDate == null) {
      return List.from(widget.stats.progress)..sort(
        (a, b) => DateTime.parse(a.date).compareTo(DateTime.parse(b.date)),
      );
    }

    return widget.stats.progress.where((p) {
        final filteredDates = DateTime.parse(p.date);
        return filteredDates.isAfter(_startDate!.subtract(Duration(days: 1))) &&
            filteredDates.isBefore(_endDate!.add(Duration(days: 1)));
      }).toList()
      ..sort(
        (a, b) => DateTime.parse(a.date).compareTo(DateTime.parse(b.date)),
      );
  }

  @override
  Widget build(BuildContext context) {
    final spots = List<FlSpot>.generate(_filteredProgress.length, (index) {
      return FlSpot(
        index.toDouble(),
        _filteredProgress[index].bookings.toDouble(),
      );
    });
    return SizedBox(
      height: 315,
      child: Column(
        children: [
          SizedBox(
            child: SizedBox(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: IconButton(
                      onPressed: () => _selectDateRange(context),
                      icon: Icon(Icons.filter_alt),
                      tooltip: "Filtrar",
                    ),
                  ),
                ],
              ),
            ),
          ),
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
                            if (index >= 0 &&
                                index < _filteredProgress.length) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  _formatDateFromString(
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
                        HorizontalLine(
                          y: 0,
                          color: Colors.black,
                          strokeWidth: 2,
                        ),
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
      ),
    );
  }
}
