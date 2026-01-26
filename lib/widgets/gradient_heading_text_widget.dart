import 'package:first/core/app_imports.dart';


class GradientText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final Gradient? gradient;

  /// New parameters for font size and weight
  final double fontSize;
  final FontWeight fontWeight;

  const GradientText({
    super.key,
    required this.text,
    this.textAlign,
    this.gradient,
    this.fontSize = FontSize.homePageTitle, // default font size
    this.fontWeight = FontWeight.bold, // default font weight
  });

  /// Default gradient
  static const LinearGradient _defaultGradient = LinearGradient(
    transform: GradientRotation(108 * 3.1415926535 / 180), // 108deg
    colors: [
      Color.fromRGBO(161, 78, 150, 1),
      Color.fromRGBO(10, 133, 185, 1),
    ],
    stops: [0.3264, 0.8233],
  );

  @override
  Widget build(BuildContext context) {
    final Gradient usedGradient = gradient ?? _defaultGradient;

    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => usedGradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: Colors.white, // color required for ShaderMask
        ),
      ),
    );
  }
}
