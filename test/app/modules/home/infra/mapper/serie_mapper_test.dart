// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/app/modules/home/domain/entities/serie_entity.dart';
import 'package:movie_app/app/modules/home/infra/mapper/serie_mapper.dart';

void main() {
  final SerieMapper serieMapper = SerieMapper();

  test(
    'espero que minha entidade receba os mesmos valores que meu mapper ',
    () async {
      // Arrange
      final tMapData = {
        'results': [
          {
            'name': 'Stranger Things',
            'vote_average': 8.6,
            'poster_path': '/49WJfeN0moxb9IPfGn8AIqMGskD.jpg',
            'first_air_date': '2016-07-15',
          },
        ],
      };

      final List<SerieEntity> listSerie = [
        SerieEntity(
          name: 'Stranger Things',
          averageScore: 8.6,
          poster: '/49WJfeN0moxb9IPfGn8AIqMGskD.jpg',
          releaseDate: '2016-07-15',
        ),
      ];

      // Act
      final result = serieMapper.toList(tMapData['results'] as List<Map>);

      // Asserts
      expect(result, listSerie);
    },
  );
  test(
    'espero que quando minha entidade receba valores nulos eles sejam trocados por vazios ',
    () async {
      // Arrange
      final tMapData = {
        'results': [
          {
            'name': null,
            'vote_average': 0.0,
            'poster_path': null,
            'first_air_date': null,
          },
        ],
      };

      final List<SerieEntity> listSerie = [];

      // Act
      final result = serieMapper.toList(tMapData['results'] as List<Map>);

      // Asserts
      expect(result, listSerie);
    },
  );
}
