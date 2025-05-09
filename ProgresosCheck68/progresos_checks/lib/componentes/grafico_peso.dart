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

  List<FlSpot> obtenerPuntosDePeso(List<Check> seleccionados) {
    return List.generate(
      seleccionados.length,
      (index) => FlSpot(
        index.toDouble(),
        double.tryParse(seleccionados[index].checkWeight) ?? 0.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final checksOrdenados = obtenerChecksFiltradosYOrdenados();
    final spots = obtenerPuntosDePeso(checksOrdenados);

    return AspectRatio(
      aspectRatio: 1.70,
      child: Padding(
        padding: const EdgeInsets.only(
          right: 18,
          left: 12,
          top: 24,
          bottom: 12,
        ),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(
              show: true,
              drawVerticalLine: true,
              horizontalInterval: 10,
              verticalInterval: 1,
              getDrawingHorizontalLine:
                  (_) => FlLine(
                    color: Colors.grey.withOpacity(0.3),
                    strokeWidth: 1,
                  ),
              getDrawingVerticalLine:
                  (_) => FlLine(
                    color: Colors.grey.withOpacity(0.3),
                    strokeWidth: 1,
                  ),
            ),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    final index = value.toInt();
                    if (index >= checksOrdenados.length) return Container();
                    
                    return SideTitleWidget(
                      child: Column(
                        children: [
                          Text("Check" + checksOrdenados[index].postId.toString()),
                          Text(checksOrdenados[index].createdDate)
                        ],
                      ),
                      /*
                      child: Text(fecha.substring(5)), // MM-DD
                      
                      */
                      meta: meta,
                    );
                  },
                  interval: 1,
                  reservedSize: 50,
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 10,
                  getTitlesWidget: (value, _) => Text('${value.toInt()} kg'),
                  reservedSize: 50,
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
              border: Border.all(color: Colors.grey),
            ),
            minX: 0,
            maxX: (spots.length - 1).toDouble(),
            minY: 0,
            maxY: spots.map((e) => e.y).fold(0.0, (a, b) => a > b ? a : b) + 10,
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                color: Colors.blueAccent,
                barWidth: 4,
                isStrokeCapRound: true,
                belowBarData: BarAreaData(
                  show: true,
                  color: Colors.blueAccent.withOpacity(0.2),
                ),
                dotData: const FlDotData(show: true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
