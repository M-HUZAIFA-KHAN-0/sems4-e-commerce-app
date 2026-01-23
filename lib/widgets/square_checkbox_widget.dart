import 'package:first/core/app_imports.dart';

class SquareCheckboxWidget extends StatelessWidget {
  final bool isChecked;
  final double size;
  final Color checkedColor;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;

  const SquareCheckboxWidget({
    super.key,
    required this.isChecked,
    this.size = 14,
    this.checkedColor = AppColors.textBlack,
    this.borderColor = AppColors.textBlack,
    this.borderWidth = 1.2,
    this.borderRadius = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: isChecked ? checkedColor : AppColors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor, width: borderWidth),
      ),
      child: isChecked
          ? Icon(
              Icons.check,
              size: size * 0.85,
              color: AppColors.backgroundWhite,
            )
          : null,
    );
  }
}
