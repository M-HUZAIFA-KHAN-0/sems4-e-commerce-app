import 'package:first/core/app_imports.dart';
import 'package:first/screens/recent_view_more_page.dart';
import 'package:first/services/api/product_view_service.dart';
import 'package:first/screens/product_detail_page.dart';

class RecentViewsCarousel extends StatefulWidget {
  final Function(int productId)? onProductTap;

  const RecentViewsCarousel({super.key, this.onProductTap});

  @override
  State<RecentViewsCarousel> createState() => _RecentViewsCarouselState();
}

class _RecentViewsCarouselState extends State<RecentViewsCarousel> {
  final ProductViewService _viewService = ProductViewService();

  bool _isLoading = true;
  List<ProductViewDTO> _recentViews = [];

  @override
  void initState() {
    super.initState();
    _loadRecentViews();
  }

  Future<void> _loadRecentViews() async {
    try {
      final views = await _viewService.getAllProductViews();
      if (views == null) {
        if (!mounted) return;
        setState(() => _isLoading = false);
        return;
      }

      // Get non-discounted recent views (limit 10 for carousel)
      final recentNonDiscounted = _viewService.getRecentNonDiscountedViews(
        views,
        limit: 10,
      );

      if (!mounted) return;
      setState(() {
        _recentViews = recentNonDiscounted;
        _isLoading = false;
      });

      print('🎠 Loaded ${_recentViews.length} recent non-discounted products');
    } catch (e) {
      print('❌ Error loading recent views: $e');
      if (!mounted) return;
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        height: 220,
        color: AppColors.backgroundWhite,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_recentViews.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title and More button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recently Viewed',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textBlack87,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const RecentViewMorePage(),
                    ),
                  );
                },
                child: Text(
                  'View More →',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondaryColor1,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Carousel
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: _recentViews.length,
            itemBuilder: (context, index) {
              final product = _recentViews[index];
              return _buildCarouselCard(product);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCarouselCard(ProductViewDTO product) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                ProductDetailPage(productId: product.productId),
          ),
        );
      },
      child: Container(
        width: 150,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderGreyLighter),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.backgroundGreyLighter,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child:
                    product.productImage != null &&
                        product.productImage!.isNotEmpty
                    ? ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                        child: Image.network(
                          product.productImage!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.image_not_supported);
                          },
                        ),
                      )
                    : const Icon(Icons.image_not_supported),
              ),
            ),
            // Product Info
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.productName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textBlack87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'PKR ${product.discountPrice.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: AppColors.textBlack87,
                    ),
                  ),
                  if (product.originalPrice > 0 &&
                      product.originalPrice != product.discountPrice)
                    Text(
                      'PKR ${product.originalPrice.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 10,
                        decoration: TextDecoration.lineThrough,
                        color: AppColors.textGreyLabel,
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
