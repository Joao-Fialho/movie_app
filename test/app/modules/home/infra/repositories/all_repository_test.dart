import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/app/modules/home/domain/entities/all_entity.dart';
import 'package:movie_app/app/modules/home/domain/error/all_error/all_datasource_error.dart';
import 'package:movie_app/app/modules/home/domain/error/all_error/all_repository_error.dart';
import 'package:movie_app/app/modules/home/domain/error/all_error/i_all_error.dart';
import 'package:movie_app/app/modules/home/domain/repositories/i_all_repository.dart';
import 'package:movie_app/app/modules/home/infra/datasources/i_all_datasource.dart';
import 'package:movie_app/app/modules/home/infra/repositories/all_repository.dart';

class AllDatasourceMock extends Mock implements IAllDatasource {}

void main() {
  final IAllDatasource allDatasource = AllDatasourceMock();
  final IAllRepository allRepository = AllRepository(allDatasource);
  test('meu fetchAll deve retornar uma lista de allEntity', () async {
    //quando chamar o datasource responda lista de allEntity
    when(() => allDatasource.fetchAll())
        .thenAnswer((invocation) async => [const AllEntity()]);
    final result = await allRepository.fetchAll();

    expect(result.fold((l) => l, (r) => r), isA<List<AllEntity>>());
  });

  test(
      'meu fetchAll deve retornar um erro quando a minha lista vir vazia do datasource',
      () async {
    //quando chamar o datasource responda lista de allEntity
    when(() => allDatasource.fetchAll()).thenAnswer((invocation) async => []);
    final result = await allRepository.fetchAll();

    expect(result.fold((l) => l, (r) => r), isA<IAllError>());
  });

  test(
      'se meu datasource der error meu fetchAll deve retorna um AllRepositoryError',
      () async {
    //quando chamar o datasource responda lista de allEntity
    when(() => allDatasource.fetchAll())
        .thenThrow(AllDatasourceError(menssageError: ''));
    final result = await allRepository.fetchAll();

    expect(result.fold((l) => l, (r) => r), isA<AllRepositoryError>());
  });
}
