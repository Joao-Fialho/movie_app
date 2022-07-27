import 'i_movie_error.dart';

class GetMovieListUsecaseError extends IMovieError {
  GetMovieListUsecaseError({required String menssageError})
      : super(menssageError: menssageError);
  @override
  String toString() {
    return menssageError;
  }
}
