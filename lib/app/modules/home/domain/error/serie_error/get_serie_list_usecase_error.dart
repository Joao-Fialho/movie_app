import 'i_serie_error.dart';

class GetSerieListUsecaseError extends ISerieError {
  GetSerieListUsecaseError({required String menssageError})
      : super(menssageError: menssageError);
  @override
  String toString() {
    return menssageError;
  }
}
