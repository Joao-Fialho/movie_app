import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/app/modules/home/domain/entities/movie_entity.dart';
import 'package:movie_app/app/modules/home/domain/error/movie_error/get_movie_list_usecase_error.dart';
import 'package:movie_app/app/modules/home/domain/usecases/get_movie_list/i_get_movie_list_usecase.dart';
import 'package:movie_app/app/modules/home/presenter/stores/movie_store.dart';
import 'package:triple_test/triple_test.dart';

class GetMovieListUsecaseMock extends Mock implements IGetMovieListUsecase {}

void main() {
  final IGetMovieListUsecase usecase = GetMovieListUsecaseMock();
  final MovieStore store = MovieStore(getMovieListUsecase: usecase);
  storeTest<MovieStore>(
    'espero que meu getMovieList esteja retornando uma List de MovieEntity',
    build: () {
      when(
        () => usecase.getMovieList(),
      ).thenAnswer((invocation) async => const Right([MovieEntity()]));

      return MovieStore(getMovieListUsecase: usecase);
    },
    act: (store) => store.getMovieList(),
    wait: const Duration(milliseconds: 600),
    expect: () => [
      tripleLoading,
      tripleState,
      tripleLoading,
    ],
  );

  storeTest<MovieStore>(
    'espero que meu getMovieList caso de erro retorne um IMovieError',
    build: () {
      when(
        () => usecase.getMovieList(),
      ).thenAnswer(
        (invocation) async => Left(GetMovieListUsecaseError(menssageError: '')),
      );

      return MovieStore(getMovieListUsecase: usecase);
    },
    act: (store) => store.getMovieList(),
    wait: const Duration(milliseconds: 600),
    expect: () => [
      tripleLoading,
      tripleError,
      tripleLoading,
    ],
  );
  storeTest<MovieStore>(
    'espero que se meu searchByTitleInMovie de um update em uma lista indenpendente se seja vazia ou nao',
    build: () {
      when((() => usecase.getMovieList()))
          .thenAnswer((invocation) async => const Right([MovieEntity()]));

      store.getMovieList();
      store.searchByTitleInMovie('strang');
      return MovieStore(getMovieListUsecase: usecase);
    },
    act: (store) => store.searchByTitleInMovie('strang'),
    wait: const Duration(milliseconds: 600),
    expect: () => [
      tripleState,
    ],
  );

  test(
    'se searchValue for vazio e meu listSearch for vazia meu searchFound tem que ser falso',
    () {
      store.searchByTitleInMovie('');
      store.searchFound;
      store.listSearch;
      expect(store.searchFound, false);
      expect(store.listSearch, []);
    },
  );
  test(
    'se searchValue vier algo dentro e se meu listSearch vier com algo dentro meu searchFound tem que ser true',
    () {
      store.searchByTitleInMovie('strang');
      store.searchFound;
      store.listSearch = [const MovieEntity()];
      expect(store.searchFound, true);
      expect(store.listSearch, [const MovieEntity()]);
    },
  );

  test(
    'se o meu checkSearchedMovie receber uma string com algo dentro entao ele chama o searchByTitleInMovie e ele nao pode chamar o getMovieList',
    () {
      when((() => usecase.getMovieList()))
          .thenAnswer((invocation) async => const Right([MovieEntity()]));
      store.checkSearchedMovie('strange');

      store.fetchSearchByTitleInMovie;
      expect(store.fetchSearchByTitleInMovie, true);
      expect(store.fetchGetMovieList, false);
    },
  );

  test(
    'se o meu checkSearchedMovie receber uma string vazia entao ele chama o getMovieList e nao pode chamar o searchByTitleInMovie ',
    () {
      when((() => usecase.getMovieList()))
          .thenAnswer((invocation) async => const Right([MovieEntity()]));
      store.checkSearchedMovie('');
      store.fetchGetMovieList;
      expect(store.fetchGetMovieList, true);
      expect(store.fetchSearchByTitleInMovie, false);
    },
  );
}
