import 'package:flutter/material.dart';

class PrimaryBtnWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final Color? backgroundColor;

  const PrimaryBtnWidget({
    super.key,
    required this.onPressed,
    this.buttonText = 'Add New Address',
    this.backgroundColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
          elevation: 0,
        ),
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}