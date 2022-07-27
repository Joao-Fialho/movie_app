import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../../../core/app_strings.dart';
import '../../domain/entities/all_entity.dart';
import '../../domain/entities/movie_entity.dart';
import '../../domain/entities/serie_entity.dart';
import '../../domain/error/all_error/i_all_error.dart';
import '../../domain/error/movie_error/i_movie_error.dart';
import '../../domain/error/serie_error/i_serie_error.dart';
import '../stores/all_store.dart';
import '../stores/movie_store.dart';
import '../stores/serie_store.dart';
import 'components/card_title.dart';
import 'components/filter_button/filter_button.dart';
import 'components/filter_button/filter_button_model.dart';
import 'components/fundo_em_breve.dart';
import 'components/home_app_bar.dart';

class HomeScreen extends StatefulWidget {
  final MovieStore movieStore;
  final SerieStore serieStore;
  final AllStore allStore;
  const HomeScreen({
    Key? key,
    required this.movieStore,
    required this.serieStore,
    required this.allStore,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MovieStore movieStore;
  late SerieStore serieStore;
  late AllStore allStore;
  final List<FilterButtonModel> listFilterButtons = [
    FilterButtonModel(textFilter: 'All'),
    FilterButtonModel(textFilter: 'Movies'),
    FilterButtonModel(textFilter: 'Series'),
    FilterButtonModel(textFilter: 'Animes'),
  ];
  final PageController _pageController = PageController();
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    movieStore = widget.movieStore;
    movieStore.getMovieList();
    serieStore = widget.serieStore;
    serieStore.getSeriesList();
    allStore = widget.allStore;
    allStore.getAllList();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  String searchValue = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(
        children: [
          selectedIndex == 3 ? const FundoEmBreve() : Container(),
          SingleChildScrollView(
            child: Center(
              child: SizedBox(
                width: size.width * 0.92,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //AppBar
                    HomeAppBar(
                      onChanged: (value) {
                        setState(() {
                          searchValue = value;
                          if (selectedIndex == 0) {
                            allStore.searchByTitleInAll(searchValue);
                          } else if (selectedIndex == 1) {
                            movieStore.searchByTitleInMovie(searchValue);
                          } else if (selectedIndex == 2) {
                            serieStore.searchByTitleInSerie(searchValue);
                          }
                        });
                      },
                    ),

                    //Categorias e Filtro
                    SizedBox(
                      height: size.height * 0.14,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            AppStrings.categories,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontSize: size.height * 0.045,
                                ),
                          ),
                          SizedBox(
                            height: size.width * 0.1,

                            //Filtro
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: listFilterButtons.length,
                              separatorBuilder: (context, index) {
                                return Container(
                                  width: size.width * 0.03,
                                );
                              },
                              itemBuilder: (context, index) {
                                final FilterButtonModel item =
                                    listFilterButtons[index];
                                return FilterButton(
                                  textFilter: item.textFilter,
                                  isSelected: index == selectedIndex,
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                      if (_pageController.hasClients) {
                                        _pageController.animateToPage(
                                          selectedIndex,
                                          duration: const Duration(
                                            milliseconds: 1000,
                                          ),
                                          curve: Curves.ease,
                                        );
                                      }
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Pages View
                    Container(
                      margin: EdgeInsets.only(top: size.width * 0.05),
                      height: size.height * 0.71,
                      child: PageView(
                        onPageChanged: ((value) {
                          setState(() {
                            selectedIndex = value;
                            allStore.checkSearchedAll(searchValue);
                            movieStore.checkSearchedMovie(searchValue);
                            serieStore.checkSearchedSerie(searchValue);
                          });
                        }),
                        controller: _pageController,
                        children: [
                          //All API
                          ScopedBuilder<AllStore, IAllError, List<AllEntity>>(
                            store: allStore,
                            onError: (context, state) {
                              return SizedBox(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      state!.menssageError.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontSize: size.width * 0.07,
                                          ),
                                    ),
                                    SizedBox(
                                      height: size.width * 0.05,
                                    ),
                                    Text(
                                      ':(',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontSize: size.width * 0.2,
                                          ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            onState: ((context, state) {
                              if (allStore.searchFound == false) {
                                return SizedBox(
                                  child: ListView.separated(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    separatorBuilder: (context, index) =>
                                        Container(
                                      height: size.height * 0.02,
                                    ),
                                    itemCount: state.length,
                                    itemBuilder: (context, index) {
                                      final item = state[index];
                                      return CardTitle(
                                        posterURL: item.poster,
                                        releaseDate: item.releaseDate,
                                        mediaType: item.mediaType,
                                        title: item.title,
                                        averageScore: item.averageScore,
                                      );
                                    },
                                  ),
                                );
                              } else {
                                return Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    AppStrings.resultNotFound,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          fontSize: size.width * 0.06,
                                        ),
                                  ),
                                );
                              }
                            }),
                            onLoading: (context) => const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          ),

                          //Movie API
                          ScopedBuilder<MovieStore, IMovieError,
                              List<MovieEntity>>(
                            store: movieStore,
                            onError: (context, state) {
                              return SizedBox(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      state!.menssageError.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontSize: size.width * 0.07,
                                          ),
                                    ),
                                    SizedBox(
                                      height: size.width * 0.05,
                                    ),
                                    Text(
                                      ':(',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontSize: size.width * 0.2,
                                          ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            onState: ((context, state) {
                              if (movieStore.searchFound == false) {
                                return SizedBox(
                                  child: ListView.separated(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    separatorBuilder: (context, index) =>
                                        Container(
                                      height: size.height * 0.02,
                                    ),
                                    itemCount: state.length,
                                    itemBuilder: (context, index) {
                                      final item = state[index];

                                      return CardTitle(
                                        posterURL: item.poster,
                                        releaseDate: item.releaseDate,
                                        title: item.title,
                                        averageScore: item.averageScore,
                                      );
                                    },
                                  ),
                                );
                              } else {
                                return Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    AppStrings.resultNotFound,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          fontSize: size.width * 0.06,
                                        ),
                                  ),
                                );
                              }
                            }),
                            onLoading: (context) => const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          ),

                          //Series API
                          ScopedBuilder<SerieStore, ISerieError,
                              List<SerieEntity>>(
                            store: serieStore,
                            onError: (context, state) {
                              return SizedBox(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      state!.menssageError.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontSize: size.width * 0.07,
                                          ),
                                    ),
                                    SizedBox(
                                      height: size.width * 0.05,
                                    ),
                                    Text(
                                      ':(',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontSize: size.width * 0.2,
                                          ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            onState: ((context, state) {
                              if (serieStore.searchFound == false) {
                                return SizedBox(
                                  height: 100,
                                  child: ListView.separated(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    separatorBuilder: (context, index) =>
                                        Container(
                                      height: size.height * 0.02,
                                    ),
                                    itemCount: state.length,
                                    itemBuilder: (context, index) {
                                      final item = state[index];

                                      return CardTitle(
                                        posterURL: item.poster,
                                        releaseDate: item.releaseDate,
                                        title: item.name,
                                        averageScore: item.averageScore,
                                      );
                                    },
                                  ),
                                );
                              } else {
                                return Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    AppStrings.resultNotFound,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          fontSize: size.width * 0.06,
                                        ),
                                  ),
                                );
                              }
                            }),
                            onLoading: (context) => const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          ),

                          //Anime Em Breve
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              AppStrings.comingSoon,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontSize: size.width * 0.13,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
