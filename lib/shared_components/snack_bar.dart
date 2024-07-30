import 'package:cartgo/constants/colors.dart';
import 'package:flutter/material.dart';



/// A utility class for displaying custom snackbars in the app.
class CustomSnackBar {


  /// Displays a snackbar with customizable properties.
  ///
  /// [context] is the BuildContext where the snackbar will be shown.
  /// [message] is the text to be displayed in the snackbar.
  /// [duration] is how long the snackbar will be visible (default: 3 seconds).
  /// [backgroundColor] is the background color of the snackbar (default: kSecondaryColor).
  /// [textColor] is the color of the text in the snackbar (default: kWhiteColor).
  static void show(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
    Color backgroundColor = kSecondaryColor,
    Color textColor = kWhiteColor,
  }) {

    /// Create a SnackBar with the specified properties
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: textColor),
      ),
      duration: duration,
      backgroundColor: backgroundColor,
    );

    /// Display the snackbar using the ScaffoldMessenger
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}