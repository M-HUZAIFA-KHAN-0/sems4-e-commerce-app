import 'package:first/core/app_imports.dart';

class SocialIconButtonWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color borderColor;
  final double borderRadius;

  const SocialIconButtonWidget({
    super.key,
    required this.child,
    required this.onTap,
    this.width = 56,
    this.height = 44,
    this.backgroundColor = AppColors.backgroundWhite,
    this.borderColor = AppColors.borderGreyLighter,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: borderColor, width: 1),
        ),
        child: Center(child: child),
      ),
    );
  }
}
