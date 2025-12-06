import '/features/home/data/models/get_user_response_model.dart';
import 'package:todo/features/auth/data/models/user_model.dart';

abstract class GetUserState {}

class GetUserInitialState extends GetUserState {}

class GetUserLoadingState extends GetUserState {}

class GetUserSuccessState extends GetUserState {
  final UserModel users;
  GetUserSuccessState({required this.users});
}

class GetUserErrorState extends GetUserState {
  String error;
  GetUserErrorState({required this.error});
}
