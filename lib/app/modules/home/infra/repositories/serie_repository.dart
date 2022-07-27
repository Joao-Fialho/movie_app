import 'package:dartz/dartz.dart';

import '../../domain/entities/serie_entity.dart';
import '../../domain/error/serie_error/i_serie_error.dart';
import '../../domain/error/serie_error/serie__repository_error.dart';
import '../../domain/repositories/i_serie_repository.dart';
import '../datasources/i_serie_datasource.dart';

class SerieRepository implements ISerieRepository {
  final ISerieDatasource datasource;
  SerieRepository(
    this.datasource,
  );

  @override
  Future<Either<ISerieError, List<SerieEntity>>> fetchSerie() async {
    try {
      final List<SerieEntity> result = await datasource.fetchSerie();
      if (result.isNotEmpty) {
        return Right(result);
      } else {
        return Left(
          SerieRepositoryError(menssageError: 'Lista de Series está vazia'),
        );
      }
    } on ISerieError catch (e) {
      return Left(SerieRepositoryError(menssageError: e.menssageError));
    }
  }
}
