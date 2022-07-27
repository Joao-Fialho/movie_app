// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/app/modules/home/domain/entities/movie_entity.dart';
import 'package:movie_app/app/modules/home/infra/mapper/movie_mapper.dart';

void main() {
  final MovieMapper movieMapper = MovieMapper();

  test(
    'espero que minha entidade receba os mesmos valores que meu mapper ',
    () async {
      // Arrange
      final tMapData = {
        'results': [
          {
            'title': 'Fantastic Beasts: The Secrets of Dumbledore',
            'vote_average': 6.8,
            'poster_path': '/jrgifaYeUtTnaH7NF5Drkgjg2MB.jpg',
            'release_date': '2022-04-06',
          },
        ],
      };

      final List<MovieEntity> listMovie = [
        MovieEntity(
          title: 'Fantastic Beasts: The Secrets of Dumbledore',
          averageScore: 6.8,
          poster: '/jrgifaYeUtTnaH7NF5Drkgjg2MB.jpg',
          releaseDate: '2022-04-06',
        ),
      ];

      // Act
      final listaMap = tMapData['results'] as List<Map>;
      final result = movieMapper.toList(listaMap);

      // Asserts
      expect(result, listMovie);
    },
  );
  test(
    'espero que se minha entidade receber valores nulos eles sejam trocados por valores vazios ',
    () async {
      // Arrange
      final tMapData = {
        'results': [
          {
            'title': null,
            'vote_average': null,
            'poster_path': null,
            'first_air_date': null,
            'media_type': null,
          },
        ],
      };

      final List<MovieEntity> listMovie = [];

      // Act
      final listaMap = tMapData['results'] as List<Map>;
      final result = movieMapper.toList(listaMap);

      // Asserts
      expect(result, listMovie);
    },
  );
}
