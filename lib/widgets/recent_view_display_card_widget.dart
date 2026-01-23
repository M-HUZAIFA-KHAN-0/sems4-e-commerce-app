import 'package:first/core/app_imports.dart';

class ProductCardGrid extends StatelessWidget {
  final List<ProductItem> items;

  const ProductCardGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(), // ✅ mobile scroll
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.70, // ✅ overflow fix
        crossAxisSpacing: 4,
        mainAxisSpacing: 7,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return ProductCard(
          item: item,
          onTap: item.onTap, // ✅ SAME AS BEFORE
        );
      },
    );
  }
}

class ProductItem {
  final String prodName;
  final String imageUrl;
  final String price;
  final String originalPrice;
  final String discount;
  final String? tag;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onHeartToggled;

  ProductItem({
    required this.prodName,
    required this.imageUrl,
    required this.price,
    required this.originalPrice,
    required this.discount,
    this.tag,
    this.onTap,
    this.onHeartToggled,
  });
}

class ProductCard extends StatefulWidget {
  final ProductItem item;
  final VoidCallback? onTap; // ✅ KEEP THIS

  const ProductCard({super.key, required this.item, this.onTap});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _favorited = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        // ✅ handles tap + scroll properly
        borderRadius: BorderRadius.circular(8),
        onTap: widget.onTap, // ✅ SAME CALLBACK
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// IMAGE AREA
            Expanded(
              // ✅ overflow fix
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(8),
                    ),
                    child: Image.network(
                      widget.item.imageUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  /// DISCOUNT
                  Positioned(
                    top: 6,
                    left: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.textBlack,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '↓ ${widget.item.discount}%',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.backgroundWhite,
                        ),
                      ),
                    ),
                  ),

                  /// HEART
                  Positioned(
                    top: 6,
                    right: 6,
                    child: InkWell(
                      onTap: () {
                        setState(() => _favorited = !_favorited);
                        widget.item.onHeartToggled?.call(_favorited);
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppColors.productCardBackgroundLight,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          _favorited ? Icons.favorite : Icons.favorite_border,
                          color: _favorited ? Colors.red : AppColors.textBlack,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// DETAILS
            Padding(
              padding: const EdgeInsets.all(6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.prodName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // const SizedBox(height: 2),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.item.price,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.item.originalPrice,
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.borderGreyLighter,
                          ),
                        ),
                        child: const Icon(Icons.add_shopping_cart, size: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
