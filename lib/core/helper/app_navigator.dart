import 'package:flutter/material.dart';

abstract class AppNavigator {
  static void goTo(
    BuildContext context,
    Widget distination, {
    bool replaceAll = false,
  }) {
    final route = MaterialPageRoute(builder: (context) => distination);
    if (replaceAll) {
      Navigator.pushAndRemoveUntil(context, route, (_) => false);
    } else {
      Navigator.push(context, route);
    }
  }
}
