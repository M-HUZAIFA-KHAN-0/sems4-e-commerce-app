import 'package:first/core/app_imports.dart';

class PaymentInputFieldWidget extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final InputDecoration? decoration;
  final int maxLines;
  final int minLines;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool obscureText;

  const PaymentInputFieldWidget({
    super.key,
    required this.labelText,
    this.hintText = '',
    this.controller,
    this.keyboardType = TextInputType.text,
    this.decoration,
    this.maxLines = 1,
    this.minLines = 1,
    this.validator,
    this.onChanged,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      minLines: minLines,
      onChanged: onChanged,
      obscureText: obscureText,
      decoration:
          decoration ??
          InputDecoration(
            labelText: labelText,
            hintText: hintText.isNotEmpty ? hintText : labelText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
    );
  }
}
