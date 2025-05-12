import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:progresos_checks/datos/post_model_check.dart';

class GraficoMedidas extends StatelessWidget {
  final List<Check> checks;
  const GraficoMedidas({super.key, required this.checks});

  @override
  Widget build(BuildContext context) {
    if (checks.isEmpty || _todasLasMedidasSonNulas()) {
      return const SizedBox(
        height: 300,
        child: Center(
          child: Text(
            'No hay datos para mostrar.',
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    }

    return SizedBox(
      height: 400,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          _buildChartData(),
          duration: const Duration(milliseconds: 250),
        ),
      ),
    );
  }

  bool _todasLasMedidasSonNulas() {
    return checks.every((c) =>
      (double.tryParse(c.checkWaist) ?? 0) == 0 &&
      (double.tryParse(c.checkChest) ?? 0) == 0 &&
      (double.tryParse(c.checkThigh) ?? 0) == 0
    );
  }

  LineChartData _buildChartData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipRoundedRadius: 8,
          tooltipPadding: const EdgeInsets.all(8),
          tooltipBorder: BorderSide.none,
        ),
      ),
      gridData: const FlGridData(show: true),
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            reservedSize: 50,
            getTitlesWidget: (double value, TitleMeta meta) {
              final int index = value.toInt();
              if (index < 0 || index >= checks.length) return const SizedBox.shrink();
              final fechaStr = checks[index].createdDate;
              DateTime fecha;
              try {
                fecha = DateTime.parse(fechaStr);
              } catch (_) {
                return const SizedBox.shrink();
              }
              return SideTitleWidget(
                meta: meta,
                space: 8,
                child: Column(
                  children: [
                    Text("Check" + checks[index].postId.toString()),
                    Text(checks[index].createdDate, style: const TextStyle(fontSize: 12),
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
            interval: 5,
            reservedSize: 70,
            getTitlesWidget: (double value, TitleMeta meta) {
              return SideTitleWidget(
                meta: meta,
                child: Text(
                  '${value.toInt()} cm',
                  style: const TextStyle(fontSize: 15),
                ),
              );
            },
          ),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Colors.black, width: 2),
          left: BorderSide(color: Colors.black, width: 2),
        ),
      ),
      minX: 0,
      maxX: (checks.length - 1).toDouble(),
      minY: _getMinY(),
      maxY: _getMaxY(),
      lineBarsData: [
        _buildLine(
          checks,
          (c) => double.tryParse(c.checkWaist) ?? 0.0,
          Colors.green,
        ),
        _buildLine(
          checks,
          (c) => double.tryParse(c.checkChest) ?? 0.0,
          Colors.pink,
        ),
        _buildLine(
          checks,
          (c) => double.tryParse(c.checkThigh) ?? 0.0,
          Colors.blue,
        ),
      ],
    );
  }

  double _getMinY() {
    final allValues = checks.expand(
      (c) => [
        double.tryParse(c.checkWaist) ?? 0.0,
        double.tryParse(c.checkChest) ?? 0.0,
        double.tryParse(c.checkThigh) ?? 0.0,
      ],
    );
    return (allValues.reduce((a, b) => a < b ? a : b) - 5).clamp(0, double.infinity);
  }

  double _getMaxY() {
    final allValues = checks.expand(
      (c) => [
        double.tryParse(c.checkWaist) ?? 0.0,
        double.tryParse(c.checkChest) ?? 0.0,
        double.tryParse(c.checkThigh) ?? 0.0,
      ],
    );
    return allValues.reduce((a, b) => a > b ? a : b) + 5;
  }

  LineChartBarData _buildLine(
    List<Check> data,
    double Function(Check) getValue,
    Color color,
  ) {
    final spots = data.asMap().entries.map((entry) {
      final x = entry.key.toDouble();
      final y = getValue(entry.value);
      return FlSpot(x, y);
    }).toList();

    return LineChartBarData(
      spots: spots,
      isCurved: true,
      color: color,
      barWidth: 4,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: true),
      belowBarData: BarAreaData(show: false),
    );
  }
}
