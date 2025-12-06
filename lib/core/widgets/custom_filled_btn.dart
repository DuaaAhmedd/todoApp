import 'package:flutter/material.dart';
import '/core/utils/app_colors.dart';

class CustomFilledBtn extends StatelessWidget {
  const CustomFilledBtn({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final void Function()? onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w300,
            fontSize: 19,
          ),
        ),
      ),
    );
  }
}
