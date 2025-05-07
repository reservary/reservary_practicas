import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:date_range_filter/date_range_filter.dart';
import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class PruebaFiltro extends StatefulWidget {
  const PruebaFiltro({super.key});

  @override
  State<PruebaFiltro> createState() => _PruebaFiltroState();
}

class _PruebaFiltroState extends State<PruebaFiltro> {
  List<DateTime?> _fechasCalendar = [];
  List<DateTime?> _fechasOmni = [];
  DateTime? _fechaSeleccionada;
  DateTime? _fechaInicio;
  DateTime? _fechaFin;

  Future<void> _seleccionarFecha(BuildContext context) async {
    print("Intentando seleccionar fecha");
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025, 12, 31),
      initialDatePickerMode: DatePickerMode.day,
      helpText: "Selecciona una fecha",
    );
    if (picked != null) {
      setState(() {
        _fechaSeleccionada = picked;
      });
    }
  }

  Future<void> _seleccionarFechas(BuildContext context) async {
    List<DateTime>? dateTimeList = await showOmniDateTimeRangePicker(
      context: context,
      startInitialDate: DateTime(2020),
      endInitialDate: DateTime(2025, 12, 31),
    );
    if (dateTimeList != null) {
      setState(() {
        _fechasOmni = dateTimeList;
      });
    }
  }

  Future<void> _seleccionarRangoFechas(BuildContext context) async {
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
  }

  @override
  Widget build(BuildContext context) {
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
              child: const Text('fecha'),
            ),
          ),
          Text("Prueba con DateRangeFilter"),
          ElevatedButton(
            onPressed: () {
              print('Botón presionado');
              _seleccionarRangoFechas(context);
            },
            child: const Text('Seleccionar Rango de Fechas'),
          ),
          _fechaInicio != null ? Text('Fecha inicio: $_fechaInicio') : Text(''),
          _fechaFin != null ? Text('Fecha fin: $_fechaFin') : Text(''),
          Text("Prueba con CalendarDatePicker2"),
          CalendarDatePicker2(
            config: CalendarDatePicker2Config(),
            value: _fechasCalendar,
            onValueChanged: (dates) {
              setState(() {
                _fechasCalendar = dates;
              });
            },
          ),
          Text('Fechas seleccionadas: ${_fechasCalendar.toString()}'),
          Text("Prueba con OmniDateTimePicker"),
          ElevatedButton(
            onPressed: () {
              _seleccionarFechas(context);
            },
            child: Text("Seleccionar fecha"),
          ),
          Text("Fechas seleccionadas: ${_fechasOmni.toString()}"),
        ],
      ),
    );
  }
}
