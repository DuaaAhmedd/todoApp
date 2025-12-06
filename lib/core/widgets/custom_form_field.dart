import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    required this.controller,
    required this.prefix,
    this.suffix,
    required this.hintText,
    this.validator,
    this.obscureText = false,
  });
  final TextEditingController controller;
  final Widget prefix;
  final Widget? suffix;
  final String hintText;
  final String? Function(String?)? validator;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefix: prefix,
        suffix: suffix,
        hintText: hintText,
      ),
    );
  }
}
