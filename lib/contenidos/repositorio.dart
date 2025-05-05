import 'package:segundoejercicioflutter/contenidos/modelo/respuesta_superheroes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Repositorio {
  Future<SuperheroResponse?> fetchSuperheroInfo(String name) async {
    final response = await http.get(
      Uri.parse(
        "https://www.superheroapi.com/api.php/e9502e31a15e7ccd5e46404abf8e5517/search/$name",
      ),
    );
    if (response.statusCode == 200) {
      var decodedJson = jsonDecode(response.body);
      SuperheroResponse superheroResponse = SuperheroResponse.fromJson(
        decodedJson,
      );
      return superheroResponse;
    } else {
      return null;
    }
  }
}
