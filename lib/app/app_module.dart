import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/home/domain/usecases/get_all_list/get_all_list_usecase.dart';
import 'modules/home/domain/usecases/get_movie_list/get_movie_list_usecase.dart';
import 'modules/home/domain/usecases/get_serie_list/get_serie_list_usercase.dart';
import 'modules/home/external/datasources/all_datasource.dart';
import 'modules/home/external/datasources/movie_datasource.dart';
import 'modules/home/external/datasources/serie_datasource.dart';
import 'modules/home/infra/repositories/all_repository.dart';
import 'modules/home/infra/repositories/movie_repository.dart';
import 'modules/home/infra/repositories/serie_repository.dart';
import 'modules/home/presenter/home_screen/home_screen.dart';
import 'modules/home/presenter/stores/all_store.dart';
import 'modules/home/presenter/stores/movie_store.dart';
import 'modules/home/presenter/stores/serie_store.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => Dio()),
        Bind.singleton((i) => MovieDatasource(i())),
        Bind.singleton((i) => MovieRepository(i())),
        Bind.singleton((i) => GetMovieListUsecase(i())),
        Bind.singleton((i) => MovieStore(getMovieListUsecase: i())),
        Bind.singleton((i) => SerieDatasource(i())),
        Bind.singleton((i) => SerieRepository(i())),
        Bind.singleton((i) => GetSerieListUsecase(i())),
        Bind.singleton((i) => SerieStore(getSerieListUsecase: i())),
        Bind.singleton((i) => AllDatasource(i())),
        Bind.singleton((i) => AllRepository(i())),
        Bind.singleton((i) => GetAllListUsecase(i())),
        Bind.singleton((i) => AllStore(getAllListUsecase: i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: ((context, args) => HomeScreen(
                allStore: context.read(),
                movieStore: context.read(),
                serieStore: context.read(),
              )),
        ),
      ];
}
