import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import '../../domain/entities/serie_entity.dart';
import '../../domain/error/serie_error/i_serie_error.dart';
import '../../domain/usecases/get_serie_list/i_get_serie_list_usercase.dart';

class SerieStore extends StreamStore<ISerieError, List<SerieEntity>> {
  final IGetSerieListUsecase getSerieListUsecase;
  late List<SerieEntity> resultSearchSerie = [];
  List<SerieEntity> listSearch = [];
  bool searchFound = false;

  SerieStore({
    required this.getSerieListUsecase,
  }) : super([]);

  Future<void> getSeriesList() async {
    setLoading(true);
    final result = await getSerieListUsecase.getSerieList();
    result.fold(
      (l) => setError(l),
      (r) => update(resultSearchSerie = r),
    );
    setLoading(false);
  }

  void searchByTitleInSerie(String searchValue) {
    final List<SerieEntity> listSearch = resultSearchSerie
        .where(
          (element) =>
              element.name.toLowerCase().contains(searchValue.toLowerCase()),
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
  bool fetchGetSerieList = false;
  @visibleForTesting
  bool fetchSearchByTitleInSerie = false;

  void checkSearchedSerie(searchValue) {
    setLoading(true);
    if (searchValue == '') {
      getSeriesList();
      fetchGetSerieList = true;
      setLoading(false);
    } else {
      searchByTitleInSerie(searchValue);
      fetchSearchByTitleInSerie = true;
      setLoading(false);
    }
  }
}

//talves tenha que ser uma lista 