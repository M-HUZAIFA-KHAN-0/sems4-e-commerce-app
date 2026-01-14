import 'package:flutter/material.dart';

class ProductCardGrid extends StatelessWidget {
  final List<ProductItem> items;

  const ProductCardGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      // physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.82,
        crossAxisSpacing: 2,
        mainAxisSpacing: 4,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return ProductCard(item: item, onTap: item.onTap);
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
  final VoidCallback? onTap;

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: widget.item.onTap,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(8),
                  ),
                  child: Image.network(
                    widget.item.imageUrl,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                if (widget.item.discount != null)
                  Positioned(
                    top: 6,
                    left: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 3,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '↓ ${widget.item.discount}%',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                Positioned(
  top: 6,
  right: 6,
  child: Container(
    width: 32,
    height: 32,
    decoration: BoxDecoration(
      color: const Color(0xFFF2F3FA), // 👈 BG same as border color
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: const Color(0xFFF2F3FA)),
    ),
    child: Center( // 👈 ensures icon is centered
      child: GestureDetector(
        onTap: () {
          setState(() => _favorited = !_favorited);
          widget.item.onHeartToggled?.call(_favorited);
        },
        child: Icon(
          _favorited ? Icons.favorite : Icons.favorite_border,
          color: _favorited ? Colors.red : const Color.fromARGB(255, 0, 0, 0),
          size: 25, // 👈 adjust size to fit nicely
        ),
      ),
    ),
  ),
)

              ],
            ),
          ),
          const SizedBox(height: 6),
          GestureDetector(
            onTap: widget.item.onTap,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(6.0, 0, 6.0, 6),
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
                      color: Colors.black,
                      height: 1,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.item.price,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              widget.item.originalPrice,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // Handle add to cart action
                        },
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xFFE7E9EE)),
                          ),
                          child: const Icon(Icons.add_shopping_cart),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
