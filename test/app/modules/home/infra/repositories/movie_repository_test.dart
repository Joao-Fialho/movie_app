import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/app/modules/home/domain/entities/movie_entity.dart';
import 'package:movie_app/app/modules/home/domain/error/movie_error/i_movie_error.dart';
import 'package:movie_app/app/modules/home/domain/error/movie_error/movie_datasource_error.dart';
import 'package:movie_app/app/modules/home/domain/error/movie_error/movie_repository_error.dart';
import 'package:movie_app/app/modules/home/domain/repositories/i_movie_repository.dart';
import 'package:movie_app/app/modules/home/infra/datasources/i_movie_datasource.dart';
import 'package:movie_app/app/modules/home/infra/repositories/movie_repository.dart';

class MovieDatasourceMock extends Mock implements IMovieDatasource {}

void main() {
  final IMovieDatasource movieDatasource = MovieDatasourceMock();
  final IMovieRepository movieRepository = MovieRepository(movieDatasource);

  test('meu fetchMovie deve retornar uma lista de movieEntity', () async {
    when(() => movieDatasource.fetchMovie())
        .thenAnswer((invocation) async => [const MovieEntity()]);
    final result = await movieRepository.fetchMovie();
    expect(result.fold((l) => l, (r) => r), isA<List<MovieEntity>>());
  });
  test(
      'meu fetchMovie deve retornar um erro quando a minha lista vir vazia do datasource',
      () async {
    when(() => movieDatasource.fetchMovie())
        .thenAnswer((invocation) async => []);
    final result = await movieRepository.fetchMovie();
    expect(result.fold((l) => l, (r) => r), isA<IMovieError>());
  });

  test(
      'se o meu datasource der error meu fetchMovie deve retornar um MovieRepositoryError',
      () async {
    when(() => movieDatasource.fetchMovie())
        .thenThrow(MovieDatasourceError(menssageError: ''));
    final result = await movieRepository.fetchMovie();
    expect(result.fold((l) => l, (r) => r), isA<MovieRepositoryError>());
  });
}
