import 'package:cartgo/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SubmitBtn extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const SubmitBtn({
    super.key,
    required this.text,
    required this.onPressed,
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
      child: Text(
        widget.text,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}
