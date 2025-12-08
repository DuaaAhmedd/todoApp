import '/features/home/data/models/tassk_model.dart';

abstract class GetTasksState {}

class GetTasksInitialState extends GetTasksState {}

class GetTasksLoadingState extends GetTasksState {}

class GetTasksSuccessState extends GetTasksState {
  final List<TaskModel> tasks;
  GetTasksSuccessState({required this.tasks});
}

class GetTasksErrorState extends GetTasksState {
  final String error;
  GetTasksErrorState({required this.error});
}
