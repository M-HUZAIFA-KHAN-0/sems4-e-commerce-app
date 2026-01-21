import 'package:flutter/material.dart';

class ImagePickerButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  final double width;
  final double height;
  final Color borderColor;
  final Color iconColor;
  final double iconSize;
  final BorderRadius? borderRadius;

  const ImagePickerButtonWidget({
    super.key,
    required this.onTap,
    this.width = double.infinity,
    this.height = 120,
    this.borderColor = const Color(0xFFE5E5E5),
    this.iconColor = const Color(0xFFA0A0A0),
    this.iconSize = 48,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 2),
          borderRadius: borderRadius ?? BorderRadius.circular(12),
          color: Colors.grey[50],
        ),
        child: Center(
          child: Icon(Icons.photo_library, size: iconSize, color: iconColor),
        ),
      ),
    );
  }
}
