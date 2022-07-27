import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/app/modules/home/domain/entities/serie_entity.dart';
import 'package:movie_app/app/modules/home/domain/error/serie_error/serie_datasource_error.dart';
import 'package:movie_app/app/modules/home/external/datasources/serie_datasource.dart';

class DioMock extends Mock implements Dio {}

void main() {
  final DioMock dio = DioMock();
  final SerieDatasource datasource = SerieDatasource(dio);
  test(
    'espero que meu datasource me retorne uma Lista de serieEntity',
    () async {
      when(() => dio.get(any())).thenAnswer(
        (invocation) async => Response(
          data: {
            'results': [
              {
                'title': 'Fantastic Beasts: The Secrets of Dumbledore',
                'vote_average': 6.8,
                'poster_path': '/jrgifaYeUtTnaH7NF5Drkgjg2MB.jpg',
                'release_date': '2022-04-06',
                'media_type': 'tv',
              },
              {
                'name': 'Fantastic Beasts: The Secrets of Dumbledore',
                'vote_average': 6.8,
                'poster_path': '/jrgifaYeUtTnaH7NF5Drkgjg2MB.jpg',
                'first_air_date': '2022-04-06',
                'media_type': 'tv',
              }
            ]
          },
          requestOptions: RequestOptions(
            path: '',
          ),
        ),
      );
      final List<SerieEntity> body = await datasource.fetchSerie();
      expect(body, isA<List<SerieEntity>>());
    },
  );

  test(
    'espero que se meu datasource nao conseguir puxar os dados da api ele retorne um DioError',
    () async {
      //any é independente da url que venha quero q retorne isso
      //toda vez q usar o thenThrow tem que usar o throwsA
      when(
        () => dio.get(any()),
      ).thenThrow(
        DioError(
          requestOptions: RequestOptions(path: ''),
          error: 'Http status error [401]',
          response: Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 401,
            data: jsonDecode(
              '''
{
  "test":"test"
}
''',
            ),
          ),
        ),
      );
      expect(
        () => datasource.fetchSerie(),
        throwsA(isA<SerieDatasourceError>()),
      );
    },
  );
}
