import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/app/modules/home/domain/entities/all_entity.dart';
import 'package:movie_app/app/modules/home/infra/mapper/all_mapper.dart';

void main() {
  final AllMapper allMapper = AllMapper();
  test(
    'Espero que minha entidade receba os mesmos valores que o meu mappper',
    () async {
      const tMapData = {
        'results': [
          {
            'title': 'Fantastic Beasts: The Secrets of Dumbledore',
            'vote_average': 6.8,
            'poster_path': '/jrgifaYeUtTnaH7NF5Drkgjg2MB.jpg',
            'release_date': '2022-04-06',
            'media_type': 'tv',
          },
        ]
      };
      final List<AllEntity> listAll = [
        const AllEntity(
          averageScore: 6.8,
          mediaType: 'tv',
          poster: '/jrgifaYeUtTnaH7NF5Drkgjg2MB.jpg',
          releaseDate: '2022-04-06',
          title: 'Fantastic Beasts: The Secrets of Dumbledore',
        ),
      ];

      final listMap = tMapData['results'] as List<Map>;
      final result = allMapper.toList(listMap);

      expect(result, listAll);
    },
  );
  test(
    'Espero que quando a minha entidade receber valores nullos eles sejam trocados por valores vazios',
    () async {
      final tMapData = {
        'results': [
          {
            'title': null,
            'vote_average': 0.0,
            'poster_path': null,
            'release_date': null,
            'media_type': null,
          },
        ]
      };
      final List<AllEntity> listAll = [
        const AllEntity(),
      ];

      final listMap = tMapData['results'] as List<Map>;
      final result = allMapper.toList(listMap);

      expect(result, listAll);
    },
  );
  test(
    'quando nao tiver o title seja o name e se nao tiver o release_date seja o first_air_date',
    () async {
      final tMapData = {
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
      };
      final List<AllEntity> listAll = [
        const AllEntity(
          averageScore: 6.8,
          mediaType: 'tv',
          poster: '/jrgifaYeUtTnaH7NF5Drkgjg2MB.jpg',
          releaseDate: '2022-04-06',
          title: 'Fantastic Beasts: The Secrets of Dumbledore',
        ),
        const AllEntity(
          averageScore: 6.8,
          mediaType: 'tv',
          poster: '/jrgifaYeUtTnaH7NF5Drkgjg2MB.jpg',
          releaseDate: '2022-04-06',
          title: 'Fantastic Beasts: The Secrets of Dumbledore',
        ),
      ];

      final listMap = tMapData['results'] as List<Map>;
      final result = allMapper.toList(listMap);

      expect(result, listAll);
    },
  );
}
