import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/utils/app_colors.dart';
import '/core/helper/app_popup.dart';
import '/features/home/cubit/get_tasks_cubit/get_tsks_cubit.dart';
import '/features/home/cubit/get_tasks_cubit/get_tsks_state.dart';
import '/features/home/cubit/get_user_cubit/get_user_cubit.dart';
import '/features/home/cubit/delete_task_cubit/delete_task_cubit.dart';
import '/features/home/cubit/delete_task_cubit/delete_task_state.dart';
import '/features/home/cubit/edit_task_cubit/edit_task_cubit.dart';
import '/features/home/cubit/edit_task_cubit/edit_task_state.dart';
import 'package:todo/features/home/cubit/get_user_cubit/get_user_state.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  void _showDeleteConfirmation(BuildContext context, int taskId) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Delete Task'),
        content: Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              _deleteTask(context, taskId);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _deleteTask(BuildContext context, int taskId) {
    final tasksCubit = GetTasksCubit.get(context);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => BlocProvider(
        create: (context) => DeleteTaskCubit()..deleteTask(taskId),
        child: BlocConsumer<DeleteTaskCubit, DeleteTaskState>(
          listener: (blocContext, state) async {
            if (state is DeleteTaskSuccessState) {
              Navigator.of(dialogContext).pop();
              SnackBarPopUp().show(
                context: context,
                message: 'Task deleted successfully',
                state: PopUpState.success,
              );
              // Add slight delay to ensure backend has processed the delete
              await Future.delayed(Duration(milliseconds: 300));
              tasksCubit.getTasks();
            } else if (state is DeleteTaskErrorState) {
              Navigator.of(dialogContext).pop();
              SnackBarPopUp().show(
                context: context,
                message: state.error,
                state: PopUpState.error,
              );
            }
          },
          builder: (context, state) {
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  void _showEditTaskDialog(BuildContext context, task) {
    final titleController = TextEditingController(text: task.title);
    final descriptionController = TextEditingController(text: task.description);

    AppBottomSheet.show(
      context: context,
      builder: (sheetContext) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Edit Task',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(sheetContext).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Text('Cancel', style: TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (titleController.text.trim().isEmpty) {
                        SnackBarPopUp().show(
                          context: sheetContext,
                          message: 'Title cannot be empty',
                          state: PopUpState.warning,
                        );
                        return;
                      }
                      Navigator.of(sheetContext).pop();
                      _editTask(
                        context,
                        task.id!,
                        titleController.text.trim(),
                        descriptionController.text.trim(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Text('Save', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _editTask(BuildContext context, int taskId, String title, String description) {
    final tasksCubit = GetTasksCubit.get(context);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => BlocProvider(
        create: (context) => EditTaskCubit()..editTask(taskId, title, description),
        child: BlocConsumer<EditTaskCubit, EditTaskState>(
          listener: (blocContext, state) async {
            if (state is EditTaskSuccessState) {
              Navigator.of(dialogContext).pop();
              SnackBarPopUp().show(
                context: context,
                message: 'Task updated successfully',
                state: PopUpState.success,
              );
              // Add slight delay to ensure backend has processed the update
              await Future.delayed(Duration(milliseconds: 300));
              tasksCubit.getTasks();
            } else if (state is EditTaskErrorState) {
              Navigator.of(dialogContext).pop();
              SnackBarPopUp().show(
                context: context,
                message: state.error,
                state: PopUpState.error,
              );
            }
          },
          builder: (context, state) {
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocProvider(
          create: (context) => GetUserCubit()..getusers(),
          child: BlocBuilder<GetUserCubit, GetUserState>(
            builder: (context, state) {
              if (state is GetUserSuccessState) {
                return Row(
                  children: [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: CachedNetworkImage(
                        imageUrl: state.users.imagePath ?? '',
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Welcome'),
                        Text(state.users.username ?? ''),
                      ],
                    ),
                  ],
                );
              } else if (state is GetUserLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GetUserErrorState) {
                // Fallback: keep the title simple if user fetch fails.
                return const Text('User');
              }
              return Container();
            },
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => GetTasksCubit()..getTasks(),
        child: Builder(
          builder: (context) {
            return RefreshIndicator(
              onRefresh: () async {
                GetTasksCubit.get(context).getTasks();
              },
              child: BlocBuilder<GetTasksCubit, GetTasksState>(
                builder: (context, state) {
                  if (state is GetTasksSuccessState) {
                    return ListView.separated(
                      padding: EdgeInsets.all(20),
                      itemBuilder: (context, index) => Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(155),
                              blurRadius: 10,
                              spreadRadius: 1,
                              offset: Offset.zero,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                child: CachedNetworkImage(
                                  imageUrl: state.tasks[index].imagePath ?? '',
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.tasks[index].title ?? '',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      state.tasks[index].description ?? '',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.edit, color: AppColors.primary),
                                onPressed: () {
                                  _showEditTaskDialog(
                                    context,
                                    state.tasks[index],
                                  );
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  _showDeleteConfirmation(
                                    context,
                                    state.tasks[index].id!,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 20),
                      itemCount: state.tasks.length,
                    );
                  } else if (state is GetTasksLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is GetTasksErrorState) {
                    return Center(child: Text(state.error));
                  }
                  return Container();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
