import 'i_all_error.dart';

class AllDatasourceError extends IAllError {
  AllDatasourceError({required String menssageError})
      : super(menssageError: menssageError);
  @override
  String toString() {
    return menssageError;
  }
}
