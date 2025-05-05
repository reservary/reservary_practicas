import 'dart:convert';
import 'package:http/http.dart' as http;
import 'modelo/superhero_response.dart';

class Repositorio {
  final String urlBase = 'https://superheroapi.com/api/';
  final String claveApi = 'YOUR_API_KEY'; // Reemplaza con tu clave API real

  Future<RespuestaSuperheroe?> obtenerInfoSuperheroe(
    String terminoBusqueda,
  ) async {
    if (terminoBusqueda.isEmpty) return null;

    try {
      final respuesta = await http.get(
        Uri.parse('$urlBase$claveApi/search/$terminoBusqueda'),
      );

      if (respuesta.statusCode == 200) {
        return RespuestaSuperheroe.desdeJson(json.decode(respuesta.body));
      } else {
        throw Exception('Error al cargar los datos del superhéroe');
      }
    } catch (e) {
      print('Error al obtener datos del superhéroe: $e');
      return null;
    }
  }
}
