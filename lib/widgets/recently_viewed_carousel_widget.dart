import 'package:flutter/material.dart';
import 'dart:async';

/// Model for Recently Viewed Product
class RecentlyViewedProduct {
  final String id;
  final String title;
  final String image;
  final double currentPrice;
  final double originalPrice;
  final double discountPercent;

  RecentlyViewedProduct({
    required this.id,
    required this.title,
    required this.image,
    required this.currentPrice,
    required this.originalPrice,
    required this.discountPercent,
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
  late Timer _autoScrollTimer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 1.0);
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
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
    _autoScrollTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int totalPages = (widget.products.length / 3).ceil();

    return Column(
      children: [
        // Header with "Recently Viewed" and "View More"
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recently Viewed',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
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
          height: 280,
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
                      padding: const EdgeInsets.symmetric(horizontal: 12),
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
        const SizedBox(height: 12),
        // Page Indicators
        if (totalPages > 1)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              totalPages,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _currentPage == index ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: _currentPage == index
                      ? const Color(0xFFFF4757)
                      : Colors.grey[300],
                ),
              ),
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
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
        children: [
          // Product Image Section with Discount Badge
          Stack(
            children: [
              // Product Image Container
              Container(
                height: 160,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  color: Colors.grey,
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
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
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF4757),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '↓ ${product.discountPercent.toStringAsFixed(0)}%',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Product Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Title
                  Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                      height: 1.3,
                    ),
                  ),
                  const Spacer(),
                  // Current Price
                  Text(
                    'Rs${product.currentPrice.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFFF4757),
                    ),
                  ),
                  const SizedBox(height: 2),
                  // Original Price (Strikethrough)
                  Text(
                    'Rs${product.originalPrice.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[500],
                      decoration: TextDecoration.lineThrough,
                    ),
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
