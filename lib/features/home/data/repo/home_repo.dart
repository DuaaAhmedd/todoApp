import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '/core/error/failures.dart';
import '/features/auth/domain/entities/user.dart';
import '/features/home/data/datasources/home_remote_data_source.dart';
import '/features/home/domain/entities/task.dart';
import '/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Task>>> getTasks() async {
    try {
      final result = await remoteDataSource.getTasks();
      return Right(result);
    } on DioException catch (e) {
      if (e.response?.data != null) {
        return Left(
          ServerFailure(e.response!.data['message'] ?? 'Failed to get tasks'),
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
  Future<Either<Failure, User>> getUser() async {
    try {
      final result = await remoteDataSource.getUser();
      return Right(result);
    } on DioException catch (e) {
      if (e.response?.data != null) {
        return Left(
          ServerFailure(e.response!.data['message'] ?? 'Failed to get user'),
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
