import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/auth/data/models/user_model.dart';
import '/features/home/data/repo/home_repo.dart';
import '/features/home/cubit/get_user_cubit/get_user_state.dart';

class GetUserCubit extends Cubit<GetUserState> {
  GetUserCubit() : super(GetUserInitialState());
  static GetUserCubit get(context) => BlocProvider.of(context);

  void getusers() async {
    emit(GetUserLoadingState());
    HomeRepo repo = HomeRepo();
    var result = await repo.getusers();
    result.fold(
      (error) => emit(GetUserErrorState(error: error)),
      (users) => emit(GetUserSuccessState(users: users)),
    );
  }
}
