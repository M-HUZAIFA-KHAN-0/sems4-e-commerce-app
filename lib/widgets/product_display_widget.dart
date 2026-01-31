import 'package:first/core/app_imports.dart';

class ProductDisplayWidget extends StatelessWidget {
  final List<Map<String, dynamic>> prodItems;
  final bool glassEffect; // optional for all cards

  const ProductDisplayWidget({
    super.key,
    required this.prodItems,
    this.glassEffect = false,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: prodItems.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 14,
        crossAxisSpacing: 8,
        childAspectRatio: 0.66,
      ),
      itemBuilder: (context, index) {
        return ProductCard(product: prodItems[index], glassEffect: glassEffect);
      },
    );
  }
}

class ProductCard extends StatefulWidget {
  final Map<String, dynamic> product;
  final bool glassEffect;

  const ProductCard({
    super.key,
    required this.product,
    this.glassEffect = false,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isFavorited = false;
  bool _isLoading = false;
  final WishlistService _wishlistService = WishlistService();

  @override
  void initState() {
    super.initState();
    _checkIfInWishlist();
  }

  Future<void> _checkIfInWishlist() async {
    // Only check if user is logged in and has wishlistId
    if (!UserSessionManager().isLoggedIn ||
        UserSessionManager().wishlistId == null) {
      return;
    }

    // try {
    //   final variantId = widget.product['variantId'] as int?;
    //   if (variantId == null) return;

    //   final isInWishlist = await _wishlistService.isInWishlist(
    //     wishlistId: UserSessionManager().wishlistId!,
    //     variantId: variantId,
    //   );

    //   if (mounted) {
    //     setState(() => _isFavorited = isInWishlist);
    //   }
    // } catch (e) {
    //   print('Error checking wishlist: $e');
    // }
  }

  Future<void> _toggleWishlist() async {
    // Check if user is logged in
    if (!UserSessionManager().isLoggedIn) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please login to add items to wishlist'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Check if wishlistId is available
    if (UserSessionManager().wishlistId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Wishlist not initialized. Please login again.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final userId = UserSessionManager().userId;
    // final variantId = widget.product['variantId'] as int?;

    // if (variantId == null) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text('Product variant not found'),
    //       backgroundColor: Colors.red,
    //     ),
    //   );
    //   return;
    // }

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User ID not found'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    // try {
    //   bool success;
    //   if (_isFavorited) {
    //     // Remove from wishlist
    //     success = await _wishlistService.removeFromWishlist(
    //       wishlistId: UserSessionManager().wishlistId!,
    //       variantId: variantId,
    //     );
    //   } else {
    //     // Add to wishlist (backend expects userId + variantId)
    //     success = await _wishlistService.addToWishlist(
    //       userId: userId,
    //       variantId: variantId,
    //     );
    //   }

    //   if (mounted) {
    //     if (success) {
    //       setState(() => _isFavorited = !_isFavorited);
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(
    //           content: Text(
    //             _isFavorited
    //                 ? '❤️ Added to Wishlist'
    //                 : '🗑️ Removed from Wishlist',
    //           ),
    //           backgroundColor: Colors.green,
    //           duration: const Duration(seconds: 2),
    //         ),
    //       );
    //     } else {
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         const SnackBar(
    //           content: Text('Failed to update wishlist'),
    //           backgroundColor: Colors.red,
    //         ),
    //       );
    //     }
    //   }
    // } catch (e) {
    //   print('Error toggling wishlist: $e');
    //   if (mounted) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(
    //         content: Text('Error updating wishlist'),
    //         backgroundColor: Colors.red,
    //       ),
    //     );
    //   }
    // } finally {
    //   if (mounted) {
    //     setState(() => _isLoading = false);
    //   }
    // }
  }

  String _formatDiscount(dynamic discount) {
    if (discount == null) return '';

    final value = discount.toString().trim();

    // Agar already % hai
    if (value.contains('%')) {
      return value;
    }

    // Warna % add karo
    return '$value%';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(product: widget.product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: widget.glassEffect
              ? AppColors.glassmorphismWhite
              : AppColors.productCardGrey,
          boxShadow: [
            BoxShadow(
              color: AppColors.glassmorphismBoxShadowBlack,
              blurRadius: 6,
            ),
          ],
          border: Border.all(
            // color: AppColors.glassmorphismBorderBlack,
            color: AppColors.glassmorphismBorderWhite,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            /// IMAGE + GLASS EFFECT
            AspectRatio(
              aspectRatio: 1.1,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Stack(
                  children: [
                    /// Background Image
                    Positioned.fill(
                      child: Image.network(
                        widget.product['productImage'] ??
                            // 'https://picsum.photos/200?3',
                            '',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppColors.formGrey96,
                            child: const Icon(Icons.image_not_supported),
                          );
                        },
                      ),
                    ),

                    /// FAVORITE BUTTON
                    Positioned(
                      top: 6,
                      right: 6,
                      child: GestureDetector(
                        onTap: _isLoading ? null : _toggleWishlist,
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColors.accentRed,
                                    ),
                                  ),
                                )
                              : Icon(
                                  _isFavorited
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: _isFavorited
                                      ? AppColors.accentRed
                                      : AppColors.textBlack,
                                  size: 20,
                                ),
                        ),
                      ),
                    ),

                    /// DISCOUNT TAG
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
                          '↓ ${_formatDiscount(widget.product['discountPercentage'])}',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.backgroundWhite,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// DETAILS
            Padding(
              padding: const EdgeInsets.fromLTRB(6, 4, 6, 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'reviews:',
                        style: TextStyle(
                          fontSize: 9,
                          color: AppColors.formGrey96,
                        ),
                      ),
                      const SizedBox(width: 2),
                      const Icon(Icons.star, size: 12, color: Colors.amber),
                      const SizedBox(width: 2),
                      Text(
                        '${widget.product['averageRating']?.toString() ?? '0'}',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.product['productName'] ?? 'Unknown Product',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
                  ),
                  Text(
                    'PKR ${widget.product['discountPrice']?.toString() ?? '0'}',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'PKR ${widget.product['originalPrice']?.toString() ?? '0'}',
                    style: const TextStyle(
                      fontSize: 9,
                      decoration: TextDecoration.lineThrough,
                      color: AppColors.textGrey,
                    ),
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
