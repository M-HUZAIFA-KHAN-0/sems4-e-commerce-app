import 'package:first/core/app_imports.dart';

class NetworkImageWithFallbackWidget extends StatelessWidget {
  final String? imageUrl;
  final ImageProvider? imageProvider;
  final double width;
  final double height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final IconData fallbackIcon;
  final double iconSize;
  final Color iconColor;

  const NetworkImageWithFallbackWidget({
    super.key,
    this.imageUrl,
    this.imageProvider,
    this.width = 80,
    this.height = 80,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.backgroundColor,
    this.fallbackIcon = Icons.image_outlined,
    this.iconSize = 40,
    this.iconColor = AppColors.textGreyIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(8),
      child: Container(
        width: width,
        height: height,
        color: backgroundColor ?? Colors.grey[200],
        child: _buildImage(),
      ),
    );
  }

  Widget _buildImage() {
    if (imageProvider != null) {
      return Image(
        image: imageProvider!,
        fit: fit,
        filterQuality: FilterQuality.high,
      );
    }
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return Image.network(
        imageUrl!,
        fit: fit,
        filterQuality: FilterQuality.high,
        errorBuilder: (context, error, stackTrace) {
          return Center(
            child: Icon(fallbackIcon, color: iconColor, size: iconSize),
          );
        },
      );
    }
    return Center(
      child: Icon(fallbackIcon, color: iconColor, size: iconSize),
    );
  }
}
