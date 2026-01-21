import 'package:flutter/material.dart';

class EmptyTabStateWidget extends StatelessWidget {
  final String message;
  final IconData icon;
  final Color? iconColor;
  final double iconSize;
  final double verticalPadding;
  final TextStyle? messageStyle;

  const EmptyTabStateWidget({
    super.key,
    required this.message,
    this.icon = Icons.inbox_outlined,
    this.iconColor,
    this.iconSize = 48,
    this.verticalPadding = 40,
    this.messageStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: verticalPadding),
        child: Column(
          children: [
            Icon(icon, size: iconSize, color: iconColor ?? Colors.grey[300]),
            const SizedBox(height: 12),
            Text(
              message,
              style:
                  messageStyle ??
                  TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
