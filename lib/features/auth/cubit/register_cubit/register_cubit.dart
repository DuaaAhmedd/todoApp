import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/features/auth/data/repo/auth_repo.dart';

import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);

  var username = TextEditingController();
  var password = TextEditingController();
  var confirmPassword = TextEditingController();
  var formKey = GlobalKey<FormState>();

  void onRegisterPressed() async {
    if (formKey.currentState?.validate() == true) {
      emit(RegisterLoadingState());
      AuthRepo repo = AuthRepo();
      var result = await repo.register(
        username: username.text,
        password: password.text,
      );
      result.fold(
        (String error) => emit(RegisterErrorState(error)),
        (String message) => emit(RegisterSuccessState(message)),
      );
    }
  }

  bool passwordSecure = true;
  void changePasswordSecure() {
    passwordSecure = !passwordSecure;
    emit(RegisterPasswordChangedVisibilityState());
  }

  bool confirmPasswordSecure = true;
  void changeConfirmPasswordSecure() {
    confirmPasswordSecure = !confirmPasswordSecure;
    emit(RegisterPasswordChangedVisibilityState());
  }
}
