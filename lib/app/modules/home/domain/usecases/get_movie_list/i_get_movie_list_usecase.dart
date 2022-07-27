import 'package:dartz/dartz.dart';

import '../../entities/movie_entity.dart';
import '../../error/movie_error/i_movie_error.dart';

abstract class IGetMovieListUsecase {
  Future<Either<IMovieError, List<MovieEntity>>> getMovieList();
}
