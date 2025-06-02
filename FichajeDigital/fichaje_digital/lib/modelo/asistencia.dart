class Asistencia {
  final DateTime fechaRegistro;
  final String tipo; // "entrada" o "salida"
  final String ip;
  final String localizacionIP;
  final double? latitud;
  final double? longitud;
  final String? ubicacionGPS;
  final String sistema;

  Asistencia({
    required this.fechaRegistro,
    required this.tipo,
    required this.ip,
    required this.localizacionIP,
    this.latitud,
    this.longitud,
    this.ubicacionGPS,
    required this.sistema,
  });

  @override
  String toString() {
    return '$tipo - $fechaRegistro - $ip - $localizacionIP - GPS: $ubicacionGPS - Sistema: $sistema';
  }
}
