import 'package:dio/dio.dart';

import '../../domain/entities/movie_entity.dart';
import '../../domain/error/movie_error/movie_datasource_error.dart';
import '../../infra/datasources/i_movie_datasource.dart';
import '../../infra/mapper/movie_mapper.dart';

class MovieDatasource implements IMovieDatasource {
  final Dio dio;

  MovieDatasource(
    this.dio,
  );

  @override
  Future<List<MovieEntity>> fetchMovie() async {
    try {
      const url =
          'https://api.themoviedb.org/3/movie/popular?api_key=d650524e214687f05a1e72fa559caafe';
      final response = await dio.get(url);
      final body = (response.data['results']) as List;
      return MovieMapper().toList(body);
    } on DioError catch (e) {
      throw MovieDatasourceError(menssageError: e.message);
    }
  }
}
