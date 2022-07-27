import 'package:flutter/cupertino.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../domain/entities/all_entity.dart';
import '../../domain/error/all_error/i_all_error.dart';
import '../../domain/usecases/get_all_list/i_get_all_list_usecase.dart';

class AllStore extends StreamStore<IAllError, List<AllEntity>> {
  final IGetAllListUsecase getAllListUsecase;
  late List<AllEntity> _resultSearchAll = [];
  List<AllEntity> listSearch = [];
  bool searchFound = false;

  AllStore({
    required this.getAllListUsecase,
  }) : super([]);

  Future<void> getAllList() async {
    setLoading(true);
    //o either ta vindo do repository, o fold faz retornar o l(erro) e o r(sucesso)
    final result = await getAllListUsecase.getAllList();
    result.fold(
      (l) => setError(l),
      (r) => update(_resultSearchAll = r),
    );
    setLoading(false);
  }

  void searchByTitleInAll(String searchValue) {
    //Faz a mesma coisa que meu for fazia ele percorre a lista de um jeito mais eficiente

    final List<AllEntity> listSearch = _resultSearchAll
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
  bool fetchGetAllList = false;
  @visibleForTesting
  bool fetchSearchByTitleInAll = false;

  void checkSearchedAll(searchValue) {
    setLoading(true);

    if (searchValue == '') {
      getAllList();
      fetchGetAllList = true;
      setLoading(false);
    } else {
      searchByTitleInAll(searchValue);
      fetchSearchByTitleInAll = true;
      setLoading(false);
    }
  }
}
