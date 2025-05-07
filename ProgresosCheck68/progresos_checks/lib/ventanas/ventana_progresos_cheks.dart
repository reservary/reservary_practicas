
import 'package:flutter/material.dart';
import 'package:progresos_checks/componentes/desplegable_progresos_checks.dart';
import 'package:progresos_checks/componentes/grafico_comparacion.dart';
import 'package:progresos_checks/controlador/controlador_progresos.dart';
import 'package:progresos_checks/datos/post_model_check.dart';
import 'package:progresos_checks/nucleo/app_colores.dart';

class VentanaProgresosChecks extends StatefulWidget {
  const VentanaProgresosChecks({super.key});

  @override
  State<VentanaProgresosChecks> createState() => _VentanaProgresosChecksState();
}

class _VentanaProgresosChecksState extends State<VentanaProgresosChecks> {
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
    return Container(
      decoration: BoxDecoration(color: AppColores.fondo),
      child: Row(
        children: [
          SizedBox(
            width: 300,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: DesplegableProgresosChecks(onSelectionChanged: actualizarSeleccion),
            )),
          Expanded(child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: GraficoComparacion(checksSeleccionados: checksSeleccionados),
          )),
        ],
      ),
    );
  }
}