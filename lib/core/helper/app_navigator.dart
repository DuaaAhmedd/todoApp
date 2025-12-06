import 'package:flutter/material.dart';

abstract class AppNavigator {
  static void goTo(context, Widget distination) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => distination),
    );
  }
}
