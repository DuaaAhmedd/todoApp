import '/features/home/data/models/tassk_model.dart';

abstract class GetTasksState {}

class GetTasksInitialState extends GetTasksState {}

class GetTasksLoadingState extends GetTasksState {}

class GetTasksSuccessState extends GetTasksState {
  List<TaskModel> tasks;
  GetTasksSuccessState({required this.tasks});
}

class GetTasksErrorState extends GetTasksState {
  String error;
  GetTasksErrorState({required this.error});
}
