import '../../domain/entities/movie_entity.dart';

class MovieMapper {
  MovieEntity toMapper(Map map) {
    return MovieEntity(
      title: map['title'] ?? '',
      averageScore: (map['vote_average'] ?? 0.0).toDouble(),
      poster: map['poster_path'] ?? '',
      releaseDate: map['release_date'] ?? '',
    );
  }

  List<MovieEntity> toList(List<dynamic> value) {
    final valueOficial = value.map((object) => toMapper(object)).toList();
    return valueOficial;
  }
}
//map, reducer,for in, list operadores,colections. 

//map -> lista<map>
