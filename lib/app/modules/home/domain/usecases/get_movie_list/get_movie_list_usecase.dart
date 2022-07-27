import 'package:dartz/dartz.dart';

import '../../entities/movie_entity.dart';
import '../../error/movie_error/i_movie_error.dart';
import '../../repositories/i_movie_repository.dart';
import 'i_get_movie_list_usecase.dart';

class GetMovieListUsecase implements IGetMovieListUsecase {
  final IMovieRepository repository;
  GetMovieListUsecase(
    this.repository,
  );

  @override
  Future<Either<IMovieError, List<MovieEntity>>> getMovieList() async {
    return await repository.fetchMovie();
  }
}
