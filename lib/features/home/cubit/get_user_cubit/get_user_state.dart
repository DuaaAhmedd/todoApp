import '/features/auth/domain/entities/user.dart';

abstract class GetUserState {}

class GetUserInitialState extends GetUserState {}

class GetUserLoadingState extends GetUserState {}

class GetUserSuccessState extends GetUserState {
  final User users;
  GetUserSuccessState({required this.users});
}

class GetUserErrorState extends GetUserState {
  final String error;
  GetUserErrorState({required this.error});
}
