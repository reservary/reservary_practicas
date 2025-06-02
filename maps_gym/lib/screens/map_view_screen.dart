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
            _errorMessage = 'Se necesitan permisos de ubicación para mostrar gimnasios cercanos';
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
      final url = Uri.parse(
        '${Config.proxyUrl}/places'
        '?lat=${_userLocation!.latitude}'
        '&lng=${_userLocation!.longitude}'
      );

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
              infoWindow: InfoWindow(
                title: gym.nombre,
                snippet: gym.direccion,
              ),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
              onTap: () {
                _mapController?.animateCamera(
                  CameraUpdate.newLatLngZoom(gym.latLng, 15),
                );
                _mostrarDetallesGimnasio(gym);
              },
            ));

            if (gym.photoReference != null) {
              final photoUrl = '${Config.proxyUrl}/photo?photoreference=${gym.photoReference}';
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
        _errorMessage = 'La conexión tardó demasiado. Por favor, verifica tu conexión a internet.';
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

  void _mostrarDetallesGimnasio(Gimnasio gimnasio) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(gimnasio.nombre),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(gimnasio.direccion),
                  if (gimnasio.rating != null) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 20),
                        Text(' ${gimnasio.rating!.toStringAsFixed(1)}'),
                        if (gimnasio.totalRatings != null)
                          Text(' (${gimnasio.totalRatings} reseñas)'),
                      ],
                    ),
                  ],
                  if (gimnasio.isOpen != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      gimnasio.isOpen! ? 'Abierto' : 'Cerrado',
                      style: TextStyle(
                        color: gimnasio.isOpen! ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                  if (gimnasio.numeroTelefono != null) ...[
                    const SizedBox(height: 8),
                    Text('Teléfono: ${gimnasio.numeroTelefono}'),
                  ],
                  if (gimnasio.sitioWeb != null) ...[
                    const SizedBox(height: 8),
                    Text('Sitio web: ${gimnasio.sitioWeb}'),
                  ],
                  const SizedBox(height: 16),
                  if (gimnasio.photoReference != null)
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
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            print('Error loading image: $error');
                            return const Center(
                              child: Icon(Icons.error_outline, color: Colors.red),
                            );
                          },
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cerrar'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          context.read<GymProvider>().selectGym(gimnasio);
                          Navigator.pop(context);
                          // Cambiar a la pestaña de Mi Gimnasio
                          if (context.mounted) {
                            final mainScreen = context.findAncestorStateOfType<MainScreenState>();
                            if (mainScreen != null) {
                              mainScreen.onItemTapped(1);
                            }
                          }
                        },
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
            position: LatLng(gimnasios[index].latLng.latitude, gimnasios[index].latLng.longitude),
            infoWindow: InfoWindow(
              title: gimnasios[index].nombre,
              snippet: gimnasios[index].direccion,
            ),
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
    if (_isSearching) return;
    
    // Esperamos a que el usuario termine de mover el mapa antes de buscar
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      if (!_isUserMovingMap) {
        _isSearching = true;
        _userLocation = position.target;
        
        setState(() {
          _markers.removeWhere((m) => m.markerId.value == 'user_marker');
          _markers.add(Marker(
            markerId: const MarkerId('user_marker'),
            position: _userLocation!,
            infoWindow: const InfoWindow(title: 'Ubicación seleccionada'),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          ));
        });

        _buscarGimnasiosCerca().then((_) {
          _isSearching = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _centrarEnGimnasio(Gimnasio gimnasio) {
    _isUserMovingMap = true;
    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(
        gimnasio.latLng,
        15,
      ),
    ).then((_) {
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
            .where((gym) => gym.nombre.toLowerCase().contains(query.toLowerCase()))
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
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: Stack(
                          children: [
                            GoogleMap(
                              onMapCreated: (controller) => _mapController = controller,
                              myLocationEnabled: true,
                              markers: _markers,
                              initialCameraPosition: CameraPosition(
                                target: _userLocation!,
                                zoom: 15,
                              ),
                              onCameraMove: _onCameraMove,
                              onCameraIdle: () {
                                _isUserMovingMap = false;
                              },
                            ),
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
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 16),
                            // Campo de búsqueda
                            TextField(
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
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              ),
                              onChanged: _filtrarGimnasios,
                            ),
                            const SizedBox(height: 16),
                            // Lista de gimnasios filtrados
                            ...gimnasiosFiltrados.map((gimnasio) => Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: InkWell(
                                    onTap: () => _centrarEnGimnasio(gimnasio),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.fitness_center, color: Colors.blue),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                gimnasio.nombre,
                                                style: const TextStyle(fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                gimnasio.direccion,
                                                style: const TextStyle(color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
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