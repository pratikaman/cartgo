import 'package:cartgo/constants/app_sizes.dart';
import 'package:cartgo/constants/colors.dart';
import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

class SubmitBtn extends StatefulWidget {
  final String text;
  final bool isInProgress;
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
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: kPrimaryColor,
        padding: const EdgeInsets.symmetric(
          horizontal: 100,
          vertical: 20,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: widget.isInProgress
          ? const CircularProgressIndicator(color: kWhiteColor)
          : Text(
              widget.text,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
    );
  }
}
