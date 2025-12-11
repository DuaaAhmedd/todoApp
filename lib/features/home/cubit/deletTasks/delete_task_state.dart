abstract class DeleteTaskState {}

class DeleteTaskInitialState extends DeleteTaskState {}

class DeleteTaskLoadingState extends DeleteTaskState {}

class DeleteTaskSuccessState extends DeleteTaskState {}

class DeleteTaskErrorState extends DeleteTaskState {
  String error;
  DeleteTaskErrorState({required this.error});
}
