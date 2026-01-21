import 'package:flutter/material.dart';
import '../app_colors.dart';

class PrimaryBtnWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final Color? backgroundColor;
  final double? height;
  final double? width;
  final double? fontSize;

  const PrimaryBtnWidget({
    super.key,
    required this.onPressed,
    this.buttonText = 'Add New Address',
    this.backgroundColor = AppColors.textBlack,
    this.height = 48,
    this.width,
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 48,
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
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w800,
            color: AppColors.backgroundWhite,
          ),
        ),
      ),
    );
  }
}
