import 'package:flutter_bloc/flutter_bloc.dart';
import '/features/home/data/models/tassk_model.dart';
import '/features/home/data/repo/home_repo.dart';
import '/features/home/cubit/get_tasks_cubit/get_tsks_state.dart';

/// GetTasksCubit - ViewModel for tasks feature
/// Handles business logic for retrieving user tasks
class GetTasksCubit extends Cubit<GetTasksState> {
  final HomeRepo _homeRepo;

  GetTasksCubit({HomeRepo? homeRepo})
      : _homeRepo = homeRepo ?? HomeRepo(),
        super(GetTasksInitialState());

  static GetTasksCubit get(context) => BlocProvider.of(context);

  /// Fetch user tasks from repository
  Future<void> getTasks() async {
    emit(GetTasksLoadingState());

    final result = await _homeRepo.getTasks();

    result.fold(
      (error) => emit(GetTasksErrorState(error: error)),
      (List<TaskModel> tasks) => emit(GetTasksSuccessState(tasks: tasks)),
    );
  }
}
