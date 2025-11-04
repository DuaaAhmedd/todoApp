// TODO Implement this library.
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppColors {
  static const Color backgroundColor = Color(0xffF3F5F4);
  static const Color primary = Color(0xFF149954);
  static const Color white = Colors.white;
  static const Color fontColor = Color(0xFF6E6A7C);
}

abstract class AppFonts {
  static TextStyle lexendDeca({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
  }) {
    return GoogleFonts.lexendDeca(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }
}

abstract class AppInputDecoration {
  static InputDecoration inputDecoration({
    required String hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: AppFonts.lexendDeca(
        fontSize: 14,
        fontWeight: FontWeight.w200,
        color: AppColors.fontColor,
      ),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: AppColors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
    );
  }
}

abstract class AppButtonStyles {
  static ButtonStyle primaryButton({double? height, double borderRadius = 16}) {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      elevation: 6,
      shadowColor: AppColors.primary,
      minimumSize: height != null ? Size(double.infinity, height) : null,
    );
  }
}
