import 'package:first/core/app_imports.dart';

/// ✅ Widget = ONLY the horizontal image slider (no title / no extra text)
/// Parent page passes all content (images) into this widget.
class BrandImageSlider extends StatelessWidget {
  const BrandImageSlider({
    super.key,
    required this.images,
    this.height = 160,
    this.itemWidth = 190,
    this.borderRadius = 18,
    this.horizontalPadding = 24,
    this.itemSpacing = 18,
    this.onTap,
  });

  /// Pass ImageProviders from parent (AssetImage / NetworkImage / MemoryImage).
  final List<ImageProvider> images;

  final double height;
  final double itemWidth;
  final double borderRadius;
  final double horizontalPadding;
  final double itemSpacing;

  /// Optional: parent can handle tap if needed.
  final void Function(int index)? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        itemCount: images.length,
        separatorBuilder: (_, __) => SizedBox(width: itemSpacing),
        itemBuilder: (context, index) {
          final tile = ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: Image(
              image: images[index],
              width: itemWidth,
              height: height,
              fit: BoxFit.cover, // images should already include background like in SS
              filterQuality: FilterQuality.high,
            ),
          );

          if (onTap == null) return tile;

          return GestureDetector(
            onTap: () => onTap!(index),
            child: tile,
          );
        },
      ),
    );
  }
}
