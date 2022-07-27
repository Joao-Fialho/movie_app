import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../domain/entities/movie_entity.dart';
import '../../domain/error/movie_error/i_movie_error.dart';
import '../../domain/usecases/get_movie_list/i_get_movie_list_usecase.dart';

class MovieStore extends StreamStore<IMovieError, List<MovieEntity>> {
  final IGetMovieListUsecase getMovieListUsecase;
  late List<MovieEntity> resultSearchMovie = [];
  List<MovieEntity> listSearch = [];
  bool searchFound = false;

  MovieStore({
    required this.getMovieListUsecase,
  }) : super([]);

  Future<void> getMovieList() async {
    setLoading(true);
    final result = await getMovieListUsecase.getMovieList();
    result.fold(
      (l) => setError(l),
      (r) => update(resultSearchMovie = r),
    );
    setLoading(false);
  }

  void searchByTitleInMovie(String searchValue) {
    final List<MovieEntity> listSearch = resultSearchMovie
        .where(
          (element) =>
              element.title.toLowerCase().contains(searchValue.toLowerCase()),
        )
        .toList();

    if (listSearch.isEmpty && searchValue != '') {
      searchFound = true;
    } else {
      searchFound = false;
    }
    update(listSearch);
  }

  @visibleForTesting
  bool fetchGetMovieList = false;
  @visibleForTesting
  bool fetchSearchByTitleInMovie = false;

  void checkSearchedMovie(searchValue) {
    setLoading(true);

    if (searchValue == '') {
      getMovieList();
      fetchGetMovieList = true;
      setLoading(false);
    } else {
      searchByTitleInMovie(searchValue);
      fetchSearchByTitleInMovie = true;
      setLoading(false);
    }
  }
}
