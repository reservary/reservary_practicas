import 'package:videogames_search/data/model/videogame_detail.dart';

class VideogamesResponse {
  final List<VideogameDetail> result;

    VideogamesResponse({required this.result});

  factory VideogamesResponse.fromJson(Map<String, dynamic> json) {
    var list = json['results'] as List;
    List<VideogameDetail> results = list.map((e) => VideogameDetail.fromJson(e)).toList();
    return VideogamesResponse(result: results);
  }
}
