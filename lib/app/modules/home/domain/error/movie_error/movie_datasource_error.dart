import 'i_movie_error.dart';

class MovieDatasourceError extends IMovieError {
  MovieDatasourceError({required String menssageError})
      : super(menssageError: menssageError);
  @override
  String toString() {
    return menssageError;
  }
}
