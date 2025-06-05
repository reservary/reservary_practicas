import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:js' as js;
import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:math';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../models/gimnasio.dart';
import '../providers/gym_provider.dart';
import '../main.dart';

class Config {
  static String get proxyUrl {
    if (kIsWeb) {
      return 'http://localhost:62474';
    } else {
      try {
        final port = File('proxy_port.txt').readAsStringSync().trim();
        return 'http://localhost:$port';
      } catch (e) {
        print('Error leyendo el puerto del proxy: $e');
        return 'http://localhost:62474';
      }
    }
  }
}

class MapViewScreen extends StatefulWidget {
  const MapViewScreen({super.key});

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  GoogleMapController? _mapController;
  LatLng? _userLocation;
  final Set<Marker> _markers = {};
  List<Gimnasio> gimnasios = [];
  List<Gimnasio> gimnasiosFiltrados = [];
  bool _isSearching = false;
  Timer? _debounceTimer;
  bool _isUserMovingMap = false;
  String? _errorMessage;
  final TextEditingController _searchController = TextEditingController();
  bool _isDialogOpen = false;

  final Location location = Location();

  final String googleApiKey = 'AIzaSyAZW-Rn4h5BGgUZzFZXbYKTY6F1T9I8vWI';

  @override
  void initState() {
    super.initState();
    _initLocationAndSearch();
  }

  Future<void> _initLocationAndSearch() async {
    try {
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          setState(() {
            _errorMessage = 'El servicio de ubicación está desactivado';
          });
          return;
        }
      }

      PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          setState(() {
            _errorMessage =
                'Se necesitan permisos de ubicación para mostrar gimnasios cercanos';
          });
          return;
        }
      }

      setState(() {
        _isSearching = true;
        _errorMessage = null;
      });

      final locData = await location.getLocation();
      _userLocation = LatLng(locData.latitude!, locData.longitude!);

      _markers.add(Marker(
        markerId: const MarkerId('user_marker'),
        position: _userLocation!,
        infoWindow: const InfoWindow(title: 'Tu ubicación'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      ));

      setState(() {});

      await _buscarGimnasiosCerca();
    } catch (e) {
      setState(() {
        _errorMessage = 'Error al obtener la ubicación: $e';
      });
    } finally {
      setState(() {
        _isSearching = false;
      });
    }
  }

  void _ordenarGimnasiosPorDistancia() {
    if (_userLocation == null) return;

    gimnasios.sort((a, b) {
      double distanciaA = a.calcularDistancia(_userLocation!);
      double distanciaB = b.calcularDistancia(_userLocation!);
      return distanciaA.compareTo(distanciaB);
    });
  }

  Future<void> _buscarGimnasiosCerca() async {
    if (_userLocation == null) return;

    setState(() {
      _isSearching = true;
      _errorMessage = null;
      // Reiniciamos la búsqueda al cambiar de ubicación
      _searchController.clear();
      gimnasiosFiltrados = [];
    });

    try {
      final url = Uri.parse('${Config.proxyUrl}/places'
          '?lat=${_userLocation!.latitude}'
          '&lng=${_userLocation!.longitude}');

      final response = await http.get(url).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('La conexión tardó demasiado');
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK') {
          gimnasios.clear();
          _markers.removeWhere((m) => m.markerId.value.startsWith('gym_'));

          for (var i = 0; i < data['results'].length; i++) {
            final result = data['results'][i];
            final gym = Gimnasio.fromJson(result);
            gimnasios.add(gym);

            _markers.add(Marker(
              markerId: MarkerId('gym_$i'),
              position: gym.latLng,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueRed),
              onTap: () {
                _mapController?.animateCamera(
                  CameraUpdate.newLatLngZoom(gym.latLng, 15),
                );
                _mostrarDetallesGimnasio(gym);
              },
            ));

            if (gym.photoReference != null) {
              final photoUrl =
                  '${Config.proxyUrl}/photo?photoreference=${gym.photoReference}';
              _loadCustomMarker(photoUrl, i);
            }
          }

          _ordenarGimnasiosPorDistancia();
          gimnasiosFiltrados = List.from(gimnasios);
        } else {
          setState(() {
            _errorMessage = "Error buscando gimnasios: ${data['status']}";
          });
        }
      } else {
        setState(() {
          _errorMessage = "Error en la petición HTTP: ${response.statusCode}";
        });
      }
    } on TimeoutException {
      setState(() {
        _errorMessage =
            'La conexión tardó demasiado. Por favor, verifica tu conexión a internet.';
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error al buscar gimnasios: $e';
      });
    } finally {
      setState(() {
        _isSearching = false;
      });
    }
  }

  Future<void> _mostrarDetallesGimnasio(Gimnasio gimnasio) async {
    if (_isDialogOpen) return; // Evitar abrir múltiples diálogos

    // Obtener detalles completos del lugar
    try {
      final url = Uri.parse('${Config.proxyUrl}/place-details?place_id=${gimnasio.placeId}');
      final response = await http.get(url).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('La conexión tardó demasiado');
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK') {
          final result = data['result'];
          gimnasio = Gimnasio.fromJson(result);
        }
      }
    } catch (e) {
      print('Error obteniendo detalles del lugar: $e');
    }

    if (!context.mounted) return;

    setState(() {
      _isDialogOpen = true;
    });

    // Función para verificar si un enlace es un sitio web oficial
    bool esSitioWebOficial(String url) {
      final urlLower = url.toLowerCase();
      // Lista de dominios que queremos excluir
      final dominiosExcluidos = [
        'whatsapp.com',
        'wa.me',
        'facebook.com',
        'instagram.com',
        'twitter.com',
        'linkedin.com',
        'youtube.com',
        'tiktok.com',
        'pinterest.com',
        'snapchat.com',
        'telegram.me',
        't.me',
        'messenger.com',
        'fb.com',
        'fb.me',
        'goo.gl',
        'bit.ly',
        'tinyurl.com',
        'maps.app.goo.gl',
        'maps.google.com',
      ];

      // Verificar si la URL contiene alguno de los dominios excluidos
      for (var dominio in dominiosExcluidos) {
        if (urlLower.contains(dominio)) {
          return false;
        }
      }

      // Verificar si es una URL válida que comienza con http/https
      return urlLower.startsWith('http://') || urlLower.startsWith('https://');
    }

    // Función para mostrar la imagen en pantalla completa
    void _mostrarImagenCompleta() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Stack(
              children: [
                InteractiveViewer(
                  minScale: 0.5,
                  maxScale: 4.0,
                  child: Image.network(
                    '${Config.proxyUrl}/photo?photoreference=${gimnasio.photoReference}',
                    fit: BoxFit.contain,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                          color: Colors.white,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      print('Error loading image: $error');
                      return const Center(
                        child: Icon(Icons.error_outline,
                            color: Colors.red, size: 50),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    icon:
                        const Icon(Icons.close, color: Colors.white, size: 30),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  gimnasio.nombre,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () async {
                  Navigator.pop(context);
                  // Esperar a que el diálogo se cierre completamente
                  await Future.delayed(const Duration(milliseconds: 100));
                  if (mounted) {
                    setState(() {
                      _isDialogOpen = false;
                    });
                  }
                },
                color: Colors.grey,
              ),
            ],
          ),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          size: 16, color: Colors.grey),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          gimnasio.direccion,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Sección de Calificación
                  const Text(
                    'Calificación',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 70, 206, 255),
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (gimnasio.rating != null) ...[
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 20),
                        Text(' ${gimnasio.rating!.toStringAsFixed(1)}'),
                        if (gimnasio.totalRatings != null)
                          Text(' (${gimnasio.totalRatings} reseñas)'),
                      ],
                    ),
                  ] else ...[
                    const Text(
                      'No hay calificaciones disponibles',
                      style: TextStyle(
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  // Sección de Estado
                  const Text(
                    'Estado',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 70, 206, 255),
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (gimnasio.isOpen != null) ...[
                    Text(
                      gimnasio.isOpen! ? 'Abierto' : 'Cerrado',
                      style: TextStyle(
                        color: gimnasio.isOpen! ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ] else ...[
                    const Text(
                      'Estado actual no disponible',
                      style: TextStyle(
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  // Sección de Horarios
                  const Text(
                    'Horarios',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 70, 206, 255),
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (gimnasio.horarios != null &&
                      gimnasio.horarios!.isNotEmpty) ...[
                    ...gimnasio.horarios!.map((horario) => Padding(
                          padding: const EdgeInsets.only(left: 8, top: 4),
                          child: Row(
                            children: [
                              const Icon(Icons.access_time,
                                  size: 16, color: Colors.grey),
                              const SizedBox(width: 8),
                              Text(horario),
                            ],
                          ),
                        )),
                  ] else ...[
                    const Text(
                      'Horarios no disponibles',
                      style: TextStyle(
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  // Sección de Contacto
                  const Text(
                    'Información de Contacto',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 70, 206, 255),
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (gimnasio.numeroTelefono != null) ...[
                    Row(
                      children: [
                        const Icon(Icons.phone, size: 16, color: Colors.grey),
                        const SizedBox(width: 8),
                        Text(gimnasio.numeroTelefono!),
                      ],
                    ),
                  ] else ...[
                    const Text(
                      'Número de teléfono no disponible',
                      style: TextStyle(
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                  const SizedBox(height: 8),
                  if (gimnasio.sitioWeb != null &&
                      esSitioWebOficial(gimnasio.sitioWeb!)) ...[
                    InkWell(
                      onTap: () {
                        js.context
                            .callMethod('open', [gimnasio.sitioWeb, '_blank']);
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.language,
                              size: 16, color: Colors.blue),
                          const SizedBox(width: 8),
                          Text(
                            'Sitio web',
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    const Text(
                      'Sitio web no disponible',
                      style: TextStyle(
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  // Sección de Imágenes
                  if (gimnasio.photoReference != null) ...[
                    const Text(
                      'Imágenes',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 70, 206, 255),
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: _mostrarImagenCompleta,
                      child: Stack(
                        children: [
                          Container(
                            height: 200,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                '${Config.proxyUrl}/photo?photoreference=${gimnasio.photoReference}',
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  print('Error loading image: $error');
                                  return const Center(
                                    child: Icon(Icons.error_outline,
                                        color: Colors.red),
                                  );
                                },
                              ),
                            ),
                          ),
                          Positioned(
                            right: 8,
                            bottom: 8,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Icon(
                                Icons.fullscreen,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    const Text(
                      'Imágenes',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 70, 206, 255),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'No hay imágenes disponibles',
                      style: TextStyle(
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context.read<GymProvider>().selectGym(gimnasio);
                          Navigator.pop(context);
                          if (context.mounted) {
                            final mainScreen = context.findAncestorStateOfType<MainScreenState>();
                            if (mainScreen != null) {
                              mainScreen.onItemTapped(1);
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 70, 206, 255),
                          foregroundColor: Colors.white,
                          alignment: Alignment.center,
                          minimumSize: const Size(200, 45),
                        ),
                        child: const Text('Voy a este gimnasio'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );

    // Asegurarnos de que el estado se actualice después de cerrar el diálogo
    if (mounted) {
      setState(() {
        _isDialogOpen = false;
      });
    }
  }

  Future<Uint8List> _getGymPhoto(String photoReference) async {
    try {
      final response = await http.get(
        Uri.parse('${Config.proxyUrl}/photo?photoreference=$photoReference'),
      );
      if (response.statusCode == 200) {
        return response.bodyBytes;
      }
      throw Exception('Error al cargar la foto: ${response.statusCode}');
    } catch (e) {
      print('Error en _getGymPhoto: $e');
      throw Exception('Error al cargar la foto: $e');
    }
  }

  Future<void> _loadCustomMarker(String photoUrl, int index) async {
    try {
      final response = await http.get(Uri.parse(photoUrl));
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final markerIcon = await _createBubbleMarker(bytes);

        setState(() {
          // Actualizamos el marcador con la foto del gimnasio
          _markers.removeWhere((m) => m.markerId.value == 'gym_$index');
          _markers.add(Marker(
            markerId: MarkerId('gym_$index'),
            position: LatLng(gimnasios[index].latLng.latitude,
                gimnasios[index].latLng.longitude),
            icon: markerIcon,
            onTap: () {
              _mostrarDetallesGimnasio(gimnasios[index]);
            },
          ));
        });
      }
    } catch (e) {
      print("Error cargando foto: $e");
    }
  }

  Future<BitmapDescriptor> _createBubbleMarker(Uint8List imageBytes) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final size = const Size(80, 80);

    // Creamos un marcador circular con borde azul
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      paint,
    );

    final borderPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2 - 1,
      borderPaint,
    );

    // Añadimos la foto del gimnasio al marcador
    final codec = await ui.instantiateImageCodec(imageBytes);
    final frameInfo = await codec.getNextFrame();
    final image = frameInfo.image;

    final imageSize = size.width - 8;
    final imageRect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: imageSize / 2,
    );

    final clipPath = Path()
      ..addOval(Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2 - 4,
      ));
    canvas.clipPath(clipPath);

    canvas.drawImageRect(
      image,
      Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      imageRect,
      Paint()..filterQuality = FilterQuality.high,
    );

    final picture = recorder.endRecording();
    final img = await picture.toImage(size.width.toInt(), size.height.toInt());
    final data = await img.toByteData(format: ui.ImageByteFormat.png);

    return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
  }

  void _onCameraMove(CameraPosition position) {
    if (!_isUserMovingMap) {
      setState(() {
        _isUserMovingMap = true;
      });
    }
  }

  void _onCameraIdle() {
    setState(() {
      _isUserMovingMap = false;
    });
  }

  void _onMapTap(LatLng location) {
    if (!_isDialogOpen) {
      setState(() {
        _userLocation = location;
        _markers.removeWhere((m) => m.markerId.value == 'user_marker');
        _markers.add(Marker(
          markerId: const MarkerId('user_marker'),
          position: _userLocation!,
          infoWindow: const InfoWindow(title: 'Ubicación seleccionada'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        ));
      });

      // Buscar gimnasios cerca de la nueva ubicación
      _buscarGimnasiosCerca();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _centrarEnGimnasio(Gimnasio gimnasio) {
    _isUserMovingMap = true;
    _mapController
        ?.animateCamera(
      CameraUpdate.newLatLngZoom(
        gimnasio.latLng,
        15,
      ),
    )
        .then((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        _isUserMovingMap = false;
      });
    });
    _mostrarDetallesGimnasio(gimnasio);
  }

  Future<void> _irAUbicacionActual() async {
    _isUserMovingMap = true;
    final locData = await location.getLocation();
    final newLocation = LatLng(locData.latitude!, locData.longitude!);

    setState(() {
      _userLocation = newLocation;
      _markers.removeWhere((m) => m.markerId.value == 'user_marker');
      _markers.add(Marker(
        markerId: const MarkerId('user_marker'),
        position: _userLocation!,
        infoWindow: const InfoWindow(title: 'Tu ubicación'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      ));
    });

    await _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(_userLocation!, 15),
    );

    await _buscarGimnasiosCerca();

    Future.delayed(const Duration(milliseconds: 500), () {
      _isUserMovingMap = false;
    });
  }

  void _filtrarGimnasios(String query) {
    setState(() {
      if (query.isEmpty) {
        gimnasiosFiltrados = List.from(gimnasios);
      } else {
        gimnasiosFiltrados = gimnasios
            .where(
                (gym) => gym.nombre.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_userLocation == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 70, 206, 255),
        foregroundColor: Colors.white,
        title: const Text("Gym Maps"),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16, bottom: 16, left: 16, right: 16),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Buscar gimnasio...',
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: _searchController.text.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () {
                                      _searchController.clear();
                                      _filtrarGimnasios('');
                                    },
                                  )
                                : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                          ),
                          onChanged: _filtrarGimnasios,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: Stack(
                          children: [
                            IgnorePointer(
                              ignoring: _isDialogOpen,
                              child: GoogleMap(
                                onMapCreated: (controller) =>
                                    _mapController = controller,
                                myLocationEnabled: true,
                                markers: _markers,
                                initialCameraPosition: CameraPosition(
                                  target: _userLocation!,
                                  zoom: 15,
                                ),
                                onCameraMove: _onCameraMove,
                                onCameraIdle: _onCameraIdle,
                                onTap: _onMapTap,
                              ),
                            ),
                            if (_isUserMovingMap)
                              Positioned(
                                left: 16,
                                bottom: 16,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    'Para cambiar tu ubicación en el mapa, pulsa en el lugar que desees',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            if (!_isDialogOpen)
                              Positioned(
                                top: 16,
                                right: 16,
                                child: FloatingActionButton(
                                  onPressed: _irAUbicacionActual,
                                  child: const Icon(Icons.my_location),
                                  backgroundColor: Colors.blue,
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Lista de Gimnasios",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 16),
                            // Lista de gimnasios filtrados
                            ...gimnasiosFiltrados.map((gimnasio) => Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: InkWell(
                                    onTap: () => _centrarEnGimnasio(gimnasio),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.fitness_center,
                                            color: Colors.blue),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                gimnasio.nombre,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                gimnasio.direccion,
                                                style: const TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Icon(Icons.arrow_forward_ios,
                                            size: 16, color: Colors.grey),
                                      ],
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
