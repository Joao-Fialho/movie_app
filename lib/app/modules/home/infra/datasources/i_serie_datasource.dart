
import '../../domain/entities/serie_entity.dart';

abstract class ISerieDatasource {
  Future<List<SerieEntity>> fetchSerie();
}
