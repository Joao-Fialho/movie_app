import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/app/modules/home/domain/entities/serie_entity.dart';
import 'package:movie_app/app/modules/home/domain/error/serie_error/i_serie_error.dart';
import 'package:movie_app/app/modules/home/domain/error/serie_error/serie__repository_error.dart';
import 'package:movie_app/app/modules/home/domain/error/serie_error/serie_datasource_error.dart';
import 'package:movie_app/app/modules/home/domain/repositories/i_serie_repository.dart';
import 'package:movie_app/app/modules/home/infra/datasources/i_serie_datasource.dart';
import 'package:movie_app/app/modules/home/infra/repositories/serie_repository.dart';

class SerieDatasourceMock extends Mock implements ISerieDatasource {}

void main() {
  final ISerieDatasource serieDatasource = SerieDatasourceMock();
  final ISerieRepository serieRepository = SerieRepository(serieDatasource);
  test('meu fetchSerie deve retornar uma lista de serieEntity', () async {
    when(() => serieDatasource.fetchSerie())
        .thenAnswer((invocation) async => [const SerieEntity()]);
    final result = await serieRepository.fetchSerie();

    expect(result.fold((l) => l, (r) => r), isA<List<SerieEntity>>());
  });

  test(
      'meu fetchSerie deve retornar um erro quando a minha lista vir vazia do datasource',
      () async {
    //quando chamar o datasource responda lista de allEntity
    when(() => serieDatasource.fetchSerie())
        .thenAnswer((invocation) async => []);
    final result = await serieRepository.fetchSerie();

    expect(result.fold((l) => l, (r) => r), isA<ISerieError>());
  });

  test(
      'se meu datasource der error meu fetchSerie deve retorna um SerieRepositoryError',
      () async {
    //quando chamar o datasource responda lista de allEntity
    when(() => serieDatasource.fetchSerie())
        .thenThrow(SerieDatasourceError(menssageError: ''));
    final result = await serieRepository.fetchSerie();

    expect(result.fold((l) => l, (r) => r), isA<SerieRepositoryError>());
  });
}
