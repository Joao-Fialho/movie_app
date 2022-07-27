import 'i_movie_error.dart';

class MovieRepositoryError extends IMovieError {
  MovieRepositoryError({required String menssageError})
      : super(menssageError: menssageError);
  @override
  String toString() {
    return menssageError;
  }
}
