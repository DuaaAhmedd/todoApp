import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/usecases/usecase.dart';
import '/features/home/domain/usecases/get_tasks_usecase.dart';
import '/features/home/cubit/get_tasks_cubit/get_tsks_state.dart';

class GetTasksCubit extends Cubit<GetTasksState> {
  final GetTasksUseCase getTasksUseCase;

  GetTasksCubit(this.getTasksUseCase) : super(GetTasksInitialState());

  static GetTasksCubit get(context) => BlocProvider.of(context);

  void getTasks() async {
    emit(GetTasksLoadingState());

    final result = await getTasksUseCase(NoParams());

    result.fold(
      (failure) => emit(GetTasksErrorState(error: failure.message)),
      (tasks) => emit(GetTasksSuccessState(tasks: tasks)),
    );
  }
}
