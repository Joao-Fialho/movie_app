import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/app/modules/home/domain/entities/movie_entity.dart';
import 'package:movie_app/app/modules/home/domain/error/movie_error/get_movie_list_usecase_error.dart';
import 'package:movie_app/app/modules/home/domain/error/movie_error/i_movie_error.dart';
import 'package:movie_app/app/modules/home/domain/repositories/i_movie_repository.dart';
import 'package:movie_app/app/modules/home/domain/usecases/get_movie_list/get_movie_list_usecase.dart';

class MovieRepositoryMock extends Mock implements IMovieRepository {}

void main() {
  final IMovieRepository movieRepository = MovieRepositoryMock();
  final GetMovieListUsecase getMovieListUsecase =
      GetMovieListUsecase(movieRepository);

  test(
    'espero que meu getMovieList retorn uma lista de movieEntity vindas do repository',
    () async {
      when(
        () => movieRepository.fetchMovie(),
      ).thenAnswer((invocation) async => const Right([MovieEntity()]));
      final listResult = await getMovieListUsecase.getMovieList();

      expect(listResult.fold((l) => l, (r) => r), isA<List<MovieEntity>>());
    },
  );
  test(
    'espero que meu getMovieList retorn um GetMovieListUsecaseError quando der algum error no repository',
    () async {
      when(
        () => movieRepository.fetchMovie(),
      ).thenAnswer(
        (invocation) async => Left(GetMovieListUsecaseError(menssageError: '')),
      );
      final listResult = await getMovieListUsecase.getMovieList();

      expect(listResult.fold((l) => l, (r) => r), isA<IMovieError>());
    },
  );
}
