import 'package:flutter/material.dart';
import 'services/mongo_service.dart';
import 'example_usage.dart';

class QueryInterface extends StatefulWidget {
  const QueryInterface({super.key});

  @override
  State<QueryInterface> createState() => _QueryInterfaceState();
}

class _QueryInterfaceState extends State<QueryInterface> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _startDate;
  DateTime? _endDate;
  final _companyIdController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  bool _isLoading = false;
  String _searchType = 'date'; // 'date' or 'company'

  @override
  void initState() {
    super.initState();
    _initializeMongo();
  }

  Future<void> _initializeMongo() async {
    try {
      await MongoService.connect();
    } catch (e) {
      _showError('Error al conectar con MongoDB: $e');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  Future<void> _searchByDate() async {
    if (_startDate == null || _endDate == null) {
      _showError('Por favor selecciona ambas fechas');
      return;
    }

    setState(() {
      _isLoading = true;
      _searchResults = [];
    });

    try {
      final results = await MongoService.queryData({
        'timestamp': {
          '\$gte': _startDate!.millisecondsSinceEpoch,
          '\$lt': _endDate!.millisecondsSinceEpoch,
        }
      });

      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      _showError('Error al buscar reservas: $e');
    }
  }

  Future<void> _searchByCompany() async {
    if (_companyIdController.text.isEmpty) {
      _showError('Por favor ingresa un ID de compañía');
      return;
    }

    setState(() {
      _isLoading = true;
      _searchResults = [];
    });

    try {
      final results = await MongoService.queryData({
        'companyId': _companyIdController.text,
      });

      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      _showError('Error al buscar reservas: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final firstDate = DateTime(2020);
    final lastDate = DateTime(now.year + 1, 12, 31);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Búsqueda de Reservas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Selector de tipo de búsqueda
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(
                  value: 'date',
                  label: Text('Por Fecha'),
                  icon: Icon(Icons.calendar_today),
                ),
                ButtonSegment(
                  value: 'company',
                  label: Text('Por Compañía'),
                  icon: Icon(Icons.business),
                ),
              ],
              selected: {_searchType},
              onSelectionChanged: (Set<String> newSelection) {
                setState(() {
                  _searchType = newSelection.first;
                });
              },
            ),
            const SizedBox(height: 20),

            // Formulario de búsqueda
            Form(
              key: _formKey,
              child: Column(
                children: [
                  if (_searchType == 'date') ...[
                    // Selector de fechas
                    Row(
                      children: [
                        Expanded(
                          child: TextButton.icon(
                            onPressed: () async {
                              final date = await showDatePicker(
                                context: context,
                                initialDate: _startDate ?? now,
                                firstDate: firstDate,
                                lastDate: lastDate,
                              );
                              if (date != null) {
                                setState(() => _startDate = date);
                              }
                            },
                            icon: const Icon(Icons.calendar_today),
                            label: Text(_startDate == null
                                ? 'Fecha Inicio'
                                : '${_startDate!.day}/${_startDate!.month}/${_startDate!.year}'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextButton.icon(
                            onPressed: () async {
                              final date = await showDatePicker(
                                context: context,
                                initialDate: _endDate ?? now,
                                firstDate: firstDate,
                                lastDate: lastDate,
                              );
                              if (date != null) {
                                setState(() => _endDate = date);
                              }
                            },
                            icon: const Icon(Icons.calendar_today),
                            label: Text(_endDate == null
                                ? 'Fecha Fin'
                                : '${_endDate!.day}/${_endDate!.month}/${_endDate!.year}'),
                          ),
                        ),
                      ],
                    ),
                  ] else ...[
                    // Campo de ID de compañía
                    TextFormField(
                      controller: _companyIdController,
                      decoration: const InputDecoration(
                        labelText: 'ID de Compañía',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : _searchType == 'date'
                            ? _searchByDate
                            : _searchByCompany,
                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : const Text('Buscar'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Resultados
            Expanded(
              child: _searchResults.isEmpty
                  ? const Center(
                      child: Text('No hay resultados para mostrar'),
                    )
                  : ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final reserva = _searchResults[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            title: Text('ID: ${reserva['bookingId']}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Estado: ${reserva['status']}'),
                                Text(
                                    'Fecha: ${ExampleUsage.formatTimestamp(reserva['timestamp'])}'),
                                if (reserva['userData'] != null)
                                  ...reserva['userData'].map<Widget>((userData) {
                                    return Text(
                                        '${userData['name']}: ${userData['value']}');
                                  }).toList(),
                              ],
                            ),
                            isThreeLine: true,
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _companyIdController.dispose();
    MongoService.disconnect();
    super.dispose();
  }
} 