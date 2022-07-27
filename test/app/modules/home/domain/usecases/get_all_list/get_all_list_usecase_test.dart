import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/app/modules/home/domain/entities/all_entity.dart';
import 'package:movie_app/app/modules/home/domain/error/all_error/get_all_list_usecase_error.dart';
import 'package:movie_app/app/modules/home/domain/error/all_error/i_all_error.dart';
import 'package:movie_app/app/modules/home/domain/repositories/i_all_repository.dart';
import 'package:movie_app/app/modules/home/domain/usecases/get_all_list/get_all_list_usecase.dart';

class AllRepositoryMock extends Mock implements IAllRepository {}

void main() {
  final IAllRepository allRepository = AllRepositoryMock();
  final GetAllListUsecase getAllListUsecase = GetAllListUsecase(allRepository);

  test(
    'espero que meu getAllList retorn uma lista de AllEntity vindas do repository',
    () async {
      when(
        () => allRepository.fetchAll(),
      ).thenAnswer((invocation) async => const Right([AllEntity()]));
      final listResult = await getAllListUsecase.getAllList();

      expect(listResult.fold(id, id), isA<List<AllEntity>>());
    },
  );
  test(
    'espero que meu getAllList retorn um GetAllListUsecaseError quando der algum error no repository',
    () async {
      when(
        () => allRepository.fetchAll(),
      ).thenAnswer(
        (invocation) async => Left(GetAllListUsecaseError(menssageError: '')),
      );
      final listResult = await getAllListUsecase.getAllList();

      expect(listResult.fold((l) => l, (r) => r), isA<IAllError>());
    },
  );
}
