import 'i_serie_error.dart';

class SerieDatasourceError extends ISerieError {
  SerieDatasourceError({required String menssageError})
      : super(menssageError: menssageError);
  @override
  String toString() {
    return menssageError;
  }
}
