import 'package:flutter/material.dart';
import 'services/ip_api_service.dart';
import 'services/currency_service.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IP y Divisa',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const LocationScreen(),
    );
  }
}

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final IpApiService _ipApiService = IpApiService();
  final CurrencyService _currencyService = CurrencyService();
  final TextEditingController _ipController = TextEditingController();
  final TextEditingController _priceController = TextEditingController(text: '100.00');
  Future<Map<String, dynamic>>? _locationData;
  String _currentCurrency = 'EUR';
  bool _isLoading = false;
  String? _conversionError;
  static const double _basePrice = 100.00;

  @override
  void initState() {
    super.initState();
    _loadLocationData();
  }

  @override
  void dispose() {
    _ipController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _loadLocationData() async {
    setState(() {
      _isLoading = true;
      _conversionError = null;
    });

    try {
      final data = await _ipApiService.getLocation();
      setState(() {
        _locationData = Future.value(data);
        _ipController.text = data['query'] ?? '';
        _updateCurrency(data['countryCode']);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar la ubicación: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _searchIpAddress() async {
    if (_ipController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, ingresa una dirección IP')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _conversionError = null;
    });

    try {
      final data = await _ipApiService.getIpInfoForAddress(_ipController.text);
      setState(() {
        _locationData = Future.value(data);
        _updateCurrency(data['countryCode']);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al buscar la IP: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updateCurrency(String? countryCode) async {
    if (countryCode == null) return;

    final currency = _currencyService.getCurrencyCode(countryCode);
    if (currency == _currentCurrency) return;

    setState(() {
      _currentCurrency = currency;
      _conversionError = null;
    });

    try {
      final converted = await _currencyService.convertFromEUR(currency, _basePrice);
      setState(() {
        _priceController.text = converted.toStringAsFixed(2);
      });
    } catch (e) {
      setState(() {
        _conversionError = e.toString();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al convertir la moneda: $e')),
      );
    }
  }

  Widget _buildInfoRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value?.toString() ?? 'No disponible'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IP y Divisa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ipController,
                    decoration: const InputDecoration(
                      labelText: 'Dirección IP',
                      hintText: 'Ejemplo: 8.8.8.8',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onSubmitted: (_) => _searchIpAddress(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _searchIpAddress,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  ),
                  child: const Text('Buscar'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(
                labelText: 'Precio',
                border: const OutlineInputBorder(),
                suffixText: _currentCurrency,
                filled: true,
                fillColor: Colors.grey[200],
                enabled: false,
              ),
              keyboardType: TextInputType.number,
              readOnly: true,
            ),
            const SizedBox(height: 16),
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else
              FutureBuilder<Map<String, dynamic>>(
                future: _locationData,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(color: Colors.red),
                    );
                  }

                  if (snapshot.hasData) {
                    final data = snapshot.data!;
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoRow('IP', data['query']),
                            _buildInfoRow('País', data['country']),
                            _buildInfoRow('Código País', data['countryCode']),
                            _buildInfoRow('Región', data['regionName']),
                            _buildInfoRow('Ciudad', data['city']),
                            _buildInfoRow('Código Postal', data['zip']),
                            _buildInfoRow('Latitud', data['lat']),
                            _buildInfoRow('Longitud', data['lon']),
                            _buildInfoRow('Zona Horaria', data['timezone']),
                            _buildInfoRow('ISP', data['isp']),
                            _buildInfoRow('Organización', data['org']),
                            _buildInfoRow('AS', data['as']),
                            if (_conversionError != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  'Error de conversión: $_conversionError',
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  }

                  return const Text('No se encontraron datos');
                },
              ),
          ],
        ),
      ),
    );
  }
}
