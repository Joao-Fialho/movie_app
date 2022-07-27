import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/app/modules/home/domain/entities/all_entity.dart';
import 'package:movie_app/app/modules/home/domain/error/all_error/get_all_list_usecase_error.dart';
import 'package:movie_app/app/modules/home/domain/usecases/get_all_list/i_get_all_list_usecase.dart';
import 'package:movie_app/app/modules/home/presenter/stores/all_store.dart';
import 'package:triple_test/triple_test.dart';

class GetAllListUsecaseMock extends Mock implements IGetAllListUsecase {}

void main() {
  final IGetAllListUsecase usecase = GetAllListUsecaseMock();
  final AllStore store = AllStore(getAllListUsecase: usecase);
  storeTest<AllStore>(
    'Espero que meu getAllList esteja retornando uma List de AllEntity',
    build: () {
      when(
        () => usecase.getAllList(),
      ).thenAnswer((invocation) async => const Right([AllEntity()]));

      return AllStore(getAllListUsecase: usecase);
    },
    act: (store) => store.getAllList(),
    wait: const Duration(milliseconds: 600),
    expect: () => [
      tripleLoading,
      tripleState,
      tripleLoading,
    ],
  );

  storeTest<AllStore>(
    'espero que meu getAllList caso de erro retorne um IAllError',
    build: () {
      when(
        () => usecase.getAllList(),
      ).thenAnswer(
        (invocation) async => Left(GetAllListUsecaseError(menssageError: '')),
      );

      return AllStore(getAllListUsecase: usecase);
    },
    act: (store) => store.getAllList(),
    wait: const Duration(milliseconds: 600),
    expect: () => [
      tripleLoading,
      tripleError,
      tripleLoading,
    ],
  );
  storeTest<AllStore>(
    'espero que se meu searchByTitleInAll de um update em uma lista indenpendente se seja vazia ou nao  ',
    build: () {
      when((() => usecase.getAllList()))
          .thenAnswer((invocation) async => const Right([AllEntity()]));

      store.getAllList();
      store.searchByTitleInAll('strang');
      return AllStore(getAllListUsecase: usecase);
    },
    act: (store) => store.searchByTitleInAll('strang'),
    wait: const Duration(milliseconds: 600),
    expect: () => [
      tripleState,
    ],
  );

  test(
    'se searchValue for vazio e meu listSearch for vazia meu searchFound tem que ser falso',
    () {
      store.searchByTitleInAll('');
      store.searchFound;
      store.listSearch;
      expect(store.searchFound, false);
      expect(store.listSearch, []);
    },
  );
  test(
    'se searchValue vier algo dentro e se meu listSearch vier com algo dentro meu searchFound tem que ser true',
    () {
      store.searchByTitleInAll('strang');
      store.searchFound;
      store.listSearch = [const AllEntity()];
      expect(store.searchFound, true);
      expect(store.listSearch, [const AllEntity()]);
    },
  );

  test(
    'se o meu checkSearchedAll receber uma string com algo dentro entao ele chama o searchByTitleInAll e ele nao pode chamar o getAllList',
    () {
      when((() => usecase.getAllList()))
          .thenAnswer((invocation) async => const Right([AllEntity()]));
      store.checkSearchedAll('strange');
      store.fetchSearchByTitleInAll;
      expect(store.fetchSearchByTitleInAll, true);
      expect(store.fetchGetAllList, false);
      verify(() => usecase.getAllList()).called(0);
    },
  );

  test(
    'se o meu checkSearchedAll receber uma string vazia entao ele chama o getAllList e nao pode chamar o searchByTitleInAll ',
    () {
      when((() => usecase.getAllList()))
          .thenAnswer((invocation) async => const Right([AllEntity()]));
      store.checkSearchedAll('');

      expect(store.fetchGetAllList, true);
      expect(store.fetchSearchByTitleInAll, false);
      verify(() => usecase.getAllList()).called(1);
    },
  );
}
