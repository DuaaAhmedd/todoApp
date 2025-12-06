import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/utils/app_colors.dart';
import '/features/auth/data/models/user_model.dart';
import '/features/home/cubit/get_tasks_cubit/get_tsks_cubit.dart';
import '/features/home/cubit/get_tasks_cubit/get_tsks_state.dart';
import '/features/home/data/repo/home_repo.dart';
import '/features/home/cubit/get_user_cubit/get_user_cubit.dart';
import 'package:todo/features/home/cubit/get_user_cubit/get_user_state.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocProvider(
          create: (context) => GetUserCubit()..getusers(),
          child: BlocBuilder<GetUserCubit, GetUserState>(
            builder: (context, state) {
              if (state is GetUserSuccessState) {
                Row(
                  children: [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: CachedNetworkImage(
                        imageUrl: state.users.imagePath ?? '', //TODO

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
                return Center(child: CircularProgressIndicator());
              } else if (state is GetUserErrorState) {
                return Center(child: Text(state.error));
              }
              return Row();
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
                                  Text(state.tasks[index].title ?? ''),
                                  Text(state.tasks[index].description ?? ''),
                                ],
                              ),
                            ),
                          ],
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
