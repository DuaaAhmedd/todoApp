import 'package:dartz/dartz.dart';
import '/core/error/failures.dart';
import '/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> register({
    required String username,
    required String password,
  });

  Future<Either<Failure, User>> login({
    required String username,
    required String password,
  });
}
