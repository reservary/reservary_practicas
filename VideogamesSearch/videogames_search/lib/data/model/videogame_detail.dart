class VideogameDetail {
  final String name;
  final String url;
  final String releaseDate;
  final EsrbRatingDetail? esrbRating;

  VideogameDetail({
    required this.name,
    required this.url,
    required this.releaseDate,
    required this.esrbRating,
  });

  factory VideogameDetail.fromJson(Map<String, dynamic> json) {
    return VideogameDetail(
      name:
          json['name'] ??
          'Sin nombre', // Si 'name' es null, asignar 'Sin nombre'
      url:
          json['background_image'] ??
          '', // Si 'background_image' es null, asignar ''
      releaseDate:
          json['released'] ??
          'Sin fecha', // Si 'released' es null, asignar 'Sin fecha'
      esrbRating:
          json['esrb_rating'] != null
              ? EsrbRatingDetail.fromJson(json['esrb_rating'])
              : null, // Si 'esrb_rating' es null, asignar null
    ); //si estuviese dentro de un subnivel , se pone url: json['background_image']['url']
  }
}

class EsrbRatingDetail {
  final String name;
  final String nameEn;

  EsrbRatingDetail({required this.name, required this.nameEn});

  factory EsrbRatingDetail.fromJson(Map<String, dynamic> json) {
    return EsrbRatingDetail(
      name: json['name'] ?? "",
      nameEn: json['name_en'] ?? "",
    );
  }
}
