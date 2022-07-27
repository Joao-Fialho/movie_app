import '../../domain/entities/all_entity.dart';

abstract class IAllDatasource {
  Future<List<AllEntity>> fetchAll();
}
