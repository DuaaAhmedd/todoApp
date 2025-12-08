import '/features/auth/domain/entities/user.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginPasswordChangedVisibilityState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final User user;
  LoginSuccessState(this.user);
}

class LoginErrorState extends LoginState {
  final String error;
  LoginErrorState(this.error);
}
