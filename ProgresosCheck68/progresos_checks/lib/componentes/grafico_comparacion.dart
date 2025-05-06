
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
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                color: AppColores.fondoComponentes, 
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Método para construir el gráfico 
  Widget buildChart() {
    final selectedChecks = widget.checksSeleccionados;

    if (selectedChecks.isEmpty) {
      return Center(child: Text("No hay datos seleccionados"));
    }

    return BarChart(
      BarChartData(
        barGroups: selectedChecks.map((check) {
          return BarChartGroupData(
            x: check.postId,
            barRods: [BarChartRodData(toY: double.parse(check.checkWeight), color: Colors.blue)],
          );
        }).toList(),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
        ),
      ),
    );
  }
}