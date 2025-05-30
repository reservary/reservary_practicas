class Asistencia {
  final DateTime fechaEntrada;
  DateTime? fechaSalida;
  final String ip;
  final String localizacionIP;
  final double? latitud;
  final double? longitud;
  final String? ubicacionGPS;
  final String sistema;

  Asistencia({
    required this.fechaEntrada,
    this.fechaSalida,
    required this.ip,
    required this.localizacionIP,
    this.latitud,
    this.longitud,
    this.ubicacionGPS,
    required this.sistema,
  });
}
