import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:progresos_checks/datos/post_model_check.dart';

class GraficoMedidas extends StatelessWidget {
  final List<Check> checks;
  final List<String> medidasSeleccionadas;

  const GraficoMedidas({
    super.key,
    required this.checks,
    required this.medidasSeleccionadas,
  });

  @override
  Widget build(BuildContext context) {
    if (checks.isEmpty || medidasSeleccionadas.isEmpty) {
      return const Center(
        child: Text(
          'No hay datos para mostrar.',
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        double chartWidth = checks.length * 200;

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
                  _buildChartData(),
                  duration: const Duration(milliseconds: 250),
                ),
              ),
            ),
          ),
        );
      },
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
      gridData: const FlGridData(show: false),
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            reservedSize: 50,
            getTitlesWidget: (double value, TitleMeta meta) {
              final int index = value.toInt();
              if (index < 0 || index >= checks.length) return const SizedBox.shrink();
              return SideTitleWidget(
                meta: meta,
                space: 8,
                child: Column(
                  children: [
                    Text("Check ${checks[index].postId}"),
                    Text(
                      checks[index].createdDate,
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
      minY: 0,
      maxY: _getRoundedMaxY(),
      lineBarsData: _buildSelectedLines(),
    );
  }

  List<LineChartBarData> _buildSelectedLines() {
    final List<Color> colores = [
      Colors.red,
      Colors.orange,
      Colors.pink,
      Colors.purple,
      Colors.indigo,
      Colors.green,
      Colors.teal,
      Colors.blue,
      Colors.brown,
    ];

    return medidasSeleccionadas.asMap().entries.map((entry) {
      int i = entry.key;
      String medida = entry.value;

      double Function(Check) getValue;

      switch (medida) {
        case 'Peso':
          getValue = (c) => double.tryParse(c.checkWeight) ?? 0.0;
          break;
        case 'Cuello':
          getValue = (c) => double.tryParse(c.checkNeck) ?? 0.0;
          break;
        case 'Pecho':
          getValue = (c) => double.tryParse(c.checkChest) ?? 0.0;
          break;
        case 'Bíceps':
          getValue = (c) => double.tryParse(c.checkBiceps) ?? 0.0;
          break;
        case 'Antebrazo':
          getValue = (c) => double.tryParse(c.checkForearm) ?? 0.0;
          break;
        case 'Cintura':
          getValue = (c) => double.tryParse(c.checkWaist) ?? 0.0;
          break;
        case 'Cadera':
          getValue = (c) => double.tryParse(c.checkHip) ?? 0.0;
          break;
        case 'Muslo':
          getValue = (c) => double.tryParse(c.checkThigh) ?? 0.0;
          break;
        case 'Pantorrilla':
          getValue = (c) => double.tryParse(c.checkCalf) ?? 0.0;
          break;
        default:
          getValue = (_) => 0.0;
      }

      return _buildLine(checks, getValue, colores[i % colores.length]);
    }).toList();
  }

  double _getRoundedMaxY() {
    final allValues = checks.expand((c) => [
      double.tryParse(c.checkWeight) ?? 0.0,
      double.tryParse(c.checkNeck) ?? 0.0,
      double.tryParse(c.checkChest) ?? 0.0,
      double.tryParse(c.checkBiceps) ?? 0.0,
      double.tryParse(c.checkForearm) ?? 0.0,
      double.tryParse(c.checkWaist) ?? 0.0,
      double.tryParse(c.checkHip) ?? 0.0,
      double.tryParse(c.checkThigh) ?? 0.0,
      double.tryParse(c.checkCalf) ?? 0.0,
    ]);
    final maxValue = allValues.isEmpty ? 10 : allValues.reduce((a, b) => a > b ? a : b);
    return ((maxValue + 5) / 5).ceil() * 5;
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
