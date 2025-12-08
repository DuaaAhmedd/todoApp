import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/usecases/usecase.dart';
import '/features/home/domain/usecases/get_user_usecase.dart';
import '/features/home/cubit/get_user_cubit/get_user_state.dart';

class GetUserCubit extends Cubit<GetUserState> {
  final GetUserUseCase getUserUseCase;

  GetUserCubit(this.getUserUseCase) : super(GetUserInitialState());

  static GetUserCubit get(context) => BlocProvider.of(context);

  void getusers() async {
    emit(GetUserLoadingState());

    final result = await getUserUseCase(NoParams());

    result.fold(
      (failure) => emit(GetUserErrorState(error: failure.message)),
      (user) => emit(GetUserSuccessState(users: user)),
    );
  }
}
