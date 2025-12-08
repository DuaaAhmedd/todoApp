import 'package:flutter_bloc/flutter_bloc.dart';
import '/features/auth/domain/entities/user.dart';
import '/features/auth/domain/usecases/login_usecase.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit(this.loginUseCase) : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  void login({
    required String username,
    required String password,
  }) async {
    emit(LoginLoadingState());

    final result = await loginUseCase(
      LoginParams(username: username, password: password),
    );

    result.fold(
      (failure) => emit(LoginErrorState(failure.message)),
      (user) => emit(LoginSuccessState(user)),
    );
  }

  bool passwordSecure = true;
  void changePasswordSecure() {
    passwordSecure = !passwordSecure;
    emit(LoginPasswordChangedVisibilityState());
  }
}
