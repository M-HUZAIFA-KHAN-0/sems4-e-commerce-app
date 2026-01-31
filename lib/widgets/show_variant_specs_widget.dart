import 'package:first/core/app_imports.dart';

class ShowVariantSpecsWidget extends StatelessWidget {
  final String variantText;
  final Color backgroundColor;

  const ShowVariantSpecsWidget({
    super.key,
    required this.variantText,
    this.backgroundColor = const Color(0xFFF0F0F0), // fallback light grey
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      decoration: BoxDecoration(
        color: const Color.fromARGB(120, 247, 247, 248),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1.5),
      child: Text(
        variantText,
        style: const TextStyle(
          fontSize: 10,
          color: AppColors.textGreyDark,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
