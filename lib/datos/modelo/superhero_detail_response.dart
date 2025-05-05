class RespuestaDetalleSuperheroe {
  final String nombre;
  final String url;
  final Map<String, dynamic> estadisticasPoder;
  final Map<String, dynamic> biografia;
  final Map<String, dynamic> apariencia;
  final Map<String, dynamic> trabajo;
  final Map<String, dynamic> conexiones;

  RespuestaDetalleSuperheroe({
    required this.nombre,
    required this.url,
    required this.estadisticasPoder,
    required this.biografia,
    required this.apariencia,
    required this.trabajo,
    required this.conexiones,
  });

  factory RespuestaDetalleSuperheroe.desdeJson(Map<String, dynamic> json) {
    return RespuestaDetalleSuperheroe(
      nombre: json['name'] ?? '',
      url: json['image']?['url'] ?? '',
      estadisticasPoder: json['powerstats'] ?? {},
      biografia: json['biography'] ?? {},
      apariencia: json['appearance'] ?? {},
      trabajo: json['work'] ?? {},
      conexiones: json['connections'] ?? {},
    );
  }
}
