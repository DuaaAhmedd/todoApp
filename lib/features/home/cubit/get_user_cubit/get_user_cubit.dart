import 'package:flutter_bloc/flutter_bloc.dart';
import '/features/home/data/repo/home_repo.dart';
import '/features/home/cubit/get_user_cubit/get_user_state.dart';

/// GetUserCubit - ViewModel for user profile feature
/// Handles business logic for retrieving user information
class GetUserCubit extends Cubit<GetUserState> {
  final HomeRepo _homeRepo;

  GetUserCubit({HomeRepo? homeRepo})
      : _homeRepo = homeRepo ?? HomeRepo(),
        super(GetUserInitialState());

  static GetUserCubit get(context) => BlocProvider.of(context);

  /// Fetch user information from repository
  Future<void> getusers() async {
    emit(GetUserLoadingState());

    final result = await _homeRepo.getusers();

    result.fold(
      (error) => emit(GetUserErrorState(error: error)),
      (users) => emit(GetUserSuccessState(users: users)),
    );
  }
}
