import 'i_serie_error.dart';

class SerieRepositoryError extends ISerieError {
  SerieRepositoryError({required String menssageError})
      : super(menssageError: menssageError);
  @override
  String toString() {
    return menssageError;
  }
}
