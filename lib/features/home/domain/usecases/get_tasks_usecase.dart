import 'package:dartz/dartz.dart';
import '/core/error/failures.dart';
import '/core/usecases/usecase.dart';
import '/features/home/domain/entities/task.dart';
import '/features/home/domain/repositories/home_repository.dart';

class GetTasksUseCase extends UseCase<List<Task>, NoParams> {
  final HomeRepository repository;

  GetTasksUseCase(this.repository);

  @override
  Future<Either<Failure, List<Task>>> call(NoParams params) async {
    return await repository.getTasks();
  }
}
