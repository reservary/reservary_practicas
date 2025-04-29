import 'dart:convert';

import 'package:videogames_search/data/model/videogames_response.dart';
import 'package:http/http.dart' as http;

class Repository {
  Future<VideogamesResponse> fetchVideogames(String name) async {
    final response = await http.get(
      Uri.parse("https://api.rawg.io/api/games?search=$name&page_size=5&page=1&key=79ee597068284e97aed5f2d47cebbcfd"),
    );
    if (response.statusCode == 200) {
      var decodedJson = jsonDecode(response.body);
      VideogamesResponse videogamesResponse = VideogamesResponse.fromJson(decodedJson);
      return videogamesResponse;
    } else {
      throw Exception("Error al obtener los datos");
    }
    // if (reponse.statusCode == 200) {
    //   var decodedJson = jsonDecode(reponse.body);
    //   VideogamesResponse videogamesResponse = VideogamesResponse.fromJson(
    //     decodedJson,
    //   );
    //   return videogamesResponse;
    // } else {
    //   throw Exception("Error al obtener los datos");
    // }
  }
}
