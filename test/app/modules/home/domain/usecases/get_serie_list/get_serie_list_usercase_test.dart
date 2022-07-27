import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/app/modules/home/domain/entities/serie_entity.dart';
import 'package:movie_app/app/modules/home/domain/error/serie_error/get_serie_list_usecase_error.dart';
import 'package:movie_app/app/modules/home/domain/error/serie_error/i_serie_error.dart';
import 'package:movie_app/app/modules/home/domain/repositories/i_serie_repository.dart';
import 'package:movie_app/app/modules/home/domain/usecases/get_serie_list/get_serie_list_usercase.dart';

class SerieRepositoryMock extends Mock implements ISerieRepository {}

void main() {
  final ISerieRepository serieRepository = SerieRepositoryMock();
  final GetSerieListUsecase getSerieListUsecase =
      GetSerieListUsecase(serieRepository);

  test(
    'espero que meu getSerieList retorn uma lista de serieEntity vindas do repository',
    () async {
      when(
        () => serieRepository.fetchSerie(),
      ).thenAnswer((invocation) async => const Right([SerieEntity()]));
      final listResult = await getSerieListUsecase.getSerieList();

      expect(listResult.fold((l) => l, (r) => r), isA<List<SerieEntity>>());
    },
  );
  test(
    'espero que meu getSerieList retorn um GetSerieListUsecaseError quando der algum error no repository',
    () async {
      when(
        () => serieRepository.fetchSerie(),
      ).thenAnswer(
        (invocation) async => Left(GetSerieListUsecaseError(menssageError: '')),
      );
      final listResult = await getSerieListUsecase.getSerieList();

      expect(listResult.fold((l) => l, (r) => r), isA<ISerieError>());
    },
  );
}
