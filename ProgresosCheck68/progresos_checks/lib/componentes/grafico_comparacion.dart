import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:progresos_checks/datos/post_model_check.dart';
import 'package:progresos_checks/nucleo/app_colores.dart';
import 'package:progresos_checks/nucleo/estilos_texto.dart';

class GraficoComparacion extends StatefulWidget {
  final List<Check> checksSeleccionados;
  const GraficoComparacion({super.key, required this.checksSeleccionados});

  @override
  State<GraficoComparacion> createState() => _GraficoComparacionState();
}

class _GraficoComparacionState extends State<GraficoComparacion> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: Text(
            "Gráfico de comparación".toUpperCase(),
            style: EstilosTexto.titulos,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 20),
        Expanded(child: buildChart()),
      ],
    );
  }

  // Método para construir el gráfico
  Widget buildChart() {
  final selectedChecks = widget.checksSeleccionados;

  if (selectedChecks.isEmpty) {
    return Center(child: Text("No hay datos seleccionados"));
  }

  // Calcular un ancho suficiente basado en la cantidad de checks
  double chartWidth = selectedChecks.length * 200;

  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: SizedBox(
      width: chartWidth,
      height: 400, // Puedes ajustar la altura según tu diseño
      child: BarChart(
        BarChartData(
          maxY: 200,
          barGroups: selectedChecks.map((check) {
            return BarChartGroupData(
              x: check.postId,
              barRods: [
                BarChartRodData(toY: double.parse(check.checkWeight), color: Colors.brown, width: 20),
                BarChartRodData(toY: double.parse(check.checkNeck), color: Colors.red, width: 20),
                BarChartRodData(toY: double.parse(check.checkChest), color: Colors.orange, width: 20),
                BarChartRodData(toY: double.parse(check.checkBiceps), color: Colors.yellow, width: 20),
                BarChartRodData(toY: double.parse(check.checkForearm), color: Colors.green, width: 20),
                BarChartRodData(toY: double.parse(check.checkWaist), color: Colors.lightBlue, width: 20),
                BarChartRodData(toY: double.parse(check.checkHip), color: Colors.blueAccent, width: 20),
                BarChartRodData(toY: double.parse(check.checkThigh), color: Colors.purple, width: 20),
                BarChartRodData(toY: double.parse(check.checkCalf), color: Colors.pink, width: 20),
              ],
            );
          }).toList(),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                reservedSize: 40,
                showTitles: true,
                interval: 10,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: TextStyle(fontSize: 20),
                  );
                },
              ),
            ),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 70,
                getTitlesWidget: (double value, TitleMeta meta) {
                   // Filtrar correctamente el Check por su postId
                final check = widget.checksSeleccionados.firstWhere(
                  (c) => c.postId == value.toInt(),
                );
                  if (check == null) return Container();

                  return Column(
                    children: [
                      Text("Check${check.postId}", style: TextStyle(fontSize: 16)),
                      Text("Fecha: ${check.createdDate}", style: TextStyle(fontSize: 12)),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

}
