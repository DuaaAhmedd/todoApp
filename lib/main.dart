import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/splash_screen.dart';
import 'core/app_colors.dart';
import 'register.dart';
import 'login.dart';
import "let's start.dart";

void main() {
  runApp(MyApp());
}

// root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.backgroundColor,
            appBarTheme: AppBarTheme(
              backgroundColor: AppColors.backgroundColor,
            ),
            textTheme: GoogleFonts.lexendDecaTextTheme(),
            fontFamily: GoogleFonts.lexendDeca().fontFamily,
          ),

          home: LoginScreen(),
        );
      },
    );
  }
}
