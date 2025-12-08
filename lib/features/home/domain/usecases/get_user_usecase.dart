import 'package:dartz/dartz.dart';
import '/core/error/failures.dart';
import '/core/usecases/usecase.dart';
import '/features/auth/domain/entities/user.dart';
import '/features/home/domain/repositories/home_repository.dart';

class GetUserUseCase extends UseCase<User, NoParams> {
  final HomeRepository repository;

  GetUserUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await repository.getUser();
  }
}
