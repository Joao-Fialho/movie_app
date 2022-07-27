import 'package:dartz/dartz.dart';
import '../../entities/serie_entity.dart';
import '../../error/serie_error/i_serie_error.dart';

import '../../repositories/i_serie_repository.dart';
import 'i_get_serie_list_usercase.dart';

class GetSerieListUsecase implements IGetSerieListUsecase {
  final ISerieRepository repository;
  GetSerieListUsecase(
    this.repository,
  );

  @override
  Future<Either<ISerieError, List<SerieEntity>>> getSerieList() async {
    return await repository.fetchSerie();
  }
}
