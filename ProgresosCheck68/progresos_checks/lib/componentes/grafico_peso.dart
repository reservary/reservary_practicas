import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:progresos_checks/datos/post_model_check.dart';

class GraficoPeso extends StatelessWidget {
  final Map<Check, bool> checksSeleccionados;

  const GraficoPeso({super.key, required this.checksSeleccionados});

  List<Check> obtenerChecksFiltradosYOrdenados() {
    return checksSeleccionados.entries
        .where((e) => e.value)
        .map((e) => e.key)
        .toList()
      ..sort((a, b) => a.createdDate.compareTo(b.createdDate));
  }

  @override
  Widget build(BuildContext context) {
    final checksOrdenados = obtenerChecksFiltradosYOrdenados();

    if (checksOrdenados.isEmpty) {
      return const Center(
        child: Text(
          'No hay datos para mostrar en peso.',
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final chartWidth = checksOrdenados.length * 150.0;

        final spots = List.generate(
          checksOrdenados.length,
          (index) => FlSpot(
            index.toDouble(),
            double.tryParse(checksOrdenados[index].checkWeight) ?? 0.0,
          ),
        );

        final maxY = (spots.map((s) => s.y).fold(0.0, (a, b) => a > b ? a : b) + 10).ceilToDouble();

        return SizedBox(
          height: constraints.maxHeight,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: chartWidth,
              height: constraints.maxHeight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: LineChart(
                  LineChartData(
                    lineTouchData: LineTouchData(
                      enabled: true,
                      handleBuiltInTouches: true,
                      getTouchedSpotIndicator: (barData, spotIndexes) {
                        return spotIndexes.map((index) {
                          return TouchedSpotIndicatorData(
                            FlLine(color: Colors.blueAccent.withOpacity(0.4), strokeWidth: 3),
                            FlDotData(
                              show: true,
                              getDotPainter: (spot, percent, bar, index) =>
                                  FlDotCirclePainter(
                                    radius: 6,
                                    color: Colors.blueAccent,
                                    strokeWidth: 2,
                                    strokeColor: Colors.white,
                                  ),
                            ),
                          );
                        }).toList();
                      },
                      touchTooltipData: LineTouchTooltipData(
                        tooltipRoundedRadius: 8,
                        tooltipPadding: const EdgeInsets.all(8),
                        tooltipBorder: BorderSide(color: Colors.black12),
                        getTooltipItems: (touchedSpots) {
                          return touchedSpots.map((spot) {
                            return LineTooltipItem(
                              '${spot.y.toStringAsFixed(1)} kg',
                              const TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }).toList();
                        },
                      ),
                    ),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: true,
                      horizontalInterval: 10,
                      verticalInterval: 1,
                      getDrawingHorizontalLine: (_) => FlLine(
                        color: Colors.grey.withOpacity(0.3),
                        strokeWidth: 1,
                      ),
                      getDrawingVerticalLine: (_) => FlLine(
                        color: Colors.grey.withOpacity(0.3),
                        strokeWidth: 1,
                      ),
                    ),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 1,
                          reservedSize: 50,
                          getTitlesWidget: (value, meta) {
                            final index = value.toInt();
                            if (index < 0 || index >= checksOrdenados.length) return const SizedBox.shrink();

                            final check = checksOrdenados[index];
                            return SideTitleWidget(
                              meta: meta,
                              space: 8,
                              child: Column(
                                children: [
                                  Text("Check ${check.postId}"),
                                  Text(
                                    check.createdDate,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 10,
                          reservedSize: 50,
                          getTitlesWidget: (value, _) => Text('${value.toInt()} kg'),
                        ),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: const Border(
                        bottom: BorderSide(color: Colors.black, width: 2),
                        left: BorderSide(color: Colors.black, width: 2),
                      ),
                    ),
                    minX: 0,
                    maxX: (spots.length - 1).toDouble(),
                    minY: 0,
                    maxY: maxY,
                    lineBarsData: [
                      LineChartBarData(
                        spots: spots,
                        isCurved: true,
                        color: Colors.blueAccent,
                        barWidth: 8, // línea más gruesa
                        isStrokeCapRound: true,
                        dotData: const FlDotData(show: false), // puntos ocultos normalmente
                        belowBarData: BarAreaData(
                          show: true,
                          color: Colors.blueAccent.withOpacity(0.2),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
