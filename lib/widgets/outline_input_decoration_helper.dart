import 'package:first/core/app_imports.dart';

class OutlineInputDecorationHelper {
  /// Creates a standardized OutlineInputBorder with customizable styling
  static InputDecoration createInputDecoration({
    required String labelText,
    String? hintText,
    IconData? prefixIcon,
    IconData? suffixIcon,
    Color borderColor = AppColors.borderGrey,
    Color focusedBorderColor = AppColors.primaryBlue,
    Color labelColor = AppColors.textGreyMedium,
    Color hintColor = const Color(0xFFAAAAAA),
    double borderRadius = 8,
    double borderWidth = 1,
    double focusedBorderWidth = 2,
    EdgeInsets contentPadding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 12,
    ),
    bool isDense = false,
    Color? fillColor,
    bool filled = false,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      labelStyle: TextStyle(
        color: labelColor,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      hintStyle: TextStyle(color: hintColor, fontSize: 14),
      prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
      suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
      contentPadding: contentPadding,
      isDense: isDense,
      filled: filled,
      fillColor: fillColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: borderColor, width: borderWidth),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: borderColor, width: borderWidth),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(
          color: focusedBorderColor,
          width: focusedBorderWidth,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(color: AppColors.statusRed, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(color: AppColors.statusRed, width: 2),
      ),
    );
  }

  /// Creates a compact version for shorter text inputs
  static InputDecoration createCompactInputDecoration({
    required String labelText,
    String? hintText,
    IconData? prefixIcon,
    IconData? suffixIcon,
    Color borderColor = AppColors.borderGrey,
    Color focusedBorderColor = AppColors.primaryBlue,
    double borderRadius = 8,
  }) {
    return createInputDecoration(
      labelText: labelText,
      hintText: hintText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      borderColor: borderColor,
      focusedBorderColor: focusedBorderColor,
      borderRadius: borderRadius,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      isDense: true,
    );
  }

  /// Creates a style for search fields
  static InputDecoration createSearchInputDecoration({
    String labelText = 'Search',
    String? hintText,
    Color borderColor = AppColors.borderGrey,
    Color focusedBorderColor = AppColors.primaryBlue,
    double borderRadius = 24,
  }) {
    return createInputDecoration(
      labelText: labelText,
      hintText: hintText,
      prefixIcon: Icons.search,
      suffixIcon: Icons.clear,
      borderColor: borderColor,
      focusedBorderColor: focusedBorderColor,
      borderRadius: borderRadius,
      fillColor: AppColors.backgroundGrey,
      filled: true,
    );
  }
}
