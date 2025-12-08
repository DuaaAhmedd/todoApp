import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '/core/error/failures.dart';
import '/core/usecases/usecase.dart';
import '/features/auth/domain/entities/user.dart';
import '/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase extends UseCase<User, LoginParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(LoginParams params) async {
    return await repository.login(
      username: params.username,
      password: params.password,
    );
  }
}

class LoginParams extends Equatable {
  final String username;
  final String password;

  const LoginParams({
    required this.username,
    required this.password,
  });

  @override
  List<Object> get props => [username, password];
}
