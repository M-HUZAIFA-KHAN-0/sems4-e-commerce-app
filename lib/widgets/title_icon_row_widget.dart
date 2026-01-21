import 'package:flutter/material.dart';

class TitleIconRowWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color iconColor;
  final TextStyle? titleStyle;

  const TitleIconRowWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.iconColor = const Color(0xFF2196F3),
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style:
                titleStyle ??
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Icon(icon, color: iconColor),
        ),
      ],
    );
  }
}
