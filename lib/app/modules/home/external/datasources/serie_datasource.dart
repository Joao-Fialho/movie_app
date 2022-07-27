import 'package:dio/dio.dart';
import '../../domain/entities/serie_entity.dart';
import '../../domain/error/serie_error/serie_datasource_error.dart';
import '../../infra/datasources/i_serie_datasource.dart';
import '../../infra/mapper/serie_mapper.dart';

class SerieDatasource implements ISerieDatasource {
  final Dio dio;

  SerieDatasource(
    this.dio,
  );

  @override
  Future<List<SerieEntity>> fetchSerie() async {
    try {
      const url =
          'https://api.themoviedb.org/3/tv/popular?api_key=d650524e214687f05a1e72fa559caafe';
      final response = await dio.get(url);
      final body = response.data['results'] as List;
      return SerieMapper().toList(body);
    } on DioError catch (e) {
      throw SerieDatasourceError(menssageError: e.message);
    }
  }
}
