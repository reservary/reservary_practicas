import 'superhero_detail_response.dart';

class RespuestaSuperheroe {
  final List<RespuestaDetalleSuperheroe>? resultado;

  RespuestaSuperheroe({this.resultado});

  factory RespuestaSuperheroe.desdeJson(Map<String, dynamic> json) {
    return RespuestaSuperheroe(
      resultado:
          (json['results'] as List?)
              ?.map((e) => RespuestaDetalleSuperheroe.desdeJson(e))
              .toList(),
    );
  }
}
