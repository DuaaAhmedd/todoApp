import 'package:flutter_bloc/flutter_bloc.dart';
import '/features/home/data/repo/home_repo.dart';
import '/features/home/cubit/edit_task_cubit/edit_task_state.dart';

class EditTaskCubit extends Cubit<EditTaskState> {
  EditTaskCubit() : super(EditTaskInitialState());
  static EditTaskCubit get(context) => BlocProvider.of(context);

  void editTask(int taskId, String title, String description) async {
    emit(EditTaskLoadingState());
    HomeRepo repo = HomeRepo();
    var result = await repo.editTask(taskId, title, description);
    result.fold(
      (error) => emit(EditTaskErrorState(error: error)),
      (task) => emit(EditTaskSuccessState(task: task)),
    );
  }
}
