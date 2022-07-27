import '../../domain/entities/all_entity.dart';

class AllMapper {
  AllEntity toMapper(Map map) {
    return AllEntity(
      averageScore: (map['vote_average'] ?? 0.0).toDouble(),
      mediaType: map['media_type'] ?? '',
      poster: map['poster_path'] ?? '',
      releaseDate: map['release_date'] ?? map['first_air_date'] ?? '',
      title: map['title'] ?? map['name'] ?? '',
    );
  }

  List<AllEntity> toList(List<dynamic> value) {
    final valueOficial = value.map((object) => toMapper(object)).toList();
    return valueOficial;
  }
}
