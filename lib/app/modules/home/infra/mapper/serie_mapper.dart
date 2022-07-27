import '../../domain/entities/serie_entity.dart';

class SerieMapper {
  SerieEntity toMapper(Map map) {
    return SerieEntity(
      name: map['name'] ?? '',
      averageScore: (map['vote_average'] ?? 0.0).toDouble(),
      poster: map['poster_path'] ?? '',
      releaseDate: map['first_air_date'] ?? '',
    );
  }

  List<SerieEntity> toList(List<dynamic> value) {
    final valueOficial = value.map((object) => toMapper(object)).toList();
    return valueOficial;
  }
}
