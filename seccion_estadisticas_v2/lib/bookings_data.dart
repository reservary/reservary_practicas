import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:seccion_estadisticas_v2/models/statistics.dart';

class BookingsData extends StatefulWidget {
  final Statistics stats;
  const BookingsData({super.key, required this.stats});

  @override
  State<BookingsData> createState() => _BookingsDataState();
}

class _BookingsDataState extends State<BookingsData> {
  DateTimeRange? _selectedRange;
  DateTime? _startDate;
  DateTime? _endDate;

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? selectedRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDateRange: DateTimeRange(start: DateTime(2025,01,01), end: DateTime.now()),
      initialEntryMode: DatePickerEntryMode.input,
      helpText: "Selecciona el rango",
      locale: Locale("es", "ES"),
    );
    if (selectedRange != null) {
      setState(() {
        _startDate = selectedRange.start;
        _endDate = selectedRange.end;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress = widget.stats.progress;
    final spots = List<FlSpot>.generate(progress.length, (index) {
      return FlSpot(index.toDouble(), progress[index].bookings.toDouble());
    });
    final dates = progress.map((p) => p.date).toList();
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
                            final entry = progress[index];
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
                            if (index >= 0 && index < dates.length) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  dates[index],
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
