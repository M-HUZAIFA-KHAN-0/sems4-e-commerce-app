import 'package:first/core/app_imports.dart';

class StepLineWidget extends StatelessWidget {
  final bool isActive;
  final Color activeColor;
  final Color inactiveColor;
  final double height;
  final EdgeInsets? margin;

  const StepLineWidget({
    super.key,
    required this.isActive,
    this.activeColor = AppColors.statusGreen,
    this.inactiveColor = AppColors.colorE0E0E0,
    this.height = 2,
    this.margin = const EdgeInsets.only(bottom: 18),
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: height,
        margin: margin,
        color: isActive ? activeColor : inactiveColor,
      ),
    );
  }
}
