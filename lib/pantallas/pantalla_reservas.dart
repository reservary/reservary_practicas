import 'package:flutter/material.dart';
import 'package:tabla_reservary/nucleo/app_colores.dart';
import 'package:tabla_reservary/nucleo/styles_textos.dart';
import 'package:data_table_2/data_table_2.dart';

class Reserva {
  final String cliente;
  final DateTime fecha;
  final int personas;
  final String telefono;
  final String notas;

  Reserva({
    required this.cliente,
    required this.fecha,
    required this.personas,
    required this.telefono,
    required this.notas,
  });
}

class PantallaReservas extends StatefulWidget {
  const PantallaReservas({super.key});

  @override
  State<PantallaReservas> createState() => _PantallaReservasState();
}

class _PantallaReservasState extends State<PantallaReservas> {
  final List<Reserva> _reservas = [];
  final Set<Reserva> _selectedReservas = {};

  @override
  void initState() {
    super.initState();
  }

  void _sort<T>(
    Comparable<T> Function(Reserva r) getField,
    int columnIndex,
    bool ascending,
  ) {
    setState(() {
      //_sortColumnIndex = columnIndex;
      //_sortAscending = ascending;
      _reservas.sort((a, b) {
        final aValue = getField(a);
        final bValue = getField(b);
        return ascending
            ? (aValue).compareTo(bValue as T)
            : (bValue).compareTo(aValue as T);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColores.fondo,
      appBar: AppBar(
        title: Text('Reservas', style: StylesTextos.titulo),
        backgroundColor: AppColores.primaria,
        actions: [
          if (_selectedReservas.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.white),
              onPressed: () {
                setState(() {
                  _reservas.removeWhere((r) => _selectedReservas.contains(r));
                  _selectedReservas.clear();
                });
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          child: DataTable2(
            minWidth: 600,
            columnSpacing: 12,
            horizontalMargin: 12,
            headingRowHeight: 60,
            dataRowHeight: 60,
            dataTextStyle: StylesTextos.celda,
            headingTextStyle: StylesTextos.columna,
            headingRowColor: WidgetStateProperty.all(
              AppColores.fondoComponente,
            ),
            dataRowColor: WidgetStateProperty.resolveWith<Color?>((
              Set<WidgetState> states,
            ) {
              if (states.contains(WidgetState.selected)) {
                return AppColores.fondoComponenteSeleccionado;
              }
              return null;
            }),
            border: TableBorder.all(
              width: 1,
              borderRadius: BorderRadius.circular(8),
            ),
            columns: [
              DataColumn2(
                label: const Text('Cliente'),
                size: ColumnSize.L,
                onSort:
                    (columnIndex, ascending) =>
                        _sort<String>((r) => r.cliente, columnIndex, ascending),
              ),
              DataColumn2(
                label: const Text('Fecha'),
                size: ColumnSize.M,
                onSort:
                    (columnIndex, ascending) =>
                        _sort<DateTime>((r) => r.fecha, columnIndex, ascending),
              ),
              DataColumn2(
                label: const Text('Personas'),
                size: ColumnSize.S,
                onSort:
                    (columnIndex, ascending) =>
                        _sort<num>((r) => r.personas, columnIndex, ascending),
              ),
              DataColumn2(label: const Text('Teléfono'), size: ColumnSize.M),
              DataColumn2(label: const Text('Notas'), size: ColumnSize.L),
            ],
            rows:
                _reservas.map((reserva) {
                  final isSelected = _selectedReservas.contains(reserva);
                  return DataRow2(
                    selected: isSelected,
                    onSelectChanged: (selected) {
                      setState(() {
                        if (selected == true) {
                          _selectedReservas.add(reserva);
                        } else {
                          _selectedReservas.remove(reserva);
                        }
                      });
                    },
                    cells: [
                      DataCell(Text(reserva.cliente)),
                      DataCell(Text(reserva.fecha.toString().split(' ')[0])),
                      DataCell(Text(reserva.personas.toString())),
                      DataCell(Text(reserva.telefono)),
                      DataCell(Text(reserva.notas)),
                    ],
                  );
                }).toList(),
          ),
        ),
      ),
    );
  }
}
