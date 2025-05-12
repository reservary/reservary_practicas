import 'package:flutter/material.dart';
import 'package:progresos_checks/componentes/desplegable_progresos_checks.dart';
import 'package:progresos_checks/componentes/grafico_comparacion.dart';
import 'package:progresos_checks/componentes/grafico_medidas.dart';
import 'package:progresos_checks/controlador/controlador_progresos.dart';
import 'package:progresos_checks/datos/post_model_check.dart';
import 'package:progresos_checks/nucleo/app_colores.dart';
import 'package:progresos_checks/nucleo/estilos_texto.dart';

class VentanaProgresosChecks extends StatefulWidget {
  const VentanaProgresosChecks({super.key});

  @override
  State<VentanaProgresosChecks> createState() => _VentanaProgresosChecksState();
}

class _VentanaProgresosChecksState extends State<VentanaProgresosChecks> {
  bool mostrarDesplegable = false;
  final ControladorProgresos controladorProgresos = ControladorProgresos();
  List<Check> checksSeleccionados = [];
  void actualizarSeleccion(List<Check> seleccionados) {
    setState(() {
      checksSeleccionados = seleccionados;
      controladorProgresos.actualizarSeleccion(seleccionados);
    });
  }

  @override
  Widget build(BuildContext context) {
    double chartWidth = checksSeleccionados.length * 200;
    return Container(
      decoration: BoxDecoration(color: AppColores.fondo),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColores.fondoComponentes,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      mostrarDesplegable = !mostrarDesplegable;
                    });
                  },
                  child: Text(
                    mostrarDesplegable
                        ? "Ocultar selección"
                        : "Seleccionar checks",
                    style: EstilosTexto.titulos,
                  ),
                ),
              ),
            ),
            if (mostrarDesplegable)
              Container(
                height: 400,
                width: 400,
                decoration: BoxDecoration(color: AppColores.fondoComponentes),
                child: DesplegableProgresosChecks(
                  onSelectionChanged: actualizarSeleccion,
                ),
              ),

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColores.fondoComponentes,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    height: 500,
                    width: double.infinity,

                    child: GraficoComparacion(
                      checksSeleccionados: checksSeleccionados,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColores.fondoComponentes,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    height: 500,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Text("GRAFICO DE MEDIDAS", style: EstilosTexto.titulos,),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: SizedBox(
                              height: 400,
                              width: chartWidth,
                              child: GraficoMedidas(checks: checksSeleccionados),
                            ),
                          ),
                        ),
                      ],
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
