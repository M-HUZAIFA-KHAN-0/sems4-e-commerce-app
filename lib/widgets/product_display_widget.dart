// import 'package:first/core/app_imports.dart';

// class ProductDisplayWidget extends StatelessWidget {
//   final List<Map<String, dynamic>> cars;

//   const ProductDisplayWidget({super.key, required this.cars});

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: cars.length,
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         mainAxisSpacing: 14,
//         crossAxisSpacing: 8,
//         childAspectRatio: 0.66,
//       ),
//       itemBuilder: (context, index) {
//         return ProductDisplayWidget(car: cars[index]); // 👈 SAME AS BEFORE
//       },
//     );
//   }
// }

// /// 🔴 NAME SAME — ProductDisplayWidget
// /// 🔴 CONSTRUCTOR SAME — ProductDisplayWidget({required this.car})
// class ProductDisplayWidget extends StatefulWidget {
//   final Map<String, dynamic> car;

//   const ProductDisplayWidget({super.key, required this.car});

//   @override
//   State<ProductDisplayWidget> createState() => _ProductDisplayWidgetState();
// }

// class _ProductDisplayWidgetState extends State<ProductDisplayWidget> {
//   bool _favorited = false;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ProductDetailPage(product: widget.car),
//           ),
//         );
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12),
//           color: AppColors.ProductDisplayWidgetGrey,
//           boxShadow: [
//             BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 5),
//           ],
//         ),
//         child: Column(
//           children: [
//             /// IMAGE — flexible (NO FIXED HEIGHT)
//             AspectRatio(
//               aspectRatio: 1.1, // ✅ auto height based on width
//               child: Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: widget.car['color'],
//                   borderRadius: const BorderRadius.vertical(
//                     top: Radius.circular(12),
//                   ),
//                 ),
//                 child: Stack(
//                   children: [
//                     Center(
//                       child: Icon(
//                         widget.car['image'],
//                         size: 80,
//                         color: Colors.grey[400],
//                       ),
//                     ),

//                     /// FAVORITE
//                     Positioned(
//                       top: 6,
//                       right: 6,
//                       child: GestureDetector(
//                         onTap: () {
//                           setState(() => _favorited = !_favorited);
//                         },
//                         child: Container(
//                           width: 32,
//                           height: 32,
//                           decoration: BoxDecoration(
//                             color: AppColors.ProductDisplayWidgetBackground,
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Icon(
//                             _favorited ? Icons.favorite : Icons.favorite_border,
//                             color: _favorited
//                                 ? AppColors.accentRed
//                                 : AppColors.textBlack,
//                             size: 20,
//                           ),
//                         ),
//                       ),
//                     ),

//                     /// DISCOUNT
//                     Positioned(
//                       top: 6,
//                       left: 6,
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 4,
//                           vertical: 2,
//                         ),
//                         decoration: BoxDecoration(
//                           color: AppColors.textBlack,
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                         child: const Text(
//                           '↓ 12%',
//                           style: TextStyle(
//                             fontSize: 11,
//                             fontWeight: FontWeight.w600,
//                             color: AppColors.backgroundWhite,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             /// DETAILS — NO Expanded
//             Padding(
//               padding: const EdgeInsets.fromLTRB(6, 4, 6, 6),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       const Text(
//                         'reviews:',
//                         style: TextStyle(
//                           fontSize: 9,
//                           color: AppColors.formGrey96,
//                         ),
//                       ),
//                       const SizedBox(width: 2),
//                       const Icon(Icons.star, size: 12, color: Colors.amber),
//                       const SizedBox(width: 2),
//                       Text(
//                         widget.car['rating'].toString(),
//                         style: const TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w900,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 2),
//                   Text(
//                     widget.car['name'],
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(
//                       fontSize: 11,
//                       fontWeight: FontWeight.w600,
//                       height: 1.2,
//                     ),
//                   ),
//                   const SizedBox(height: 2),
//                   Text(
//                     widget.car['price'],
//                     style: const TextStyle(
//                       fontSize: 11,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     widget.car['price'],
//                     style: const TextStyle(
//                       fontSize: 9,
//                       decoration: TextDecoration.lineThrough,
//                       color: AppColors.textGrey,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:first/core/app_imports.dart';

class ProductDisplayWidget extends StatelessWidget {
  final List<Map<String, dynamic>> cars;
  final bool glassEffect; // optional for all cards

  const ProductDisplayWidget({
    super.key,
    required this.cars,
    this.glassEffect = false,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cars.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 14,
        crossAxisSpacing: 8,
        childAspectRatio: 0.66,
      ),
      itemBuilder: (context, index) {
        return ProductCard(car: cars[index], glassEffect: glassEffect);
      },
    );
  }
}

class ProductCard extends StatefulWidget {
  final Map<String, dynamic> car;
  final bool glassEffect;

  const ProductCard({super.key, required this.car, this.glassEffect = false});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _favorited = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(product: widget.car),
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
                        widget.car['coverImage'] ??
                            'https://picsum.photos/200?3',
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
                        onTap: () => setState(() => _favorited = !_favorited),
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            _favorited ? Icons.favorite : Icons.favorite_border,
                            color: _favorited
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
                        child: const Text(
                          '↓ 12%',
                          style: TextStyle(
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
                        widget.car['rating'].toString(),
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.car['productName'] ?? 'Unknown Product',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
                  ),
                  Text(
                    'PKR ${widget.car['price']?.toString() ?? '0'}',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'PKR ${widget.car['price']?.toString() ?? '0'}',
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
