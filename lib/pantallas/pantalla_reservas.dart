import 'package:flutter/material.dart';
import 'package:tabla_reservary/nucleo/app_colores.dart';
import 'package:tabla_reservary/nucleo/styles_textos.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:tabla_reservary/modelos/reserva.dart';

/// Pantalla principal que muestra la tabla de reservas del local
class PantallaReservas extends StatefulWidget {
  const PantallaReservas({super.key});

  @override
  State<PantallaReservas> createState() => _PantallaReservasState();
}

class _PantallaReservasState extends State<PantallaReservas> {
  /// Lista que almacena todas las reservas, incializandose en una lista vacia
  final List<Reserva> _reservas = [];

  /// Lista filtrada de reservas basada en la búsqueda, incializandose en una lista vacia
  List<Reserva> _filteredReservas = [];

  /// Controlador para el campo de búsqueda, incializandose en un controlador vacio
  final TextEditingController _searchController = TextEditingController();

  /// Conjunto que almacena las reservas seleccionadas por el usuario, incializandose en un conjunto vacio
  final Set<Reserva> _selectedReservas = {};

  /// Índice de la columna actualmente ordenada, incializandose en null
  int? _sortColumnIndex;

  /// Indica si el ordenamiento es ascendente o descendente, incializandose en true
  bool _sortAscending = true;

  /// Mapa que controla la visibilidad de cada columna, incializandose en true
  final Map<String, bool> _columnVisibility = {
    'fecha': true,
    'estado': true,
    'plataforma': true,
    'empleado': true,
    'cliente': true,
    'servicios': true,
  };

  /// Columnas de la tabla
  List<DataColumn2> get _columnas {
    return [
      if (_columnVisibility['fecha']!)
        DataColumn2(
          label: InkWell(
            onTap: () {
              _sort<DateTime>((r) => r.fecha, 0, !_sortAscending);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Fecha/Hora'),
                if (_sortColumnIndex == 0)
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Icon(
                      _sortAscending
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                      size: 16,
                      color: AppColores.primaria,
                    ),
                  ),
              ],
            ),
          ),
          size: ColumnSize.M,
        ),
      if (_columnVisibility['estado']!)
        DataColumn2(
          label: InkWell(
            onTap: () {
              _sort<String>((r) => r.estado, 1, !_sortAscending);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Estado'),
                if (_sortColumnIndex == 1)
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Icon(
                      _sortAscending
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                      size: 16,
                      color: AppColores.primaria,
                    ),
                  ),
              ],
            ),
          ),
          size: ColumnSize.S,
        ),
      if (_columnVisibility['plataforma']!)
        DataColumn2(
          label: InkWell(
            onTap: () {
              _sort<String>((r) => r.plataforma, 2, !_sortAscending);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Plataforma'),
                if (_sortColumnIndex == 2)
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Icon(
                      _sortAscending
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                      size: 16,
                      color: AppColores.primaria,
                    ),
                  ),
              ],
            ),
          ),
          size: ColumnSize.M,
        ),
      if (_columnVisibility['empleado']!)
        DataColumn2(
          label: InkWell(
            onTap: () {
              _sort<String>((r) => r.empleado, 3, !_sortAscending);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Empleado'),
                if (_sortColumnIndex == 3)
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Icon(
                      _sortAscending
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                      size: 16,
                      color: AppColores.primaria,
                    ),
                  ),
              ],
            ),
          ),
          size: ColumnSize.M,
        ),
      if (_columnVisibility['cliente']!)
        DataColumn2(
          label: InkWell(
            onTap: () {
              _sort<String>((r) => r.cliente, 4, !_sortAscending);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Cliente'),
                if (_sortColumnIndex == 4)
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Icon(
                      _sortAscending
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                      size: 16,
                      color: AppColores.primaria,
                    ),
                  ),
              ],
            ),
          ),
          size: ColumnSize.L,
        ),
      if (_columnVisibility['servicios']!)
        DataColumn2(
          label: InkWell(
            onTap: () {
              _sort<String>((r) => r.servicios, 5, !_sortAscending);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Servicios'),
                if (_sortColumnIndex == 5)
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Icon(
                      _sortAscending
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                      size: 16,
                      color: AppColores.primaria,
                    ),
                  ),
              ],
            ),
          ),
          size: ColumnSize.L,
        ),
    ];
  }

  @override
  void initState() {
    super.initState();
    _cargarDatosEjemplo();
    _filteredReservas = List.from(_reservas);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Carga datos de ejemplo para la tabla
  void _cargarDatosEjemplo() {
    _reservas.addAll([
      Reserva(
        cliente: 'David Romero',
        fecha: DateTime.now().add(const Duration(hours: 2)),
        estado: 'Confirmada',
        plataforma: 'Web',
        empleado: 'Juan Pérez',
        servicios: 'Cena romántica, velas, flores, champán',
      ),
      Reserva(
        cliente: 'Laura Romero',
        fecha: DateTime.now().add(const Duration(days: 1)),
        estado: 'Pendiente',
        plataforma: 'Teléfono',
        empleado: 'María García',
        servicios: 'Comida empresa, proyector, wifi, 15 personas',
      ),
      Reserva(
        cliente: 'Cristina Romero',
        fecha: DateTime.now().add(const Duration(days: 3)),
        estado: 'Confirmada',
        plataforma: 'App',
        empleado: 'Carlos López',
        servicios: 'Cumpleaños, tarta, decoración, 8 personas',
      ),
      Reserva(
        cliente: 'Oscar Luis Romero',
        fecha: DateTime.now().add(const Duration(days: 2)),
        estado: 'Cancelada',
        plataforma: 'Web',
        empleado: 'Ana Martínez',
        servicios: 'Cena amigos, mesa redonda, 6 personas',
      ),
      Reserva(
        cliente: 'María Isabel Carpintero',
        fecha: DateTime.now().add(const Duration(days: 5)),
        estado: 'Confirmada',
        plataforma: 'Teléfono',
        empleado: 'Pedro Sánchez',
        servicios: 'Evento corporativo, catering, 50 personas',
      ),
      Reserva(
        cliente: 'Pilar Martín',
        fecha: DateTime.now().add(const Duration(hours: 4)),
        estado: 'Pendiente',
        plataforma: 'App',
        empleado: 'Sofía Ruiz',
        servicios: 'Cena familiar, menú infantil, 4 personas',
      ),
    ]);
  }

  /// Ordena las reservas según la columna seleccionada
  void _sort<T>(
    Comparable<T> Function(Reserva r) getField,
    int columnIndex,
    bool ascending,
  ) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;

      // Ordenar la lista principal
      _reservas.sort((a, b) {
        final aValue = getField(a);
        final bValue = getField(b);
        return ascending
            ? Comparable.compare(aValue, bValue)
            : Comparable.compare(bValue, aValue);
      });

      // Ordenar la lista filtrada
      _filteredReservas.sort((a, b) {
        final aValue = getField(a);
        final bValue = getField(b);
        return ascending
            ? Comparable.compare(aValue, bValue)
            : Comparable.compare(bValue, aValue);
      });
    });
  }

  /// Formatea la fecha en un formato legible
  String _formatearFecha(DateTime fecha) {
    final meses = [
      'Enero',
      'Febrero',
      'Marzo',
      'Abril',
      'Mayo',
      'Junio',
      'Julio',
      'Agosto',
      'Septiembre',
      'Octubre',
      'Noviembre',
      'Diciembre',
    ];
    return '${fecha.day} de ${meses[fecha.month - 1]} de ${fecha.year}';
  }

  /// Filtra las reservas según el texto de búsqueda
  void _filterReservas(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredReservas = List.from(_reservas);
      } else {
        _filteredReservas =
            _reservas.where((reserva) {
              return reserva.cliente.toLowerCase().contains(
                    query.toLowerCase(),
                  ) ||
                  reserva.estado.toLowerCase().contains(query.toLowerCase()) ||
                  reserva.plataforma.toLowerCase().contains(
                    query.toLowerCase(),
                  ) ||
                  reserva.empleado.toLowerCase().contains(
                    query.toLowerCase(),
                  ) ||
                  reserva.servicios.toLowerCase().contains(
                    query.toLowerCase(),
                  ) ||
                  _formatearFecha(
                    reserva.fecha,
                  ).toLowerCase().contains(query.toLowerCase());
            }).toList();
      }

      // Mantener el ordenamiento actual después de filtrar
      if (_sortColumnIndex != null) {
        final getField = _getSortField(_sortColumnIndex!);
        if (getField != null) {
          _filteredReservas.sort((a, b) {
            final aValue = getField(a);
            final bValue = getField(b);
            return _sortAscending
                ? Comparable.compare(aValue, bValue)
                : Comparable.compare(bValue, aValue);
          });
        }
      }
    });
  }

  /// Obtiene la función de ordenamiento para una columna específica
  Comparable<dynamic> Function(Reserva)? _getSortField(int columnIndex) {
    switch (columnIndex) {
      case 0:
        return (r) => r.fecha;
      case 1:
        return (r) => r.estado;
      case 2:
        return (r) => r.plataforma;
      case 3:
        return (r) => r.empleado;
      case 4:
        return (r) => r.cliente;
      case 5:
        return (r) => r.servicios;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColores.fondo,
      appBar: AppBar(
        title: Text('Reservas', style: StylesTextos.titulo),
        backgroundColor: AppColores.primaria,
        actions: [
          // Campo de búsqueda
          Container(
            width: 200,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Buscar...',
                hintStyle: const TextStyle(color: Colors.white70),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.white70),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.white),
                ),
              ),
              onChanged: _filterReservas,
            ),
          ),
          // Botón de ajustes para la visibilidad de columnas
          PopupMenuButton<String>(
            icon: const Icon(Icons.settings, color: Colors.white),
            onSelected: (String column) {
              setState(() {
                _columnVisibility[column] = !_columnVisibility[column]!;
              });
            },
            itemBuilder:
                (BuildContext context) => [
                  PopupMenuItem<String>(
                    value: 'fecha',
                    child: Row(
                      children: [
                        Icon(
                          _columnVisibility['fecha']!
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColores.primaria,
                        ),
                        const SizedBox(width: 8),
                        const Text('Fecha'),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'estado',
                    child: Row(
                      children: [
                        Icon(
                          _columnVisibility['estado']!
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColores.primaria,
                        ),
                        const SizedBox(width: 8),
                        const Text('Estado'),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'plataforma',
                    child: Row(
                      children: [
                        Icon(
                          _columnVisibility['plataforma']!
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColores.primaria,
                        ),
                        const SizedBox(width: 8),
                        const Text('Plataforma'),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'empleado',
                    child: Row(
                      children: [
                        Icon(
                          _columnVisibility['empleado']!
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColores.primaria,
                        ),
                        const SizedBox(width: 8),
                        const Text('Empleado'),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'cliente',
                    child: Row(
                      children: [
                        Icon(
                          _columnVisibility['cliente']!
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColores.primaria,
                        ),
                        const SizedBox(width: 8),
                        const Text('Cliente'),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'servicios',
                    child: Row(
                      children: [
                        Icon(
                          _columnVisibility['servicios']!
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColores.primaria,
                        ),
                        const SizedBox(width: 8),
                        const Text('Servicios'),
                      ],
                    ),
                  ),
                ],
          ),
          // Botón para eliminar las reservas seleccionadas
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
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 800),
            child: DataTable2(
              minWidth: 800,
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
              showCheckboxColumn: false,
              columns:
                  _columnas.map((columna) {
                    return DataColumn2(
                      label: columna.label,
                      size: columna.size,
                    );
                  }).toList(),
              rows:
                  _filteredReservas.map((reserva) {
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
                        if (_columnVisibility['fecha']!)
                          DataCell(
                            Tooltip(
                              message: _formatearFecha(reserva.fecha),
                              child: Text(
                                _formatearFecha(reserva.fecha),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ),
                        if (_columnVisibility['estado']!)
                          DataCell(
                            Text(
                              reserva.estado,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        if (_columnVisibility['plataforma']!)
                          DataCell(
                            Text(
                              reserva.plataforma,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        if (_columnVisibility['empleado']!)
                          DataCell(
                            Text(
                              reserva.empleado,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        if (_columnVisibility['cliente']!)
                          DataCell(
                            Tooltip(
                              message: reserva.cliente,
                              child: Text(
                                reserva.cliente,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ),
                        if (_columnVisibility['servicios']!)
                          DataCell(
                            Text(
                              reserva.servicios,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                      ],
                    );
                  }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
