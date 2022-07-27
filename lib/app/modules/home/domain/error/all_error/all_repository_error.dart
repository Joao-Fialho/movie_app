import 'i_all_error.dart';

class AllRepositoryError extends IAllError {
  AllRepositoryError({required String menssageError})
      : super(menssageError: menssageError);
  @override
  String toString() {
    return menssageError;
  }
}
