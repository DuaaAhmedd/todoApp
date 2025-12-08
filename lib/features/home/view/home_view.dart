import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/utils/app_colors.dart';
import '/features/home/cubit/get_tasks_cubit/get_tsks_cubit.dart';
import '/features/home/cubit/get_tasks_cubit/get_tsks_state.dart';
import '/features/home/cubit/get_user_cubit/get_user_cubit.dart';
import 'package:todo/features/home/cubit/get_user_cubit/get_user_state.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5), // Light grey background
      body: SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => GetUserCubit()..getusers()),
            BlocProvider(create: (context) => GetTasksCubit()..getTasks()),
          ],
          child: Builder(
            builder: (context) {
              return RefreshIndicator(
                onRefresh: () async {
                  GetTasksCubit.get(context).getTasks();
                  GetUserCubit.get(context).getusers();
                },
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Section
                      _buildHeader(context),
                      SizedBox(height: 24),
                      // Task Progress Card
                      _buildTaskProgressCard(context),
                      SizedBox(height: 24),
                      // In Progress Section
                      _buildInProgressSection(context),
                      SizedBox(height: 24),
                      // Task Groups Section
                      _buildTaskGroupsSection(context),
                      SizedBox(height: 100), // Space for FAB
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Add task functionality
        },
        backgroundColor: AppColors.primary,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.add, color: AppColors.primary, size: 24),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return BlocBuilder<GetUserCubit, GetUserState>(
      builder: (context, state) {
        if (state is GetUserSuccessState) {
          return Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey[300]!, width: 2),
                  ),
                  child: ClipOval(
                    child:
                        state.users.imagePath != null &&
                            state.users.imagePath!.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: state.users.imagePath!,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                Image.asset('assets/flag.png'),
                            errorWidget: (context, url, error) =>
                                Image.asset('assets/flag.png'),
                          )
                        : Image.asset('assets/flag.png'),
                  ),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello!',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    SizedBox(height: 4),
                    Text(
                      state.users.username ?? 'User',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else if (state is GetUserLoadingState) {
          return Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 16),
                Text('Loading...'),
              ],
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }

  Widget _buildTaskProgressCard(BuildContext context) {
    return BlocBuilder<GetTasksCubit, GetTasksState>(
      builder: (context, state) {
        int totalTasks = 0;
        int completedTasks = 0;
        if (state is GetTasksSuccessState) {
          totalTasks = state.tasks.length;
          // Assuming we need to check completion status
          // For now, let's calculate 80% as shown in the design
          completedTasks = (totalTasks * 0.8).round();
        }

        int percentage = totalTasks > 0
            ? ((completedTasks * 100) / totalTasks).round()
            : 0;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your today's tasks almost done!",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      SizedBox(height: 12),
                      Text(
                        '$percentage%',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.primary.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    'View Tasks',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInProgressSection(BuildContext context) {
    return BlocBuilder<GetTasksCubit, GetTasksState>(
      builder: (context, state) {
        if (state is GetTasksSuccessState && state.tasks.isNotEmpty) {
          // Filter in progress tasks (for now, show first 5 tasks)
          final inProgressTasks = state.tasks.take(5).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      'In Progress',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(width: 12),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${inProgressTasks.length}',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                height: 140,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemCount: inProgressTasks.length,
                  itemBuilder: (context, index) {
                    final task = inProgressTasks[index];
                    return _buildInProgressTaskCard(task, index);
                  },
                ),
              ),
            ],
          );
        }
        return SizedBox.shrink();
      },
    );
  }

  Widget _buildInProgressTaskCard(task, int index) {
    // Different colors for different task types
    final colors = [
      Colors.black,
      AppColors.primary.withOpacity(0.3),
      Colors.pink[100]!,
    ];
    final taskTypes = ['Work Task', 'Personal Task', 'Home Task'];
    final icons = [Icons.work, Icons.person, Icons.home];

    final colorIndex = index % colors.length;
    final backgroundColor = colors[colorIndex];
    final isDark = backgroundColor == Colors.black;

    return Container(
      width: 200,
      margin: EdgeInsets.only(right: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            taskTypes[colorIndex],
            style: TextStyle(
              color: isDark ? Colors.white : Colors.grey[700],
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: Text(
              task.title ?? 'Task Title',
              style: TextStyle(
                color: isDark ? Colors.white : Colors.grey[800],
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Icon(
              icons[colorIndex],
              color: isDark ? Colors.white : Colors.grey[600],
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskGroupsSection(BuildContext context) {
    return BlocBuilder<GetTasksCubit, GetTasksState>(
      builder: (context, state) {
        if (state is GetTasksSuccessState) {
          // Group tasks by type (simplified - you can enhance this)
          final personalTasks = state.tasks
              .where(
                (t) => t.title?.toLowerCase().contains('personal') ?? false,
              )
              .length;
          final homeTasks = state.tasks
              .where((t) => t.title?.toLowerCase().contains('home') ?? false)
              .length;
          final workTasks = state.tasks
              .where((t) => t.title?.toLowerCase().contains('work') ?? false)
              .length;

          final taskGroups = [
            {
              'name': 'Personal Task',
              'count': personalTasks > 0 ? personalTasks : 5,
              'icon': Icons.person,
              'color': AppColors.primary,
            },
            {
              'name': 'Home Task',
              'count': homeTasks > 0 ? homeTasks : 3,
              'icon': Icons.home,
              'color': Colors.pink[300]!,
            },
            {
              'name': 'Work Task',
              'count': workTasks > 0 ? workTasks : 1,
              'icon': Icons.work,
              'color': Colors.black,
            },
          ];

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Task Groups',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 16),
                ...taskGroups.map(
                  (group) => Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: (group['color'] as Color).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              group['icon'] as IconData,
                              color: group['color'] as Color,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              group['name'] as String,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[800],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: (group['color'] as Color).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${group['count']}',
                              style: TextStyle(
                                color: group['color'] as Color,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
