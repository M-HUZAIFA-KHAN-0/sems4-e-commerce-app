import 'package:flutter/material.dart';

class FormLabelWidget extends StatelessWidget {
  final String label;
  final bool isRequired;
  final IconData? icon;
  final Color requiredColor;
  final Color labelColor;
  final double fontSize;
  final FontWeight fontWeight;
  final double spacing;
  final EdgeInsets margin;
  final TextAlign textAlign;

  const FormLabelWidget({
    super.key,
    required this.label,
    this.isRequired = false,
    this.icon,
    this.requiredColor = const Color(0xFFE53935),
    this.labelColor = const Color(0xFF333333),
    this.fontSize = 14,
    this.fontWeight = FontWeight.w600,
    this.spacing = 4,
    this.margin = const EdgeInsets.only(bottom: 8),
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 18, color: labelColor),
            SizedBox(width: spacing),
          ],
          Expanded(
            child: Text(
              label,
              textAlign: textAlign,
              style: TextStyle(
                color: labelColor,
                fontSize: fontSize,
                fontWeight: fontWeight,
              ),
            ),
          ),
          if (isRequired)
            Text(
              ' *',
              style: TextStyle(
                color: requiredColor,
                fontSize: fontSize,
                fontWeight: fontWeight,
              ),
            ),
        ],
      ),
    );
  }
}
