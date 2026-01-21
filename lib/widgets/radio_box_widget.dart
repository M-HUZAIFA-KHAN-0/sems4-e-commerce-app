import 'package:flutter/material.dart';

class RadioBoxWidget extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;
  final Color activeBorderColor;
  final Color inactiveBorderColor;
  final Color activeCircleColor;
  final EdgeInsets? padding;

  const RadioBoxWidget({
    super.key,
    required this.title,
    required this.isActive,
    required this.onTap,
    this.activeBorderColor = Colors.blue,
    this.inactiveBorderColor = const Color(0xFFCECECE),
    this.activeCircleColor = Colors.blue,
    this.padding = const EdgeInsets.all(14),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: padding,
        decoration: BoxDecoration(
          border: Border.all(
            color: isActive ? activeBorderColor : inactiveBorderColor,
            width: isActive ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: activeCircleColor),
              ),
              child: isActive
                  ? Center(
                      child: CircleAvatar(
                        radius: 4,
                        backgroundColor: activeCircleColor,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
