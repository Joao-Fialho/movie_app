import 'package:dartz/dartz.dart';
import '../../entities/all_entity.dart';
import '../../error/all_error/i_all_error.dart';
import '../../repositories/i_all_repository.dart';
import 'i_get_all_list_usecase.dart';

class GetAllListUsecase implements IGetAllListUsecase {
  final IAllRepository repository;
  GetAllListUsecase(
    this.repository,
  );

  @override
  Future<Either<IAllError, List<AllEntity>>> getAllList() async {
    return await repository.fetchAll();
  }
}
