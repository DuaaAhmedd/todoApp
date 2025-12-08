import 'package:flutter_bloc/flutter_bloc.dart';
import '/features/auth/domain/usecases/register_usecase.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterCubit(this.registerUseCase) : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void register({
    required String username,
    required String password,
  }) async {
    emit(RegisterLoadingState());

    final result = await registerUseCase(
      RegisterParams(username: username, password: password),
    );

    result.fold(
      (failure) => emit(RegisterErrorState(failure.message)),
      (message) => emit(RegisterSuccessState(message)),
    );
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
