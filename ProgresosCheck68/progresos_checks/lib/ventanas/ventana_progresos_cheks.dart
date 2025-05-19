import 'package:flutter/material.dart';
import 'package:progresos_checks/componentes/desplegable_checks.dart';
import 'package:progresos_checks/componentes/desplegable_medidas.dart';
import 'package:progresos_checks/componentes/grafico_medidas.dart';
import 'package:progresos_checks/componentes/grafico_peso.dart';
import 'package:progresos_checks/datos/post_model_check.dart';
import 'package:progresos_checks/nucleo/app_colores.dart';
import 'package:progresos_checks/nucleo/estilos_texto.dart';
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

    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(color: AppColores.fondo),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: DesplegableChecks(
                titulo: "SELECCIONAR CHECKS",
                elementos: checksDisponibles,
                onSelectionChanged: actualizarChecksSeleccionados,
              ),
            ),

            // Gráfico de peso expandido con scroll horizontal
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
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
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minWidth: screenWidth),
                          child: GraficoPeso(
                            checksSeleccionados: checksSeleccionados,
                          ),
                        ),
                      ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: DesplegableMedidas(
                titulo: "SELECCIONAR MEDIDAS",
                medidasDisponibles: medidasDisponibles,
                onSelectionChanged: actualizarMedidasSeleccionadas,
              ),
            ),

            // Gráfico de medidas expandido con scroll horizontal
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColores.fondoComponentes,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(20.0),
                height: 600,
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
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minWidth: screenWidth),
                          child: GraficoMedidas(
                            checks: checksParaGraficos,
                            medidasSeleccionadas: medidasSeleccionadas,
                          ),
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
