import 'package:flutter/material.dart';

class NoteBoxWidget extends StatelessWidget {
  final String message;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final IconData icon;
  final Color iconColor;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;

  const NoteBoxWidget({
    super.key,
    required this.message,
    this.backgroundColor = const Color.fromARGB(255, 255, 245, 230),
    this.textColor = const Color.fromARGB(255, 180, 116, 40),
    this.borderColor = const Color.fromARGB(255, 255, 152, 0),
    this.icon = Icons.info_outline,
    this.iconColor = Colors.orange,
    this.padding = const EdgeInsets.all(10),
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius ?? BorderRadius.circular(6),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: iconColor),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(fontSize: 12, color: textColor),
            ),
          ),
        ],
      ),
    );
  }
}
