import 'package:cartgo/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomSnackBar {

  static void show(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
    Color backgroundColor = kSecondaryColor,
    Color textColor = kWhiteColor,
  }) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: textColor),
      ),
      duration: duration,
      backgroundColor: backgroundColor,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}