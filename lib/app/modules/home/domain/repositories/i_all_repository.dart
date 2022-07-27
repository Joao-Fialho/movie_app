import 'package:dartz/dartz.dart';

import '../entities/all_entity.dart';
import '../error/all_error/i_all_error.dart';

abstract class IAllRepository {
  Future<Either<IAllError, List<AllEntity>>> fetchAll();
}

//movie repo