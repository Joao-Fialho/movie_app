import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/app/modules/home/domain/entities/serie_entity.dart';
import 'package:movie_app/app/modules/home/domain/error/serie_error/get_serie_list_usecase_error.dart';
import 'package:movie_app/app/modules/home/domain/usecases/get_serie_list/i_get_serie_list_usercase.dart';
import 'package:movie_app/app/modules/home/presenter/stores/serie_store.dart';
import 'package:triple_test/triple_test.dart';

class GetSerieListUsecaseMock extends Mock implements IGetSerieListUsecase {}

void main() {
  final IGetSerieListUsecase usecase = GetSerieListUsecaseMock();
  final SerieStore store = SerieStore(getSerieListUsecase: usecase);
  storeTest<SerieStore>(
    'espero que meu getSerieList esteja retornando uma List de SerieEntity',
    build: () {
      when(
        () => usecase.getSerieList(),
      ).thenAnswer((invocation) async => const Right([SerieEntity()]));

      return SerieStore(getSerieListUsecase: usecase);
    },
    act: (store) => store.getSeriesList(),
    wait: const Duration(milliseconds: 600),
    expect: () => [
      tripleLoading,
      tripleState,
      tripleLoading,
    ],
  );

  storeTest<SerieStore>(
    'espero que meu getSerieList caso de erro retorne um ISerieError',
    build: () {
      when(
        () => usecase.getSerieList(),
      ).thenAnswer(
        (invocation) async => Left(GetSerieListUsecaseError(menssageError: '')),
      );

      return SerieStore(getSerieListUsecase: usecase);
    },
    act: (store) => store.getSeriesList(),
    wait: const Duration(milliseconds: 600),
    expect: () => [
      tripleLoading,
      tripleError,
      tripleLoading,
    ],
  );
  storeTest<SerieStore>(
    'espero que se meu searchByTitleInSerie de um update em uma lista indenpendente se seja vazia ou nao  ',
    build: () {
      when((() => usecase.getSerieList()))
          .thenAnswer((invocation) async => const Right([SerieEntity()]));

      store.getSeriesList();
      store.searchByTitleInSerie('strang');
      return SerieStore(getSerieListUsecase: usecase);
    },
    act: (store) => store.searchByTitleInSerie('strang'),
    wait: const Duration(milliseconds: 600),
    expect: () => [
      tripleState,
    ],
  );

  test(
    'se searchValue for vazio e meu listSearch for vazia meu searchFound tem que ser falso',
    () {
      store.searchByTitleInSerie('');
      store.searchFound;
      store.listSearch;
      expect(store.searchFound, false);
      expect(store.listSearch, []);
    },
  );
  test(
    'se searchValue vier algo dentro e se meu listSearch vier com algo dentro meu searchFound tem que ser true',
    () {
      store.searchByTitleInSerie('strang');
      store.searchFound;
      store.listSearch = [const SerieEntity()];
      expect(store.searchFound, true);
      expect(store.listSearch, [const SerieEntity()]);
    },
  );

  test(
    'se o meu checkSearchedSerie receber uma string com algo dentro entao ele chama o searchByTitleInSerie e ele nao pode chamar o getSerieList',
    () {
      when((() => usecase.getSerieList()))
          .thenAnswer((invocation) async => const Right([SerieEntity()]));
      store.checkSearchedSerie('strange');
      store.fetchSearchByTitleInSerie;
      expect(store.fetchSearchByTitleInSerie, true);
      expect(store.fetchGetSerieList, false);
    },
  );

  test(
    'se o meu checkSearchedSerie receber uma string vazia entao ele chama o getSerieList e nao pode chamar o searchByTitleInSerie ',
    () {
      when((() => usecase.getSerieList()))
          .thenAnswer((invocation) async => const Right([SerieEntity()]));
      store.checkSearchedSerie('');
      store.fetchGetSerieList;
      expect(store.fetchGetSerieList, true);
      expect(store.fetchSearchByTitleInSerie, false);
    },
  );
}
