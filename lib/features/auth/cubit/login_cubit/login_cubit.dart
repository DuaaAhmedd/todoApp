import 'package:flutter_bloc/flutter_bloc.dart';
import '/features/auth/data/models/user_model.dart';
import '/features/auth/data/repo/auth_repo.dart';
import 'login_state.dart';

/// LoginCubit - ViewModel for login feature
/// Handles business logic for user authentication
/// Following MVVM pattern - UI controllers should be in the View layer
class LoginCubit extends Cubit<LoginState> {
  final AuthRepo _authRepo;

  LoginCubit({AuthRepo? authRepo})
      : _authRepo = authRepo ?? AuthRepo(),
        super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  /// Perform login operation
  /// Accepts username and password from the View layer
  Future<void> login({
    required String username,
    required String password,
  }) async {
    emit(LoginLoadingState());

    final result = await _authRepo.login(
      username: username,
      password: password,
    );

    result.fold(
      (String error) => emit(LoginErrorState(error)),
      (UserModel user) => emit(LoginSuccessState(user)),
    );
  }

  // Password visibility state
  bool passwordSecure = true;

  void changePasswordSecure() {
    passwordSecure = !passwordSecure;
    emit(LoginPasswordChangedVisibilityState());
  }
}
