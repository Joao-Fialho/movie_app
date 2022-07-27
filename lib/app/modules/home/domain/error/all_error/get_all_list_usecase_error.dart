import 'i_all_error.dart';

class GetAllListUsecaseError extends IAllError {
  GetAllListUsecaseError({required String menssageError})
      : super(menssageError: menssageError);
  @override
  String toString() {
    return menssageError;
  }
}
