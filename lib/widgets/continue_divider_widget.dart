import 'package:flutter/material.dart';

class ContinueDividerWidget extends StatelessWidget {
  final String text;
  final Color dividerColor;
  final Color textColor;
  final double fontSize;

  const ContinueDividerWidget({
    super.key,
    required this.text,
    this.dividerColor = const Color(0xFFE7E9EE),
    this.textColor = const Color(0xFF9AA0A6),
    this.fontSize = 11,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(thickness: 1, height: 1, color: dividerColor)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              color: textColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(child: Divider(thickness: 1, height: 1, color: dividerColor)),
      ],
    );
  }
}
