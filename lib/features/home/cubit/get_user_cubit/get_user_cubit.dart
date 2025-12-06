class GetUserCubit extends Cubit<GetUserState> {
  GetUserCubit() : super(GetUserInitialState());
  static GetUserCubit get(context) => BlocProvider.of(context);

  void getTasks() async {
    emit(GetUserLoadingState());
    HomeRepo repo = HomeRepo();
    var result = await repo.getTasks();
    result.fold(
      (error) => emit(GetTasksErrorState(error: error)),
      (List<UserModel> tasks) => emit(GetUserSuccessState(tasks: tasks)),
    );
  }
}
