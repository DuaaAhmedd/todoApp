import '/features/home/data/models/tassk_model.dart';

abstract class GetUserState {}

class GetUserInitialState extends GetUserState {}

class GetUserLoadingState extends GetUserState {}

class GetUserSuccessState extends GetUserState {
  List<UserModel> tasks;
  GetUserSuccessState({required this.tasks});
}

class GetUserErrorState extends GetUserState {
  String error;
  GetUserErrorState({required this.error});
}
