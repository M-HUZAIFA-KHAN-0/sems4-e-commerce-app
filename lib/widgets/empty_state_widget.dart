import 'package:first/core/app_imports.dart';

class EmptyStateWidget extends StatelessWidget {
  final IconData icon;
  final String emptyMessage;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final Color? iconColor;
  final double? iconSize;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;

  const EmptyStateWidget({
    super.key,
    required this.icon,
    required this.emptyMessage,
    required this.buttonText,
    required this.onButtonPressed,
    this.iconColor = AppColors.textGreyMedium,
    this.iconSize = 60,
    this.textColor = AppColors.textBlack111,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w500,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Icon(
                icon,
                size: iconSize,
                color: iconColor,
              ),
            ),

            // ),
            const SizedBox(height: 16),

            Text(
              emptyMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize,
                height: 1.35,
                color: textColor,
                fontWeight: fontWeight,
              ),
            ),

            const SizedBox(height: 25),

            PrimaryBtnWidget(
              buttonText: buttonText,
              onPressed: onButtonPressed,
            ),
          ],
        ),
      ),
    );
  }
}
