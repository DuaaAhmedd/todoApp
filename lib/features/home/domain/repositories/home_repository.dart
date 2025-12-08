import 'package:dartz/dartz.dart';
import '/core/error/failures.dart';
import '/features/auth/domain/entities/user.dart';
import '/features/home/domain/entities/task.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<Task>>> getTasks();
  Future<Either<Failure, User>> getUser();
}
