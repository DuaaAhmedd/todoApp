import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'core/app_resources.dart';

class HomeScreen extends StatefulWidget {
  final String userName;

  const HomeScreen({
    super.key,
    this.userName = 'Ahmed Saber',
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> tasks = [];

  void _addTask() {
    // This will be called when FAB is pressed
    // For now, it's a placeholder for future implementation
    setState(() {
      // Add task logic will go here
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            _buildHeader(),
            
            // Content Section
            Expanded(
              child: tasks.isEmpty ? _buildEmptyState() : _buildTaskList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        backgroundColor: AppColors.primary,
        child: const Icon(
          Icons.add,
          color: AppColors.white,
          size: 32,
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          // Circular Avatar with flag image
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.grey[200],
            backgroundImage: const AssetImage('assets/flag.png'),
          ),
          const SizedBox(width: 16),
          // Greeting and User Name
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello!',
                style: AppFonts.lexendDeca(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: AppColors.fontColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.userName,
                style: AppFonts.lexendDeca(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Empty state illustration
            SvgPicture.asset(
              'assets/object3.svg',
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 32),
            // Empty state message
            Text(
              'There are no tasks yet, Press the button To add New Task',
              textAlign: TextAlign.center,
              style: AppFonts.lexendDeca(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.fontColor,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskList() {
    // Placeholder for when tasks exist
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            title: Text(tasks[index]['title'] ?? ''),
          ),
        );
      },
    );
  }
}
