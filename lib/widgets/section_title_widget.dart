import 'package:flutter/material.dart';

class SectionTitleWidget extends StatelessWidget {
  final String text;
  final EdgeInsets? padding;
  final TextStyle? textStyle;

  const SectionTitleWidget({
    super.key,
    required this.text,
    this.padding = const EdgeInsets.fromLTRB(16, 18, 16, 6),
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.fromLTRB(16, 18, 16, 6),
      child: Text(
        text,
        style:
            textStyle ??
            const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
      ),
    );
  }
}
