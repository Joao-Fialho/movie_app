import 'package:dartz/dartz.dart';

import '../../domain/entities/movie_entity.dart';
import '../../domain/error/movie_error/i_movie_error.dart';
import '../../domain/error/movie_error/movie_repository_error.dart';
import '../../domain/repositories/i_movie_repository.dart';
import '../datasources/i_movie_datasource.dart';

class MovieRepository implements IMovieRepository {
  final IMovieDatasource datasource;
  MovieRepository(
    this.datasource,
  );

  @override
  Future<Either<IMovieError, List<MovieEntity>>> fetchMovie() async {
    try {
      final List<MovieEntity> result = await datasource.fetchMovie();
      if (result.isNotEmpty) {
        return Right(result);
      } else {
        return Left(MovieRepositoryError(menssageError: 'Lista está vazia'));
      }
    } on IMovieError catch (e) {
      return Left(MovieRepositoryError(menssageError: e.menssageError));
    }
  }
}
