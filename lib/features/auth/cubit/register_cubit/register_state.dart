abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterPasswordChangedVisibilityState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  final String msg;
  RegisterSuccessState(this.msg);
}

class RegisterErrorState extends RegisterState {
  final String error;
  RegisterErrorState(this.error);
}
