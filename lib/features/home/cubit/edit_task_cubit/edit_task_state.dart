import '/features/home/data/models/tassk_model.dart';

abstract class EditTaskState {}

class EditTaskInitialState extends EditTaskState {}

class EditTaskLoadingState extends EditTaskState {}

class EditTaskSuccessState extends EditTaskState {
  TaskModel task;
  EditTaskSuccessState({required this.task});
}

class EditTaskErrorState extends EditTaskState {
  String error;
  EditTaskErrorState({required this.error});
}
