import 'package:dartz/dartz.dart';

import '../../../../../core/app_strings.dart';
import '../../domain/entities/all_entity.dart';
import '../../domain/error/all_error/all_repository_error.dart';
import '../../domain/error/all_error/i_all_error.dart';
import '../../domain/repositories/i_all_repository.dart';
import '../datasources/i_all_datasource.dart';

class AllRepository implements IAllRepository {
  final IAllDatasource datasource;
  AllRepository(
    this.datasource,
  );

  @override
  Future<Either<IAllError, List<AllEntity>>> fetchAll() async {
    try {
      final List<AllEntity> result = await datasource.fetchAll();
      if (result.isNotEmpty) {
        return Right(result);
      } else {
        return Left(
          AllRepositoryError(
            menssageError: AppStrings.messageErrorListEmpty,
          ),
        );
      }
    } on IAllError catch (e) {
      return Left(AllRepositoryError(menssageError: e.menssageError));
    }
  }
}
