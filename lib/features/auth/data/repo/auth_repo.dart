import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '/core/error/failures.dart';
import '/features/auth/data/datasources/auth_remote_data_source.dart';
import '/features/auth/domain/entities/user.dart';
import '/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, String>> register({
    required String username,
    required String password,
  }) async {
    try {
      final result = await remoteDataSource.register(
        username: username,
        password: password,
      );
      return Right(result);
    } on DioException catch (e) {
      if (e.response?.data != null) {
        return Left(
          ServerFailure(e.response!.data['message'] ?? 'Registration failed'),
        );
      } else {
        return const Left(
          NetworkFailure('Network error. Please check your connection.'),
        );
      }
    } catch (e) {
      return const Left(ServerFailure('An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, User>> login({
    required String username,
    required String password,
  }) async {
    try {
      final result = await remoteDataSource.login(
        username: username,
        password: password,
      );
      return Right(result);
    } on DioException catch (e) {
      if (e.response?.data != null) {
        return Left(
          ServerFailure(e.response!.data['message'] ?? 'Login failed'),
        );
      } else {
        return const Left(
          NetworkFailure('Network error. Please check your connection.'),
        );
      }
    } catch (e) {
      return const Left(ServerFailure('An unexpected error occurred'));
    }
  }
}
