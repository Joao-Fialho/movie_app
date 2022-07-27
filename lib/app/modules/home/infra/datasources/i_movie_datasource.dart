import '../../domain/entities/movie_entity.dart';

abstract class IMovieDatasource {
  Future<List<MovieEntity>> fetchMovie();
}
