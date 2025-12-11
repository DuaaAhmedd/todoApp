import 'package:flutter_bloc/flutter_bloc.dart';
import '/features/home/data/repo/home_repo.dart';
import '/features/home/cubit/delete_task_cubit/delete_task_state.dart';

class DeleteTaskCubit extends Cubit<DeleteTaskState> {
  DeleteTaskCubit() : super(DeleteTaskInitialState());
  static DeleteTaskCubit get(context) => BlocProvider.of(context);

  void deleteTask(int taskId) async {
    emit(DeleteTaskLoadingState());
    HomeRepo repo = HomeRepo();
    var result = await repo.deleteTask(taskId);
    result.fold(
      (error) => emit(DeleteTaskErrorState(error: error)),
      (success) => emit(DeleteTaskSuccessState()),
    );
  }
}
