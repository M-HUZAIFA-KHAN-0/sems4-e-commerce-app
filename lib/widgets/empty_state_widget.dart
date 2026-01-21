import 'package:flutter/material.dart';

class EmptyStateWidget extends StatelessWidget {
  final String message;
  final IconData icon;
  final Color iconColor;
  final Color? backgroundColor;
  final double iconSize;
  final double containerSize;
  final double fontSize;
  final FontWeight fontWeight;

  const EmptyStateWidget({
    super.key,
    required this.message,
    required this.icon,
    required this.iconColor,
    this.backgroundColor,
    this.iconSize = 24,
    this.containerSize = 56,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w500,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: containerSize,
          height: containerSize,
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.grey[100],
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: iconSize),
        ),
        const SizedBox(height: 16),
        Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
