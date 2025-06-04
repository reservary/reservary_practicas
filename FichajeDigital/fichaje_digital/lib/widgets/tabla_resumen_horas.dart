import 'package:fichaje_digital/modelo/asistencia.dart';
import 'package:flutter/material.dart';


class TablaResumenHoras extends StatelessWidget {
  final List<Asistencia> registros;

  const TablaResumenHoras({super.key, required this.registros});

  Map<String, Duration> _calcularHorasPorDia() {
    Map<String, Duration> resumen = {};
    DateTime? ultimaEntrada;

    for (var reg in registros) {
      final fechaClave = "${reg.fechaRegistro.year}-${reg.fechaRegistro.month.toString().padLeft(2, '0')}-${reg.fechaRegistro.day.toString().padLeft(2, '0')}";

      if (reg.tipo == 'entrada') {
        ultimaEntrada = reg.fechaRegistro;
      } else if (reg.tipo == 'salida' && ultimaEntrada != null) {
        final duracion = reg.fechaRegistro.difference(ultimaEntrada);
        resumen.update(fechaClave, (prev) => prev + duracion, ifAbsent: () => duracion);
        ultimaEntrada = null;
      }
    }

    return resumen;
  }

  String _formatearDuracion(Duration duracion) {
    String dosCifras(int n) => n.toString().padLeft(2, '0');
    return "${dosCifras(duracion.inHours)}:${dosCifras(duracion.inMinutes.remainder(60))}:${dosCifras(duracion.inSeconds.remainder(60))}";
  }

  @override
  Widget build(BuildContext context) {
    final resumen = _calcularHorasPorDia();

    if (resumen.isEmpty) {
      return const Text('No hay datos para mostrar aún.');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text(
          'Resumen diario de horas trabajadas',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Table(
          border: TableBorder.all(),
          columnWidths: const {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(1.5),
            2: FlexColumnWidth(1.5),
          },
          children: [
            const TableRow(
              decoration: BoxDecoration(color: Colors.grey),
              children: [
                Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Fecha', style: TextStyle(fontWeight: FontWeight.bold))),
                Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Horas trabajadas', style: TextStyle(fontWeight: FontWeight.bold))),
                Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Horas extra', style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
            ...resumen.entries.map((entry) {
              final total = entry.value;
              final horasExtras = total > const Duration(hours: 8)
                  ? total - const Duration(hours: 8)
                  : Duration.zero;

              return TableRow(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8), child: Text(entry.key)),
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(_formatearDuracion(total))),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      horasExtras > Duration.zero ? _formatearDuracion(horasExtras) : "-",
                      style: TextStyle(color: horasExtras > Duration.zero ? Colors.red : Colors.black),
                    ),
                  ),
                ],
              );
            }).toList(),
          ],
        ),
      ],
    );
  }
}
