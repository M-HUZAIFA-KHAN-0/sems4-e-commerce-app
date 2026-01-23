import 'package:first/core/app_imports.dart';

enum ErrorType { error, success, warning, info }

class ErrorMessageBoxWidget extends StatelessWidget {
  final String message;
  final ErrorType type;
  final IconData? customIcon;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final VoidCallback? onDismiss;
  final double borderRadius;
  final EdgeInsets padding;
  final double iconSize;

  const ErrorMessageBoxWidget({
    super.key,
    required this.message,
    this.type = ErrorType.error,
    this.customIcon,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.onDismiss,
    this.borderRadius = 8,
    this.padding = const EdgeInsets.all(12),
    this.iconSize = 24,
  });

  Color _getBackgroundColor() {
    return backgroundColor ??
        switch (type) {
          ErrorType.error => const Color(0xFFFFEBEE),
          ErrorType.success => AppColors.statusGreenLight,
          ErrorType.warning => AppColors.statusOrangeLight,
          ErrorType.info => AppColors.statusBlueLight,
        };
  }

  Color _getTextColor() {
    return textColor ??
        switch (type) {
          ErrorType.error => const Color(0xFFC62828),
          ErrorType.success => AppColors.statusGreenDark,
          ErrorType.warning => AppColors.statusOrangeDark,
          ErrorType.info => const Color(0xFF1565C0),
        };
  }

  Color _getBorderColor() {
    return borderColor ??
        switch (type) {
          ErrorType.error => AppColors.red300,
          ErrorType.success => const Color(0xFF66BB6A),
          ErrorType.warning => const Color(0xFFFFA726),
          ErrorType.info => const Color(0xFF42A5F5),
        };
  }

  IconData _getIcon() {
    return customIcon ??
        switch (type) {
          ErrorType.error => Icons.error_outline,
          ErrorType.success => Icons.check_circle_outline,
          ErrorType.warning => Icons.warning_amber,
          ErrorType.info => Icons.info_outline,
        };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        border: Border.all(color: _getBorderColor(), width: 1.5),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        children: [
          Icon(_getIcon(), color: _getTextColor(), size: iconSize),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: _getTextColor(),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (onDismiss != null)
            GestureDetector(
              onTap: onDismiss,
              child: Icon(Icons.close, color: _getTextColor(), size: 20),
            ),
        ],
      ),
    );
  }
}
