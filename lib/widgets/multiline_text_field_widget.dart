import 'package:first/core/app_imports.dart';

class MultilineTextFieldWidget extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final int maxLines;
  final int minLines;
  final IconData? prefixIcon;
  final InputDecoration? decoration;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputType keyboardType;
  final Color borderColor;
  final Color focusedBorderColor;
  final double borderRadius;
  final EdgeInsets contentPadding;

  const MultilineTextFieldWidget({
    super.key,
    required this.labelText,
    this.hintText = '',
    this.controller,
    this.maxLines = 5,
    this.minLines = 3,
    this.prefixIcon,
    this.decoration,
    this.validator,
    this.onChanged,
    this.keyboardType = TextInputType.multiline,
    this.borderColor = AppColors.borderGrey,
    this.focusedBorderColor = AppColors.primaryBlue,
    this.borderRadius = 8,
    this.contentPadding = const EdgeInsets.all(12),
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      minLines: minLines,
      onChanged: onChanged,
      decoration:
          decoration ??
          OutlineInputDecorationHelper.createInputDecoration(
            labelText: labelText,
            hintText: hintText.isNotEmpty ? hintText : labelText,
            prefixIcon: prefixIcon,
            borderColor: borderColor,
            focusedBorderColor: focusedBorderColor,
            borderRadius: borderRadius,
            contentPadding: contentPadding,
          ),
    );
  }
}
