import 'package:first/core/app_imports.dart';
import 'package:flutter/services.dart';

class AuthField extends StatelessWidget {
  const AuthField({
    super.key,
    required this.hint,
    required this.controller,
    required this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.readOnly = false,
    this.inputFormatters,
  });

  final String hint;
  final TextEditingController controller;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;

  static const Color _fieldBg = Color(0xFFF3F4F6);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      readOnly: readOnly,
      inputFormatters: inputFormatters,
      style: TextStyle(
        fontSize: 12.5,
        fontWeight: FontWeight.w700,
        color: readOnly ? const Color(0xFF999999) : Colors.black,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: _fieldBg,
        hintText: hint,
        hintStyle: const TextStyle(
          fontSize: 12,
          color: Color(0xFFB0B6BE),
          fontWeight: FontWeight.w600,
        ),
        prefixIcon: Icon(prefixIcon, size: 18, color: Colors.black54),
        suffixIcon: suffixIcon == null
            ? null
            : InkWell(
                onTap: onSuffixTap,
                child: Icon(suffixIcon, size: 18, color: Colors.black45),
              ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12),
        ),
        errorStyle: const TextStyle(fontSize: 11, height: 1.1),
      ),
    );
  }
}
