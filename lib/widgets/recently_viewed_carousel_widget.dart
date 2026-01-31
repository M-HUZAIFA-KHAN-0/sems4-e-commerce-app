import 'package:first/core/app_imports.dart';
import 'package:first/screens/product_detail_page.dart';

/// Model for Recently Viewed Product
class RecentlyViewedProduct {
  final String id;
  final String title;
  final String image;
  final double currentPrice;
  final double originalPrice;
  final double? discountPercent;

  RecentlyViewedProduct({
    required this.id,
    required this.title,
    required this.image,
    required this.currentPrice,
    required this.originalPrice,
    this.discountPercent,
  });
}

/// Recently Viewed Carousel Widget
class RecentlyViewedCarouselWidget extends StatefulWidget {
  final List<RecentlyViewedProduct> products;
  final VoidCallback? onViewMorePressed;

  const RecentlyViewedCarouselWidget({
    super.key,
    required this.products,
    this.onViewMorePressed,
  });

  @override
  State<RecentlyViewedCarouselWidget> createState() =>
      _RecentlyViewedCarouselWidgetState();
}

class _RecentlyViewedCarouselWidgetState
    extends State<RecentlyViewedCarouselWidget> {
  late PageController _pageController;
  Timer? _autoScrollTimer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 1.0);
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_pageController.hasClients && mounted) {
        _currentPage =
            (_currentPage + 1) % ((widget.products.length / 3).ceil());
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _autoScrollTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int totalPages = (widget.products.length / 3).ceil();

    return Column(
      children: [
        // Header with "Recently Viewed" and "View More"
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recently Viewed',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textBlack87,
                ),
              ),
              GestureDetector(
                onTap: widget.onViewMorePressed,
                child: Row(
                  children: [
                    const Text(
                      'View More',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: Colors.grey[500],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Carousel
        SizedBox(
          height: 178, // ✅ increased height to avoid bottom overflow
          child: widget.products.isEmpty
              ? Center(
                  child: Text(
                    'No products to display',
                    style: TextStyle(color: Colors.grey[400], fontSize: 14),
                  ),
                )
              : PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: totalPages,
                  itemBuilder: (context, pageIndex) {
                    final startIndex = pageIndex * 3;
                    final endIndex = (startIndex + 3).clamp(
                      0,
                      widget.products.length,
                    );
                    final pageProducts = widget.products.sublist(
                      startIndex,
                      endIndex,
                    );

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: Row(
                        children: List.generate(3, (cardIndex) {
                          return Expanded(
                            child: cardIndex < pageProducts.length
                                ? RecentlyViewedProductCard(
                                    product: pageProducts[cardIndex],
                                  )
                                : const SizedBox(),
                          );
                        }),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

/// Individual Product Card for Recently Viewed
class RecentlyViewedProductCard extends StatelessWidget {
  final RecentlyViewedProduct product;

  const RecentlyViewedProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                ProductDetailPage(productId: int.tryParse(product.id) ?? 0),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          // color: AppColors.backgroundWhite,
          gradient: AppColors.secondaryBGGradientColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              spreadRadius: 0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image Section with Discount Badge
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1.3, // ✅ auto-adjust height to width
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(8),
                    ),
                    child: Image.network(
                      product.image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          child: Icon(
                            Icons.image_not_supported,
                            color: Colors.grey[400],
                            size: 40,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // Discount Badge
                if (product.discountPercent != null)
                  Positioned(
                    top: 6,
                    left: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 3,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.textBlack,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '↓ ${product.discountPercent!.toStringAsFixed(0)}%',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: AppColors.backgroundWhite,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            // Product Details — Fixed height
            Padding(
              padding: const EdgeInsets.all(6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // 🔑 important
                children: [
                  Flexible(
                    child: Text(
                      product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(221, 32, 32, 32),
                        height: 1.1, // 👈 thoda safe
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Rs ${product.currentPrice.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textBlack,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Rs ${product.originalPrice.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[500],
                      decoration: TextDecoration.lineThrough,
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
