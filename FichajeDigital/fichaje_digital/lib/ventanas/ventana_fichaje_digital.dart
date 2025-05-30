import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class FichajeDigitalWidget extends StatefulWidget {
  const FichajeDigitalWidget({super.key});

  @override
  State<FichajeDigitalWidget> createState() => _FichajeDigitalWidgetState();
}

class _FichajeDigitalWidgetState extends State<FichajeDigitalWidget> {
  DateTime? _entrada;
  DateTime? _salida;
  Duration _duracion = Duration.zero;
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
    } catch (e) {
      print('Error obteniendo IP: $e');
    }
  }

  Future<void> _obtenerGPS() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever || permission == LocationPermission.denied) return;
    }

    try {
      final pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _latitud = pos.latitude;
        _longitud = pos.longitude;
        _ubicacionGPS = 'Lat: ${pos.latitude}, Lng: ${pos.longitude}';
      });
    } catch (e) {
      print('Error GPS: $e');
    }
  }

  void _start() {
    setState(() {
      _entrada = DateTime.now();
      _duracion = Duration.zero;
    });
    _updateTimer();
  }

  void _stop() {
    setState(() {
      _salida = DateTime.now();
    });

    print('Entrada: $_entrada');
    print('Salida: $_salida');
    print('IP: $_ip');
    print('Ubicación IP: $_localizacionIP');
    print('GPS: $_ubicacionGPS');
    print('Sistema: Web');
  }

  void _updateTimer() {
    Future.doWhile(() async {
      if (_entrada != null && _salida == null) {
        await Future.delayed(const Duration(seconds: 1));
        setState(() {
          _duracion = DateTime.now().difference(_entrada!);
        });
        return true;
      }
      return false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final trabajando = _entrada != null && _salida == null;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          trabajando
              ? 'Tiempo trabajado: ${_duracion.inHours.toString().padLeft(2, '0')}:${(_duracion.inMinutes % 60).toString().padLeft(2, '0')}:${(_duracion.inSeconds % 60).toString().padLeft(2, '0')}'
              : 'No estás trabajando actualmente.',
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: trabajando ? _stop : _start,
          style: ElevatedButton.styleFrom(
            backgroundColor: trabajando ? Colors.red : Colors.green,
          ),
          child: Text(trabajando ? 'STOP' : 'START'),
        ),
      ],
    );
  }
}
