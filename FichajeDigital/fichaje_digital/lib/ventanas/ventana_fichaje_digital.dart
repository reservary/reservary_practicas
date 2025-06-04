import 'package:fichaje_digital/modelo/asistencia.dart';
import 'package:fichaje_digital/widgets/tabla_resumen_horas.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'dart:convert';

class FichajeDigitalWidget extends StatefulWidget {
  const FichajeDigitalWidget({super.key});

  @override
  State<FichajeDigitalWidget> createState() => _FichajeDigitalWidgetState();
}

class _FichajeDigitalWidgetState extends State<FichajeDigitalWidget> {
  bool trabajando = false;
  DateTime? inicioSesion;
  Duration tiempoSesion = Duration.zero;
  Timer? _timer;

  List<Asistencia> registros = [];

  String _ip = 'Desconocida';
  String _localizacionIP = 'Desconocida';
  double? _latitud;
  double? _longitud;
  String? _ubicacionGPS;

  @override
  void initState() {
    super.initState();
    _obtenerIPyUbicacion();
    _obtenerGPS();
  }

  Future<void> _obtenerIPyUbicacion() async {
    try {
      final response = await http.get(Uri.parse('https://ipapi.co/json/'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _ip = data['ip'] ?? 'Desconocida';
          _localizacionIP = '${data['city']}, ${data['country_name']}';
        });
      }
    } catch (_) {}
  }

  Future<void> _obtenerGPS() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) return;
    }

    try {
      final pos = await Geolocator.getCurrentPosition();
      setState(() {
        _latitud = pos.latitude;
        _longitud = pos.longitude;
        _ubicacionGPS = 'Lat: ${pos.latitude}, Lng: ${pos.longitude}';
      });
    } catch (_) {}
  }

  void _registrarAsistencia(String tipo) {
    final nueva = Asistencia(
      fechaRegistro: DateTime.now(),
      tipo: tipo,
      ip: _ip,
      localizacionIP: _localizacionIP,
      latitud: _latitud,
      longitud: _longitud,
      ubicacionGPS: _ubicacionGPS,
      sistema: 'Web',
    );

    setState(() {
      registros.add(nueva);
    });

    print('Registrado: $nueva');
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (inicioSesion != null && trabajando) {
        setState(() {
          tiempoSesion = DateTime.now().difference(inicioSesion!);
        });
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void _toggleFichaje() {
    if (!trabajando) {
      _registrarAsistencia("entrada");
      inicioSesion = DateTime.now();
      _startTimer();
    } else {
      _registrarAsistencia("salida");
      _stopTimer();
      tiempoSesion = Duration.zero;
    }

    setState(() {
      trabajando = !trabajando;
    });
  }

  void _simularTiempoExtra() {
    final ahora = DateTime.now();
    final inicio = ahora.subtract(const Duration(hours: 9));

    final entrada = Asistencia(
      fechaRegistro: inicio,
      tipo: 'entrada',
      ip: _ip,
      localizacionIP: _localizacionIP,
      latitud: _latitud,
      longitud: _longitud,
      ubicacionGPS: _ubicacionGPS,
      sistema: 'Web',
    );

    final salida = Asistencia(
      fechaRegistro: ahora,
      tipo: 'salida',
      ip: _ip,
      localizacionIP: _localizacionIP,
      latitud: _latitud,
      longitud: _longitud,
      ubicacionGPS: _ubicacionGPS,
      sistema: 'Web',
    );

    setState(() {
      registros.add(entrada); // primero entrada
      registros.add(salida);  // luego salida
    });

    print('Simulado: $entrada y $salida');
  }

  String _formatearDuracion(Duration duracion) {
    final h = duracion.inHours.toString().padLeft(2, '0');
    final m = (duracion.inMinutes % 60).toString().padLeft(2, '0');
    final s = (duracion.inSeconds % 60).toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              trabajando
                  ? 'Tiempo actual: ${_formatearDuracion(tiempoSesion)}'
                  : 'No estás fichando',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _toggleFichaje,
              style: ElevatedButton.styleFrom(
                backgroundColor: trabajando ? Colors.red : Colors.green,
              ),
              child: Text(trabajando ? 'STOP' : 'START'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _simularTiempoExtra,
              child: const Text("Simular 9h"),
            ),
            const SizedBox(height: 40),
            const Divider(),
            const Text('Historial de fichajes', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            for (var reg in registros)
              ListTile(
                title: Text('${reg.tipo.toUpperCase()} - ${reg.fechaRegistro}'),
                subtitle: Text('${reg.ip} | ${reg.localizacionIP} | ${reg.ubicacionGPS ?? 'Sin GPS'}'),
              ),
            const SizedBox(height: 40),
            const Divider(),
            const Text('Resumen por día', style: TextStyle(fontSize: 18)),
            TablaResumenHoras(registros: registros),
          ],
        ),
      ),
    );
  }
}
