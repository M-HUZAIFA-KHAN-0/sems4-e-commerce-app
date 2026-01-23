import 'package:first/core/app_imports.dart'; // AppColors import ke liye

class GradientIconWidget extends StatelessWidget {
  final IconData icon;
  final double size;

  /// Optional: default size 16
  const GradientIconWidget({
    super.key,
    required this.icon,
    this.size = 16,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return AppColors.bgGradient.createShader(
          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
        );
      },
      blendMode: BlendMode.srcIn,
      child: Icon(
        icon,
        size: size,
        color: Colors.white, // Gradient ke liye ye mandatory hai
      ),
    );
  }
}
