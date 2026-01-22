import 'package:first/core/app_imports.dart';

class CircleIconButtonWidget extends StatelessWidget {
  final IconData icon;
  final double size;
  final double containerSize;
  final Color backgroundColor;
  final Color iconColor;
  final VoidCallback? onTap;
  final double iconSize;

  const CircleIconButtonWidget({
    super.key,
    required this.icon,
    this.size = 42,
    this.containerSize = 42,
    this.backgroundColor = AppColors.textBlack,
    this.iconColor = AppColors.backgroundWhite,
    this.onTap,
    this.iconSize = 28,
  });

  @override
  Widget build(BuildContext context) {
    final widget = Container(
      width: containerSize,
      height: containerSize,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(containerSize / 2),
      ),
      child: Icon(icon, color: iconColor, size: iconSize),
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: widget);
    }

    return widget;
  }
}
