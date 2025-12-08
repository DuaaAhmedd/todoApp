import '/features/home/domain/entities/task.dart';

abstract class GetTasksState {}

class GetTasksInitialState extends GetTasksState {}

class GetTasksLoadingState extends GetTasksState {}

class GetTasksSuccessState extends GetTasksState {
  final List<Task> tasks;
  GetTasksSuccessState({required this.tasks});
}

class GetTasksErrorState extends GetTasksState {
  final String error;
  GetTasksErrorState({required this.error});
}
