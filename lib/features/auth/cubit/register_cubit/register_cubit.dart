import 'package:flutter_bloc/flutter_bloc.dart';
import '/features/auth/data/repo/auth_repo.dart';
import 'register_state.dart';

/// RegisterCubit - ViewModel for registration feature
/// Handles business logic for user registration
/// Following MVVM pattern - UI controllers should be in the View layer
class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepo _authRepo;

  RegisterCubit({AuthRepo? authRepo})
      : _authRepo = authRepo ?? AuthRepo(),
        super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  /// Perform registration operation
  /// Accepts username and password from the View layer
  Future<void> register({
    required String username,
    required String password,
  }) async {
    emit(RegisterLoadingState());

    final result = await _authRepo.register(
      username: username,
      password: password,
    );

    result.fold(
      (String error) => emit(RegisterErrorState(error)),
      (String message) => emit(RegisterSuccessState(message)),
    );
  }

  // Password visibility state
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
