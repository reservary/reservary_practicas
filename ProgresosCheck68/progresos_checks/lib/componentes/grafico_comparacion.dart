
import 'package:flutter/material.dart';
import 'package:progresos_checks/componentes/grafico_peso.dart';
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
            "Gráfico de Peso".toUpperCase(),
            style: EstilosTexto.titulos,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 20),
        Expanded(child: buildChart()),
      ],
    );
  }

  Widget buildChart() {
    final selectedChecks = widget.checksSeleccionados;

    if (selectedChecks.isEmpty) {
      return const Center(child: Text("No hay datos seleccionados"));
    }

    // Calcular un ancho suficiente basado en la cantidad de checks
    double chartWidth = selectedChecks.length * 200;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: chartWidth,
        height: 400, // Puedes ajustar la altura según tu diseño
        child: GraficoPeso(checksSeleccionados: {
          for (var c in selectedChecks) c: true
        }),
      ),
    );
  }
}
