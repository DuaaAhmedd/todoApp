import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'core/app_resources.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LetsStartScreen extends StatelessWidget {
  const LetsStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 100),
          child: Column(
            children: [
              // Illustration inside bordered box
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  //border: Border.all(color: const Color(0xFF2F80ED), width: 3),
                  //color: AppColors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: SvgPicture.asset(
                  'assets/OBJECTS012.svg',
                  width: 301.7.w,
                  height: 342.86.h,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Welcome To\nDo It !',
                textAlign: TextAlign.center,
                style: AppFonts.lexendDeca(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Ready to conquer your tasks? Let's Do\nit together.",
                textAlign: TextAlign.center,
                style: AppFonts.lexendDeca(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6D6D6D),
                  height: 1.5,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  onPressed: () {},
                  style: AppButtonStyles.primaryButton(),
                  child: Text(
                    "Let's Start",
                    style: AppFonts.lexendDeca(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
