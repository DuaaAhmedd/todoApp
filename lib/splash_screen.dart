import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'core/app_resources.dart';
import 'start_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LetsStartScreen()),
      );
    });
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset('assets/objects.svg', width: 334, height: 343.94),
            SizedBox(height: 50),
            Text(
              'TODO',
              style: AppFonts.lexendDeca(
                fontSize: 36,
                fontWeight: FontWeight.w900,
                color: AppColors.primary,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
