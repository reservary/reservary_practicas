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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(  // Expande verticalmente el gráfico para ocupar espacio disponible
          child: LayoutBuilder(
            builder: (context, constraints) {
              double chartWidth = checks.length * 150;

              return SingleChildScrollView(
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
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Wrap(
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 12,
              runSpacing: 8,
              children: _buildLeyenda(),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  LineChartData _buildChartData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: true,
        handleBuiltInTouches: true,
        getTouchedSpotIndicator: (barData, spotIndexes) {
          return spotIndexes.map((index) {
            return TouchedSpotIndicatorData(
              FlLine(color: Colors.black.withOpacity(0.3), strokeWidth: 1),
              FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                  radius: 5,
                  color: barData.color ?? Colors.blue,
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
                '${spot.bar.color != null ? '' : ''}${spot.y.toStringAsFixed(1)} cm',
                const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              );
            }).toList();
          },
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
                space: 12,
                child: Text(
                  '${value.toInt()} cm',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600), // fuente más pequeña
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
      Colors.yellow,
      Colors.indigo,
      Colors.green,
      Colors.teal,
      Colors.blue,
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
      barWidth: 8, // líneas más gruesas
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
    );
  }

  List<Widget> _buildLeyenda() {
    final List<Color> colores = [
      Colors.red,
      Colors.orange,
      Colors.pink,
      Colors.yellow,
      Colors.indigo,
      Colors.green,
      Colors.teal,
      Colors.blue,
    ];

    return medidasSeleccionadas.asMap().entries.map((entry) {
      int i = entry.key;
      String medida = entry.value;

      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: colores[i % colores.length],
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(medida),
          const SizedBox(width: 12),
        ],
      );
    }).toList();
  }
}
