import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/utils/app_colors.dart';
import '/features/auth/data/models/user_model.dart';
import '/features/home/cubit/get_tasks_cubit/get_tsks_cubit.dart';
import '/features/home/cubit/get_tasks_cubit/get_tsks_state.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocProvider(
          create: (context) => GetUserModel(),
          child: Row(
            children: [
              SizedBox(
                height: 50,
                width: 50,
                child: CachedNetworkImage(
                  // imageUrl: user.imagePath??'', TODO
                  imageUrl: '',
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome'),
                  // Text(user.username??''), TODO
                ],
              ),
            ],
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
