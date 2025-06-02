import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Representa un gimnasio con toda su información
class Gimnasio {
  final String nombre;
  final String direccion;
  final double lat;
  final double lng;
  final String? photoReference;
  final String? placeId;
  final double? rating;
  final int? totalRatings;
  final bool? isOpen;
  final List<String>? tipos;
  final String? numeroTelefono;
  final String? sitioWeb;

  Gimnasio({
    required this.nombre,
    required this.direccion,
    required this.lat,
    required this.lng,
    this.photoReference,
    this.placeId,
    this.rating,
    this.totalRatings,
    this.isOpen,
    this.tipos,
    this.numeroTelefono,
    this.sitioWeb,
  });

  /// Crea un objeto Gimnasio a partir de los datos de la API de Google Places
  factory Gimnasio.fromJson(Map<String, dynamic> json) {
    return Gimnasio(
      nombre: json['name'] ?? '',
      direccion: json['vicinity'] ?? '',
      lat: json['geometry']['location']['lat']?.toDouble() ?? 0.0,
      lng: json['geometry']['location']['lng']?.toDouble() ?? 0.0,
      photoReference: json['photos']?[0]['photo_reference'],
      placeId: json['place_id'],
      rating: json['rating']?.toDouble(),
      totalRatings: json['user_ratings_total'],
      isOpen: json['opening_hours']?['open_now'],
      tipos: (json['types'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      numeroTelefono: json['formatted_phone_number'],
      sitioWeb: json['website'],
    );
  }

  /// Convierte el objeto Gimnasio a un formato JSON
  Map<String, dynamic> toJson() {
    return {
      'name': nombre,
      'vicinity': direccion,
      'geometry': {
        'location': {
          'lat': lat,
          'lng': lng,
        }
      },
      'photos': photoReference != null ? [
        {'photo_reference': photoReference}
      ] : null,
      'place_id': placeId,
      'rating': rating,
      'user_ratings_total': totalRatings,
      'opening_hours': isOpen != null ? {'open_now': isOpen} : null,
      'types': tipos,
      'formatted_phone_number': numeroTelefono,
      'website': sitioWeb,
    };
  }

  /// Obtiene la ubicación del gimnasio en formato LatLng para Google Maps
  LatLng get latLng => LatLng(lat, lng);

  /// Calcula la distancia en kilómetros entre este gimnasio y otro punto
  double calcularDistancia(LatLng otroPunto) {
    const double radioTierra = 6371; // Radio de la Tierra en kilómetros
    double lat1 = lat * (pi / 180);
    double lat2 = otroPunto.latitude * (pi / 180);
    double deltaLat = (otroPunto.latitude - lat) * (pi / 180);
    double deltaLng = (otroPunto.longitude - lng) * (pi / 180);

    double a = sin(deltaLat / 2) * sin(deltaLat / 2) +
        cos(lat1) * cos(lat2) * sin(deltaLng / 2) * sin(deltaLng / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return radioTierra * c;
  }

  /// Crea una copia del gimnasio con algunos campos actualizados
  Gimnasio copyWith({
    String? nombre,
    String? direccion,
    double? lat,
    double? lng,
    String? photoReference,
    String? placeId,
    double? rating,
    int? totalRatings,
    bool? isOpen,
    List<String>? tipos,
    String? numeroTelefono,
    String? sitioWeb,
  }) {
    return Gimnasio(
      nombre: nombre ?? this.nombre,
      direccion: direccion ?? this.direccion,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      photoReference: photoReference ?? this.photoReference,
      placeId: placeId ?? this.placeId,
      rating: rating ?? this.rating,
      totalRatings: totalRatings ?? this.totalRatings,
      isOpen: isOpen ?? this.isOpen,
      tipos: tipos ?? this.tipos,
      numeroTelefono: numeroTelefono ?? this.numeroTelefono,
      sitioWeb: sitioWeb ?? this.sitioWeb,
    );
  }

  @override
  String toString() {
    return 'Gimnasio(nombre: $nombre, direccion: $direccion, lat: $lat, lng: $lng)';
  }
} 