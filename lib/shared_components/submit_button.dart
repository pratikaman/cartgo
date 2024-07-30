import 'package:cartgo/constants/app_sizes.dart';
import 'package:cartgo/constants/colors.dart';
import 'package:flutter/material.dart';


// A custom button widget that can show a loading indicator
class SubmitBtn extends StatefulWidget {

  /// The text to display on the button
  final String text;
  /// Whether to show a loading indicator
  final bool isInProgress;
  /// The function to call when the button is pressed
  final VoidCallback onPressed;

  const SubmitBtn({
    super.key,
    required this.text,
    required this.onPressed,
    required this.isInProgress,
  });

  @override
  State<SubmitBtn> createState() => _SubmitBtnState();
}

class _SubmitBtnState extends State<SubmitBtn> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

      ///
      onPressed: widget.onPressed,

      ///
      style: ElevatedButton.styleFrom(
        backgroundColor: kPrimaryColor,
        padding: const EdgeInsets.symmetric(
          horizontal: 100,
          vertical: 20,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.p8),
        ),
      ),

      ///
      child: widget.isInProgress
          ? const CircularProgressIndicator(color: kWhiteColor)
          : Text(
              widget.text,
              style: const TextStyle(
                fontSize: Sizes.p20,
                color: Colors.white,
              ),
            ),
    );
  }
}
