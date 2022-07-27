import 'package:dartz/dartz.dart';

import '../entities/serie_entity.dart';
import '../error/serie_error/i_serie_error.dart';

abstract class ISerieRepository {
  Future<Either<ISerieError, List<SerieEntity>>> fetchSerie();
}
