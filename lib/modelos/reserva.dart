class Reserva {
  final String cliente;
  final DateTime fecha;
  final String estado;
  final String plataforma;
  final String empleado;
  final String servicios;

  Reserva({
    required this.cliente,
    required this.fecha,
    required this.estado,
    required this.plataforma,
    required this.empleado,
    required this.servicios,
  });

  // Pasa de Reserva a JSON
  Map<String, dynamic> toJson() {
    return {
      'cliente': cliente,
      'fecha': fecha.toIso8601String(),
      'estado': estado,
      'plataforma': plataforma,
      'empleado': empleado,
      'servicios': servicios,
    };
  }

  // Pasa de JSON a Reserva
  factory Reserva.fromJson(Map<String, dynamic> json) {
    return Reserva(
      cliente: json['cliente'] as String,
      fecha: DateTime.parse(json['fecha'] as String),
      estado: json['estado'] as String,
      plataforma: json['plataforma'] as String,
      empleado: json['empleado'] as String,
      servicios: json['servicios'] as String,
    );
  }
}
