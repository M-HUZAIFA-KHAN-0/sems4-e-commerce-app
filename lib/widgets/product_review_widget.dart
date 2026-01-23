import 'package:first/core/app_imports.dart';

class ProductReview extends StatelessWidget {
  final String name;
  final String? avatarInitials;
  final double rating; // 0.0 - 5.0
  final bool verified;
  final String? date; // display date
  final String? text;
  final List<String>? images; // asset paths or network URLs

  const ProductReview({
    super.key,
    required this.name,
    this.avatarInitials,
    required this.rating,
    this.verified = false,
    this.date,
    this.text,
    this.images,
  });

  Future<void> _openImageViewer(BuildContext context, int initialPage) async {
    if (images == null || images!.isEmpty) return;

    final controller = PageController(initialPage: initialPage);

    await showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'ImageViewer',
      pageBuilder: (ctx, a1, a2) {
        return GestureDetector(
          onTap: () => Navigator.of(ctx).pop(),
          child: Container(
            color: Colors.black.withOpacity(0.85),
            child: SafeArea(
              child: Stack(
                children: [
                  Center(
                    child: PageView.builder(
                      controller: controller,
                      itemCount: images!.length,
                      itemBuilder: (context, index) {
                        final src = images![index];
                        final isNetwork = src.startsWith('http');
                        final image = isNetwork
                            ? Image.network(src, fit: BoxFit.contain)
                            : Image.asset(src, fit: BoxFit.contain);
                        return InteractiveViewer(
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(12),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(ctx).size.width * 0.85,
                                maxHeight:
                                    MediaQuery.of(ctx).size.height * 0.75,
                              ),
                              child: image,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  Positioned(
                    right: 12,
                    top: 12,
                    child: IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: AppColors.backgroundWhite,
                        size: 28,
                      ),
                      onPressed: () => Navigator.of(ctx).pop(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (ctx, a1, a2, child) {
        final curved = Curves.easeInOut.transform(a1.value);
        return Transform.scale(scale: curved, child: child);
      },
      transitionDuration: const Duration(milliseconds: 250),
    );
  }

  Widget _buildStars() {
    final full = rating.floor();
    final half = (rating - full) >= 0.5;
    return Row(
      children: List<Widget>.generate(5, (i) {
        if (i < full) {
          return const Icon(Icons.star, color: Colors.amber, size: 16);
        }
        if (i == full && half) {
          return const Icon(Icons.star_half, color: Colors.amber, size: 16);
        }
        return const Icon(Icons.star_border, color: Colors.amber, size: 16);
      }),
    );
  }

  Widget _buildImage(
    BuildContext context,
    String src,
    int index,
    int displayIndex,
    int total,
  ) {
    final isNetwork = src.startsWith('http');
    final image = isNetwork
        ? Image.network(src, fit: BoxFit.cover)
        : Image.asset(src, fit: BoxFit.cover);

    Widget child = ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: SizedBox(width: 75, height: 75, child: image),
    );

    if (displayIndex == 3 && total > 4) {
      final remaining = total - 4;
      child = Stack(
        children: [
          child,
          Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.65),
              borderRadius: BorderRadius.circular(6),
            ),
            alignment: Alignment.center,
            child: Text(
              '+$remaining',
              style: const TextStyle(
                color: AppColors.backgroundWhite,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    }

    return GestureDetector(
      onTap: () => _openImageViewer(context, index),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CircleAvatar(
            //   radius: 22,
            //   backgroundColor: AppColors.backgroundGreyLight,
            //   child: Text(
            //     (avatarInitials ??
            //             name
            //                 .split(' ')
            //                 .map((s) => s.isNotEmpty ? s[0] : '')
            //                 .take(2)
            //                 .join())
            //         .toUpperCase(),
            //     style: const TextStyle(
            //       color: AppColors.textBlack,
            //       fontWeight: FontWeight.w600,
            //     ),
            //   ),
            // ),
            Container(
  width: 44, // radius 22 × 2
  height: 44,
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    gradient: AppColors.bgGradient, // ✅ gradient BG
  ),
  child: CircleAvatar(
    radius: 22,
    backgroundColor: Colors.transparent, // 👈 IMPORTANT
    child: Text(
      (avatarInitials ??
              name
                  .split(' ')
                  .map((s) => s.isNotEmpty ? s[0] : '')
                  .take(2)
                  .join())
          .toUpperCase(),
      style: const TextStyle(
        color: Colors.white, // gradient pe white zyada readable hota hai
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  _buildStars(),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (verified)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.verified, color: Colors.green, size: 18),
                      SizedBox(width: 4),
                    ],
                  ),
                if (date != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Text(
                      date!,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ),
              ],
            ),
          ],
        ),

        if (text != null && text!.trim().isNotEmpty) ...[
          const SizedBox(height: 12),
          Text(text!, style: TextStyle(color: Colors.grey[800], height: 1.4)),
        ],

        if (images != null && images!.isNotEmpty) ...[
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              for (var i = 0; i < images!.length && i < 4; i++)
                _buildImage(context, images![i], i, i, images!.length),
            ],
          ),
        ],

        const SizedBox(height: 16),
        const Divider(height: 1),
      ],
    );
  }
}
