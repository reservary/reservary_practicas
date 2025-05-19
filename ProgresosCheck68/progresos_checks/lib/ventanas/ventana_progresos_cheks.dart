import 'package:flutter/material.dart';
import 'package:progresos_checks/componentes/desplegable_checks.dart';
import 'package:progresos_checks/componentes/desplegable_medidas.dart';
import 'package:progresos_checks/componentes/grafico_medidas.dart';
import 'package:progresos_checks/componentes/grafico_peso.dart';
import 'package:progresos_checks/datos/post_model_check.dart';
import 'package:progresos_checks/nucleo/app_colores.dart';
import 'package:progresos_checks/nucleo/generador_checks.dart';

class VentanaProgresosChecks extends StatefulWidget {
  const VentanaProgresosChecks({super.key});

  @override
  State<VentanaProgresosChecks> createState() => _VentanaProgresosChecksState();
}

class _VentanaProgresosChecksState extends State<VentanaProgresosChecks> {
  Map<Check, bool> checksSeleccionados = {};
  List<String> medidasSeleccionadas = [];

  void actualizarChecksSeleccionados(List<Check> seleccionados) {
    setState(() {
      final checksDisponibles = GeneradorChecks.obtenerChecksEstaticos();
      checksSeleccionados = {
        for (var check in checksDisponibles)
          check: seleccionados.any((c) => c.postId == check.postId)
      };
    });
  }

  void actualizarMedidasSeleccionadas(List<String> seleccionadas) {
    setState(() {
      medidasSeleccionadas = seleccionadas;
    });
  }

  @override
  Widget build(BuildContext context) {
    final checksDisponibles = GeneradorChecks.obtenerChecksEstaticos();

    final medidasDisponibles = [
      'Peso',
      'Cuello',
      'Pecho',
      'Bíceps',
      'Antebrazo',
      'Cintura',
      'Cadera',
      'Muslo',
      'Pantorrilla',
    ];

    final checksParaGraficos = checksSeleccionados.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    return Container(
      color: AppColores.fondo,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            DesplegableChecks(
              titulo: "SELECCIONAR CHECKS",
              elementos: checksDisponibles,
              onSelectionChanged: actualizarChecksSeleccionados,
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                color: AppColores.fondoComponentes,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(20.0),
              height: 400,
              width: double.infinity,
              child: checksSeleccionados.isEmpty ||
                      checksSeleccionados.values.every((v) => !v)
                  ? const Center(
                      child: Text(
                        'No hay datos para mostrar en peso.',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  : GraficoPeso(checksSeleccionados: checksSeleccionados),
            ),
            const SizedBox(height: 24),
            DesplegableMedidas(
              titulo: "SELECCIONAR MEDIDAS",
              medidasDisponibles: medidasDisponibles,
              onSelectionChanged: actualizarMedidasSeleccionadas,
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                color: AppColores.fondoComponentes,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(20.0),
              height: 400,
              width: double.infinity,
              child: checksParaGraficos.isEmpty || medidasSeleccionadas.isEmpty
                  ? const Center(
                      child: Text(
                        'No hay datos para mostrar.',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width:
                            (checksParaGraficos.length * 200).toDouble().clamp(300, 1000),
                        child: GraficoMedidas(
                          checks: checksParaGraficos,
                          medidasSeleccionadas: medidasSeleccionadas,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
