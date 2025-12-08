import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '/core/error/failures.dart';
import '/core/usecases/usecase.dart';
import '/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase extends UseCase<String, RegisterParams> {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(RegisterParams params) async {
    return await repository.register(
      username: params.username,
      password: params.password,
    );
  }
}

class RegisterParams extends Equatable {
  final String username;
  final String password;

  const RegisterParams({
    required this.username,
    required this.password,
  });

  @override
  List<Object> get props => [username, password];
}
