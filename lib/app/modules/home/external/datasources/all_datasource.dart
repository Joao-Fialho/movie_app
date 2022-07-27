import 'package:dio/dio.dart';

import '../../domain/entities/all_entity.dart';
import '../../domain/error/all_error/all_datasource_error.dart';
import '../../infra/datasources/i_all_datasource.dart';
import '../../infra/mapper/all_mapper.dart';

class AllDatasource implements IAllDatasource {
  final Dio dio;

  AllDatasource(
    this.dio,
  );

  @override
  Future<List<AllEntity>> fetchAll() async {
    try {
      const url =
          'https://api.themoviedb.org/3/trending/all/week?api_key=d650524e214687f05a1e72fa559caafe';
      final response = await dio.get(url);
      final body = (response.data['results']) as List;
      return AllMapper().toList(body);
    } on DioError catch (e) {
      throw AllDatasourceError(menssageError: e.message);
    }
  }
}
