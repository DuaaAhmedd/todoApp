import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'core/app_resources.dart';

class HomeScreen extends StatelessWidget {
  final String userName;

  const HomeScreen({
    super.key,
    this.userName = 'Ahmed Saber',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            _buildHeader(),
            
            // Empty State Section
            Expanded(
              child: _buildEmptyState(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
                userName,
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
              'There are no tasks yet, press the button to add a new task',
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
}
