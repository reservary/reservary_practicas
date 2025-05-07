import 'package:date_range_filter/date_range_filter.dart';
import 'package:flutter/material.dart';

class PruebaFiltro extends StatefulWidget {
  const PruebaFiltro({super.key});

  @override
  State<PruebaFiltro> createState() => _PruebaFiltroState();
}

class _PruebaFiltroState extends State<PruebaFiltro> {
  DateTime? _fechaSeleccionada;

  Future<void> _seleccionarFecha(BuildContext context) async {
    print("Intentando seleccionar fecha");
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025, 12, 31),
    );
    if (picked != null) {
      setState(() {
        _fechaSeleccionada = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime? _fechaInicio;
    DateTime? _fechaFin;
    return Scaffold(
      appBar: AppBar(title: const Text('Prueba de Filtro')),
      body: Column(
        children: [
          Text("Prueba con showDatePicker"),
          Text('Fecha seleccionada: ${_fechaSeleccionada?.toString()}'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                print('Botón presionado');
                _seleccionarFecha(context);
              },
              child: const Text('¡Haz clic en mí!'), // Cambié el texto aquí
            ),
          ),
          Text("Prueba con DateRangeFilter"),
          ElevatedButton(
            onPressed: () async {
              DateRangeResult? dateRange =
                  await DateRangeFilter(
                    labelColor: Colors.white,
                    context: context,
                    color: Colors.blue,
                  ).getSelectedDate;
              if (dateRange != null) {
                setState(() {
                  _fechaInicio = dateRange.startDate;
                  _fechaFin = dateRange.endDate;
                });
              }
            },
            child: const Text('Seleccionar Rango de Fechas'),
          ),
          _fechaInicio != null ? Text('Fecha inicio: $_fechaInicio') : Text(''),
          _fechaFin != null ? Text('Fecha fin: $_fechaFin') : Text(''),
        ],
      ),
    );
  }
}
