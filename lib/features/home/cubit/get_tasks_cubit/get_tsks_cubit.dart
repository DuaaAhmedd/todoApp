import 'package:flutter_bloc/flutter_bloc.dart';
import '/features/home/data/models/tassk_model.dart';
import '/features/home/data/repo/home_repo.dart';

import '/features/home/cubit/get_tasks_cubit/get_tsks_state.dart';

class GetTasksCubit extends Cubit<GetTasksState> {
  GetTasksCubit() : super(GetTasksInitialState());
  static GetTasksCubit get(context) => BlocProvider.of(context);

  void getTasks() async {
    emit(GetTasksLoadingState());
    HomeRepo repo = HomeRepo();
    var result = await repo.getTasks();
    result.fold(
      (error) => emit(GetTasksErrorState(error: error)),
      (List<TaskModel> tasks) => emit(GetTasksSuccessState(tasks: tasks)),
    );
  }
}
