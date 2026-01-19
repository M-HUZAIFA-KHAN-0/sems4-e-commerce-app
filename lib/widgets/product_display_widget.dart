// import 'package:flutter/material.dart';
// import '../screens/product_detail_page.dart';

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
//         mainAxisSpacing: 16,
//         crossAxisSpacing: 12,
//         childAspectRatio: 0.75,
//       ),
//       itemBuilder: (context, index) {
//         return ProductCard(car: cars[index]);
//       },
//     );
//   }
// }
//   bool _favorited = false;

// /// Individual Product Card widget
// class ProductCard extends StatelessWidget {
//   final Map<String, dynamic> car;

//   const ProductCard({super.key, required this.car});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ProductDetailPage(product: car),
//           ),
//         );
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12),
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.1),
//               spreadRadius: 1,
//               blurRadius: 5,
//             ),
//           ],
//         ),
//         child: Column(
//           children: [
//             Stack(
//               children: [
//                 Container(
//                   height: 140,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: car['color'],
//                     borderRadius: const BorderRadius.vertical(
//                       top: Radius.circular(12),
//                     ),
//                   ),
//                   child: Icon(car['image'], size: 80, color: Colors.grey[400]),
//                 ),
//                 // Positioned(
//                 //   top: 8,
//                 //   right: 8,
//                 //   child: Container(
//                 //     decoration: BoxDecoration(
//                 //       color: Colors.white,
//                 //       borderRadius: BorderRadius.circular(6),
//                 //     ),
//                 //     padding: const EdgeInsets.all(4),
//                 //     child: const Icon(
//                 //       Icons.favorite_border,
//                 //       size: 16,
//                 //       color: Colors.grey,
//                 //     ),
//                 //   ),
//                 // ),
//                 Positioned(
//                   top: 6,
//                   right: 6,
//                   child: Container(
//                     width: 32,
//                     height: 32,
//                     decoration: BoxDecoration(
//                       color: const Color(
//                         0xFFF2F3FA,
//                       ), // 👈 BG same as border color
//                       borderRadius: BorderRadius.circular(8),
//                       border: Border.all(color: const Color(0xFFF2F3FA)),
//                     ),
//                     child: Center(
//                       // 👈 ensures icon is centered
//                       child: GestureDetector(
//                         onTap: () {
//                           setState(() => _favorited = !_favorited);
//                           widget.item.onHeartToggled?.call(_favorited);
//                         },
//                         child: Icon(
//                           _favorited ? Icons.favorite : Icons.favorite_border,
//                           color: _favorited
//                               ? Colors.red
//                               : const Color.fromARGB(255, 0, 0, 0),
//                           size: 25, // 👈 adjust size to fit nicely
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                     top: 6,
//                     left: 6,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 3,
//                         vertical: 1,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.black,
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                       child: Text(
//                         // '↓ ${car['discount']}%',
//                         '↓ 12%',
//                         style: const TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.all(6),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       car['name'],
//                       style: const TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                         height: 1.1,
//                       ),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 1),
//                     Row(
//                       children: [
//                         const Icon(Icons.star, size: 12, color: Colors.amber),
//                         const SizedBox(width: 4),
//                         Text(
//                           car['rating'].toString(),
//                           style: const TextStyle(
//                             fontSize: 11,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         const SizedBox(width: 6),
//                         Text(
//                           car['status'],
//                           style: TextStyle(
//                             fontSize: 10,
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                       ],
//                     ),
//                     const Spacer(),
//                     Text(
//                       car['price'],
//                       style: const TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

































import 'package:flutter/material.dart';
import '../screens/product_detail_page.dart';

class ProductDisplayWidget extends StatelessWidget {
  final List<Map<String, dynamic>> cars;

  const ProductDisplayWidget({super.key, required this.cars});

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
        return ProductCard(car: cars[index]); // 👈 SAME AS BEFORE
      },
    );
  }
}

/// 🔴 NAME SAME — ProductCard
/// 🔴 CONSTRUCTOR SAME — ProductCard({required this.car})
class ProductCard extends StatefulWidget {
  final Map<String, dynamic> car;

  const ProductCard({super.key, required this.car});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _favorited = false;

  // @override
  // Widget build(BuildContext context) {
  //   return GestureDetector(
  //     onTap: () {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) =>
  //               ProductDetailPage(product: widget.car),
  //         ),
  //       );
  //     },
  //     child: Container(
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(12),
  //         color: const Color.fromARGB(183, 161, 161, 161),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.grey.withOpacity(0.1),
  //             blurRadius: 5,
  //           ),
  //         ],
  //       ),
  //       child: Column(
  //         children: [
  //           Stack(
  //             children: [
  //               Container(
  //                 height: 140,
  //                 width: double.infinity,
  //                 decoration: BoxDecoration(
  //                   color: widget.car['color'],
  //                   borderRadius: const BorderRadius.vertical(
  //                     top: Radius.circular(12),
  //                   ),
  //                 ),
  //                 child: Icon(
  //                   widget.car['image'],
  //                   size: 80,
  //                   color: Colors.grey[400],
  //                 ),
  //               ),

  //               /// ❤️ FAVORITE ICON (FIXED)
  //               Positioned(
  //                 top: 6,
  //                 right: 6,
  //                 child: GestureDetector(
  //                   onTap: () {
  //                     setState(() {
  //                       _favorited = !_favorited;
  //                     });
  //                   },
  //                   child: Container(
  //                     width: 32,
  //                     height: 32,
  //                     decoration: BoxDecoration(
  //                       color: const Color(0xFFF2F3FA),
  //                       borderRadius: BorderRadius.circular(8),
  //                     ),
  //                     child: Icon(
  //                       _favorited
  //                           ? Icons.favorite
  //                           : Icons.favorite_border,
  //                       color: _favorited ? Colors.red : Colors.black,
  //                       size: 20,
  //                     ),
  //                   ),
  //                 ),
  //               ),

  //               /// DISCOUNT
  //               Positioned(
  //                 top: 6,
  //                 left: 6,
  //                 child: Container(
  //                   padding: const EdgeInsets.symmetric(
  //                     horizontal: 4,
  //                     vertical: 2,
  //                   ),
  //                   decoration: BoxDecoration(
  //                     color: Colors.black,
  //                     borderRadius: BorderRadius.circular(4),
  //                   ),
  //                   child: const Text(
  //                     '↓ 12%',
  //                     style: TextStyle(
  //                       fontSize: 11,
  //                       fontWeight: FontWeight.w600,
  //                       color: Colors.white,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),

  //           Expanded(
  //             child: Padding(
  //               padding: const EdgeInsets.fromLTRB(4, 1, 4, 6),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Row(
  //                     children: [
  //                       Text(
  //                         'reviews: ',
  //                         style: const TextStyle(fontSize: 9, color: Color.fromARGB(255, 97, 96, 96)),
  //                       ),
  //                       const Icon(Icons.star,
  //                           size: 12, color: Colors.amber),
  //                       const SizedBox(width: 4),
  //                       Text(
  //                         widget.car['rating'].toString(),
  //                         style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900),
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
  //                   // const Spacer(),
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
  //                       fontWeight: FontWeight.bold,
  //                       decoration: TextDecoration.lineThrough,
  //                       color: Colors.grey,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }







@override
Widget build(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ProductDetailPage(product: widget.car),
        ),
      );
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color.fromARGB(183, 161, 161, 161),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          /// IMAGE — flexible (NO FIXED HEIGHT)
          AspectRatio(
            aspectRatio: 1.1, // ✅ auto height based on width
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: widget.car['color'],
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Icon(
                      widget.car['image'],
                      size: 80,
                      color: Colors.grey[400],
                    ),
                  ),

                  /// FAVORITE
                  Positioned(
                    top: 6,
                    right: 6,
                    child: GestureDetector(
                      onTap: () {
                        setState(() => _favorited = !_favorited);
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF2F3FA),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          _favorited
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: _favorited ? Colors.red : Colors.black,
                          size: 20,
                        ),
                      ),
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
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        '↓ 12%',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// DETAILS — NO Expanded
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
                        color: Color.fromARGB(255, 97, 96, 96),
                      ),
                    ),
                    const SizedBox(width: 2),
                    const Icon(Icons.star,
                        size: 12, color: Colors.amber),
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
                  widget.car['name'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  widget.car['price'],
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.car['price'],
                  style: const TextStyle(
                    fontSize: 9,
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey,
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
