import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/features/auth/data/models/user_model.dart';
import '/features/auth/data/repo/auth_repo.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);

  var username = TextEditingController();
  var password = TextEditingController();
  var formKey = GlobalKey<FormState>();

  void onLoginPressed() async {
    if (formKey.currentState?.validate() == true) {
      emit(LoginLoadingState());
      AuthRepo repo = AuthRepo();
      var result = await repo.login(
        username: username.text,
        password: password.text,
      );
      result.fold(
        (String error) => emit(LoginErrorState(error)),
        (UserModel user) => emit(LoginSuccessState(user)),
      );
    }
  }

  bool passwordSecure = true;
  void changePasswordSecure() {
    passwordSecure = !passwordSecure;
    emit(LoginPasswordChangedVisibilityState());
  }
}
