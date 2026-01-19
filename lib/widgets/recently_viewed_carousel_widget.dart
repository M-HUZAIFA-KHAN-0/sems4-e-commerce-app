// import 'package:flutter/material.dart';
// import 'dart:async';

// /// Model for Recently Viewed Product
// class RecentlyViewedProduct {
//   final String id;
//   final String title;
//   final String image;
//   final double currentPrice;
//   final double originalPrice;
//   final double? discountPercent;

//   RecentlyViewedProduct({
//     required this.id,
//     required this.title,
//     required this.image,
//     required this.currentPrice,
//     required this.originalPrice,
//     this.discountPercent,
//   });
// }

// /// Recently Viewed Carousel Widget
// class RecentlyViewedCarouselWidget extends StatefulWidget {
//   final List<RecentlyViewedProduct> products;
//   final VoidCallback? onViewMorePressed;

//   const RecentlyViewedCarouselWidget({
//     super.key,
//     required this.products,
//     this.onViewMorePressed,
//   });

//   @override
//   State<RecentlyViewedCarouselWidget> createState() =>
//       _RecentlyViewedCarouselWidgetState();
// }

// class _RecentlyViewedCarouselWidgetState
//     extends State<RecentlyViewedCarouselWidget> {
//   late PageController _pageController;
//   late Timer _autoScrollTimer;
//   int _currentPage = 0;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(viewportFraction: 1.0);
//     _startAutoScroll();
//   }

//   void _startAutoScroll() {
//     _autoScrollTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
//       if (_pageController.hasClients && mounted) {
//         _currentPage =
//             (_currentPage + 1) % ((widget.products.length / 3).ceil());
//         _pageController.animateToPage(
//           _currentPage,
//           duration: const Duration(milliseconds: 600),
//           curve: Curves.easeInOut,
//         );
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     _autoScrollTimer.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final int totalPages = (widget.products.length / 3).ceil();

//     return Column(
//       children: [
//         // Header with "Recently Viewed" and "View More"
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 'Recently Viewed',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black87,
//                 ),
//               ),
//               GestureDetector(
//                 onTap: widget.onViewMorePressed,
//                 child: Row(
//                   children: [
//                     const Text(
//                       'View More',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.grey,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     const SizedBox(width: 4),
//                     Icon(
//                       Icons.arrow_forward_ios,
//                       size: 12,
//                       color: Colors.grey[500],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 8),
//         // Carousel
//         SizedBox(
//           height: 165,
//           child: widget.products.isEmpty
//               ? Center(
//                   child: Text(
//                     'No products to display',
//                     style: TextStyle(color: Colors.grey[400], fontSize: 14),
//                   ),
//                 )
//               : PageView.builder(
//                   controller: _pageController,
//                   onPageChanged: (index) {
//                     setState(() {
//                       _currentPage = index;
//                     });
//                   },
//                   itemCount: totalPages,
//                   itemBuilder: (context, pageIndex) {
//                     final startIndex = pageIndex * 3;
//                     final endIndex = (startIndex + 3).clamp(
//                       0,
//                       widget.products.length,
//                     );
//                     final pageProducts = widget.products.sublist(
//                       startIndex,
//                       endIndex,
//                     );

//                     return Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 7),
//                       child: Row(
//                         children: List.generate(3, (cardIndex) {
//                           return Expanded(
//                             child: cardIndex < pageProducts.length
//                                 ? RecentlyViewedProductCard(
//                                     product: pageProducts[cardIndex],
//                                   )
//                                 : const SizedBox(),
//                           );
//                         }),
//                       ),
//                     );
//                   },
//                 ),
//         ),
//       ],
//     );
//   }
// }

// /// Individual Product Card for Recently Viewed
// class RecentlyViewedProductCard extends StatelessWidget {
//   final RecentlyViewedProduct product;

//   const RecentlyViewedProductCard({super.key, required this.product});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 3),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(7),
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 8,
//             spreadRadius: 0,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           // Product Image Section with Discount Badge
//           Stack(
//             children: [
//               // Product Image Container
//               Container(
//                 height: 90,
//                 width: double.infinity,
//                 decoration: const BoxDecoration(
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
//                   color: Colors.grey,
//                 ),
//                 child: ClipRRect(
//                   borderRadius: const BorderRadius.vertical(
//                     top: Radius.circular(8),
//                   ),
//                   child: Image.network(
//                     product.image,
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) {
//                       return Container(
//                         color: Colors.grey[200],
//                         child: Icon(
//                           Icons.image_not_supported,
//                           color: Colors.grey[400],
//                           size: 40,
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//               // Discount Badge
//               if (product.discountPercent != null)
//                 Positioned(
//                   top: 6,
//                   left: 6,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 3,
//                       vertical: 1,
//                     ),
//                     decoration: BoxDecoration(
//                       color: const Color.fromARGB(255, 0, 0, 0),
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                     child: Text(
//                       '↓ ${product.discountPercent!.toStringAsFixed(0)}%',
//                       style: const TextStyle(
//                         fontSize: 10,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//           // Product Details
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(7),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Product Title
//                   Text(
//                     product.title,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(
//                       fontSize: 10,
//                       fontWeight: FontWeight.w500,
//                       color: Color.fromARGB(221, 32, 32, 32),
//                       height: 1,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   // Current Price
//                   Text(
//                     'Rs${product.currentPrice.toStringAsFixed(0)}',
//                     style: const TextStyle(
//                       fontSize: 11.5,
//                       fontWeight: FontWeight.w700,
//                       color: Color.fromARGB(255, 0, 0, 0),
//                     ),
//                   ),
//                   // const SizedBox(height: 2),
//                   // Original Price (Strikethrough)
//                   Text(
//                     'Rs${product.originalPrice.toStringAsFixed(0)}',
//                     style: TextStyle(
//                       fontSize: 10,
//                       fontWeight: FontWeight.w400,
//                       color: Colors.grey[500],
//                       decoration: TextDecoration.lineThrough,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }














































import 'package:flutter/material.dart';
import 'dart:async';

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
          height: 185, // ✅ increased height to avoid bottom overflow
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image Section with Discount Badge
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 1.3, // ✅ auto-adjust height to width
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(8)),
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
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '↓ ${product.discountPercent!.toStringAsFixed(0)}%',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          // Product Details — Fixed height
          SizedBox(
            height: 70, // ✅ ensures bottom overflow doesn't happen
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(221, 32, 32, 32),
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Rs${product.currentPrice.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    'Rs${product.originalPrice.toStringAsFixed(0)}',
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
          ),
        ],
      ),
    );
  }
}
