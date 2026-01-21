import 'package:flutter/material.dart';

class RadioTileWidget extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color activeBorderColor;
  final Color inactiveBorderColor;
  final Color activeCircleColor;

  const RadioTileWidget({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.activeBorderColor = Colors.blue,
    this.inactiveBorderColor = const Color(0xFFCECECE),
    this.activeCircleColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? activeBorderColor : inactiveBorderColor,
            width: isSelected ? 2 : 1,
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
              child: isSelected
                  ? Center(
                      child: CircleAvatar(
                        radius: 4,
                        backgroundColor: activeCircleColor,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
