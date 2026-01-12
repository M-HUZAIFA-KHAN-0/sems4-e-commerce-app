// import 'package:flutter/material.dart';
// import 'add_to_card_prod_item_widget.dart';

// /// A single wishlist-style card for the "New Arrival" section.
// ///
// /// Layout and styling intentionally matches the existing wishlist row
// /// but removes selection UI and replaces the delete icon with a
// /// tappable heart that toggles between outlined/filled.
// class WishlistCardWidget extends StatefulWidget {
//   const WishlistCardWidget({
//     super.key,
//     required this.item,
//     this.onCartTap,
//     this.onHeartToggled,
//   });

//   final CartProductItem item;
//   final VoidCallback? onCartTap;
//   final ValueChanged<bool>? onHeartToggled;

//   @override
//   State<WishlistCardWidget> createState() => _WishlistCardWidgetState();
// }

// class _WishlistCardWidgetState extends State<WishlistCardWidget> {
//   static const Color _lightGrey = Color(0xFFF3F4F6);
//   static const Color _textGrey = Color(0xFF9AA0A6);
//   static const Color _iconGrey = Color(0xFFBDBDBD);
//   static const Color _borderGrey = Color(0xFFE7E9EE);

//   bool _favorited = false;

//   @override
//   Widget build(BuildContext context) {
//     final item = widget.item;

//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//       ),
//       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 7),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(10),
//             child: Container(
//               width: 75,
//               height: 75,
//               color: _lightGrey,
//               child: _buildImage(item),
//             ),
//           ),

//           const SizedBox(width: 8),

//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.only(top: 2),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Text(
//                           item.title,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: const TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w800,
//                             color: Colors.black87,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 9),
//                       InkWell(
//                         onTap: () {
//                           setState(() => _favorited = !_favorited);
//                           widget.onHeartToggled?.call(_favorited);
//                         },
//                         borderRadius: BorderRadius.circular(10),
//                         child: Padding(
//                           padding: const EdgeInsets.all(6),
//                           child: Icon(
//                             _favorited ? Icons.favorite : Icons.favorite_border,
//                             color: _favorited ? Colors.red : _iconGrey,
//                             size: 24,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 2),
//                   Text(
//                     'Variant: ${item.variantText}',
//                     style: const TextStyle(
//                       fontSize: 12,
//                       color: _textGrey,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Text(
//                           item.priceText,
//                           style: const TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w900,
//                             color: Colors.black87,
//                           ),
//                         ),
//                       ),
//                       InkWell(
//                         onTap: widget.onCartTap,
//                         borderRadius: BorderRadius.circular(10),
//                         child: Container(
//                           width: 36,
//                           height: 36,
//                           child: const Icon(
//                             Icons.add_shopping_cart,
//                             size: 20,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildImage(CartProductItem item) {
//     if (item.imageProvider != null) {
//       return Image(
//         image: item.imageProvider!,
//         fit: BoxFit.cover,
//         filterQuality: FilterQuality.high,
//       );
//     }
//     if (item.imageUrl != null && item.imageUrl!.isNotEmpty) {
//       return Image.network(
//         item.imageUrl!,
//         fit: BoxFit.cover,
//         filterQuality: FilterQuality.high,
//       );
//     }
//     return const Center(child: Icon(Icons.image_outlined, color: _iconGrey));
//   }
// }

// import 'package:flutter/material.dart';
// import 'add_to_card_prod_item_widget.dart';

// /// Wishlist-style notification card (modified)
// ///
// /// Changes made as requested:
// /// 1) "NEW" label on the top-left corner of the image (blue bg, white text),
// ///    slightly rotated and overlapping the image.
// /// 2) Removed the original inline price placement and moved the price to a single
// ///    fixed place (top-right area inside content row).
// /// 3) Added a small date label (auto-generated here) placed under the title
// ///    (adjusted UI-wise so it looks balanced).
// /// 4) Added a "View Details" button in the card bottom-left and kept the
// ///    add-to-cart icon on bottom-right. Positions adjusted to look good.
// ///
// /// The widget still receives all content from parent via `CartProductItem`.
// /// The file returns the full widget implementation (single-file).
// class WishlistCardWidget extends StatefulWidget {
//   const WishlistCardWidget({
//     super.key,
//     required this.item,
//     this.onCartTap,
//     this.onHeartToggled,
//     this.onViewDetails,
//   });

//   final CartProductItem item;
//   final VoidCallback? onCartTap;
//   final ValueChanged<bool>? onHeartToggled;
//   final VoidCallback? onViewDetails;

//   @override
//   State<WishlistCardWidget> createState() => _WishlistCardWidgetState();
// }

// class _WishlistCardWidgetState extends State<WishlistCardWidget> {
//   static const Color _lightGrey = Color(0xFFF3F4F6);
//   static const Color _textGrey = Color(0xFF9AA0A6);
//   static const Color _iconGrey = Color(0xFFBDBDBD);
//   static const Color _borderGrey = Color(0xFFE7E9EE);
//   static const Color _blueNew = Color(0xFF0A84FF); // NEW label background

//   bool _favorited = false;

//   // Simple date formatter to display a nice date string for the notification.
//   // The user said "tum khud karna" so we place a date here using the current date.
//   String get _dateStamp {
//     final now = DateTime.now();
//     final monthNames = [
//       "Jan",
//       "Feb",
//       "Mar",
//       "Apr",
//       "May",
//       "Jun",
//       "Jul",
//       "Aug",
//       "Sep",
//       "Oct",
//       "Nov",
//       "Dec"
//     ];
//     return "${monthNames[now.month - 1]} ${now.day}, ${now.year}";
//   }

//   @override
//   Widget build(BuildContext context) {
//     final item = widget.item;

//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(color: _borderGrey),
//       ),
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           // Image area with the rotated "NEW" label overlay
//           ClipRRect(
//             borderRadius: BorderRadius.circular(10),
//             child: Stack(
//               clipBehavior: Clip.none,
//               children: [
//                 Container(
//                   width: 84,
//                   height: 84,
//                   color: _lightGrey,
//                   child: _buildImage(item),
//                 ),

//                 // Rotated NEW label (overlaps top-left corner of image)
//                 // Slightly positioned outside the image so it crosses the corner.
//                 Positioned(
//                   left: -6,
//                   top: -8,
//                   child: Transform.rotate(
//                     angle: -0.25, // slight rotation - about -14 degrees
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 10, vertical: 6),
//                       decoration: BoxDecoration(
//                         color: _blueNew,
//                         borderRadius: BorderRadius.circular(6),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.08),
//                             blurRadius: 6,
//                             offset: const Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: const Text(
//                         'NEW',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w800,
//                           fontSize: 12,
//                           letterSpacing: 0.6,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(width: 10),

//           // Content (title, date, variant, price, view details button + cart)
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.only(top: 2, bottom: 4),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Top row: title + heart icon (favorite)
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         child: Text(
//                           item.title,
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           style: const TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w800,
//                             color: Colors.black87,
//                           ),
//                         ),
//                       ),

//                       const SizedBox(width: 8),

//                       // Price moved here (single place). Placed top-right for visibility.
//                       // If priceText is empty, it will not take space.
//                       if (item.priceText != null &&
//                           item.priceText!.trim().isNotEmpty)
//                         Padding(
//                           padding: const EdgeInsets.only(top: 2),
//                           child: Text(
//                             item.priceText!,
//                             style: const TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w900,
//                               color: Colors.black87,
//                             ),
//                           ),
//                         ),

//                       const SizedBox(width: 6),

//                       InkWell(
//                         onTap: () {
//                           setState(() => _favorited = !_favorited);
//                           widget.onHeartToggled?.call(_favorited);
//                         },
//                         borderRadius: BorderRadius.circular(10),
//                         child: Padding(
//                           padding: const EdgeInsets.all(6),
//                           child: Icon(
//                             _favorited ? Icons.favorite : Icons.favorite_border,
//                             color: _favorited ? Colors.red : _iconGrey,
//                             size: 22,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 6),

//                   // Date row (minor, UI-wise pleasing)
//                   Text(
//                     _dateStamp,
//                     style: const TextStyle(
//                       fontSize: 12,
//                       color: _textGrey,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),

//                   const SizedBox(height: 8),

//                   // Variant info
//                   Text(
//                     'Variant: ${item.variantText}',
//                     style: const TextStyle(
//                       fontSize: 13,
//                       color: _textGrey,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),

//                   const SizedBox(height: 12),

//                   // Bottom row: View Details button (left) + Add to cart icon (right)
//                   Row(
//                     children: [
//                       // View Details button - styled to fit card UI
//                       ElevatedButton(
//                         onPressed: widget.onViewDetails,
//                         style: ElevatedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 14, vertical: 8),
//                           backgroundColor: Colors.white,
//                           side: BorderSide(color: Colors.grey.shade300),
//                           elevation: 0,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         child: const Text(
//                           'View Details',
//                           style: TextStyle(
//                             color: Colors.black87,
//                             fontWeight: FontWeight.w700,
//                             fontSize: 13,
//                           ),
//                         ),
//                       ),

//                       const Spacer(),

//                       // Add to cart icon (kept small like original)
//                       InkWell(
//                         onTap: widget.onCartTap,
//                         borderRadius: BorderRadius.circular(10),
//                         child: Container(
//                           width: 38,
//                           height: 38,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(10),
//                             border: Border.all(color: _borderGrey),
//                           ),
//                           child: const Icon(
//                             Icons.add_shopping_cart,
//                             size: 20,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildImage(CartProductItem item) {
//     if (item.imageProvider != null) {
//       return Image(
//         image: item.imageProvider!,
//         fit: BoxFit.cover,
//         filterQuality: FilterQuality.high,
//       );
//     }
//     if (item.imageUrl != null && item.imageUrl!.isNotEmpty) {
//       return Image.network(
//         item.imageUrl!,
//         fit: BoxFit.cover,
//         filterQuality: FilterQuality.high,
//         errorBuilder: (context, error, stackTrace) =>
//             const Center(child: Icon(Icons.broken_image, color: _iconGrey)),
//       );
//     }
//     return const Center(child: Icon(Icons.image_outlined, color: _iconGrey));
//   }
// }

import 'package:flutter/material.dart';
import 'add_to_card_prod_item_widget.dart';

class WishlistCardWidget extends StatefulWidget {
  const WishlistCardWidget({
    super.key,
    required this.item,
    this.onCartTap,
    this.onHeartToggled,
    this.onViewDetails,
  });

  final CartProductItem item;
  final VoidCallback? onCartTap;
  final VoidCallback? onViewDetails;
  final ValueChanged<bool>? onHeartToggled;

  @override
  State<WishlistCardWidget> createState() => _WishlistCardWidgetState();
}

class _WishlistCardWidgetState extends State<WishlistCardWidget> {
  static const Color _lightGrey = Color(0xFFF3F4F6);
  static const Color _textGrey = Color(0xFF9AA0A6);
  static const Color _iconGrey = Color(0xFFBDBDBD);
  static const Color _borderGrey = Color(0xFFE7E9EE);

  bool _favorited = false;

  String get _dateText {
    final now = DateTime.now();
    return "${now.day}/${now.month}/${now.year}";
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _borderGrey),
          ),
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: 82,
                  height: 82,
                  color: _lightGrey,
                  child: _buildImage(item),
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Expanded(
                        //   child: Text(
                        //                         _dateText,
                        //                         style: const TextStyle(
                        //   fontSize: 12,
                        //   color: _textGrey,
                        //   fontWeight: FontWeight.w600,
                        //                         ),
                        //                       ),
                        // ),
                        Expanded(
                          child: Text(
                            item.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),

                        // InkWell(
                        //   onTap: () {
                        //     setState(() => _favorited = !_favorited);
                        //     widget.onHeartToggled?.call(_favorited);
                        //   },
                        //   child: Icon(
                        //     _favorited ? Icons.favorite : Icons.favorite_border,
                        //     color: _favorited ? Colors.red : _iconGrey,
                        //   ),
                        // ),
                        Text(
                          _dateText,
                          style: const TextStyle(
                            fontSize: 12,
                            color: _textGrey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    // Text(
                    //   _dateText,
                    //   style: const TextStyle(
                    //     fontSize: 12,
                    //     color: _textGrey,
                    //     fontWeight: FontWeight.w600,
                    //   ),
                    // ),
                    // Expanded(
                    // Text(
                    //   item.title,
                    //   maxLines: 2,
                    //   overflow: TextOverflow.ellipsis,
                    //   style: const TextStyle(
                    //     fontSize: 15,
                    //     fontWeight: FontWeight.w800,
                    //   ),
                    // ),
                    // ),
                    const SizedBox(height: 6),

                    Text(
                      "Variant: ${item.variantText}",
                      style: const TextStyle(
                        fontSize: 13,
                        color: _textGrey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        OutlinedButton(
                          onPressed: widget.onViewDetails,
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "View Details",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                        ),

                        const Spacer(),

                        InkWell(
                          onTap: () {
                            setState(() => _favorited = !_favorited);
                            widget.onHeartToggled?.call(_favorited);
                          },
                          child: Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: _borderGrey),
                            ),
                            child: Icon(
                              _favorited
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: _favorited ? Colors.red : _iconGrey,
                            ),
                          ),
                          // child: Icon(
                          //   _favorited ? Icons.favorite : Icons.favorite_border,
                          //   color: _favorited ? Colors.red : _iconGrey,

                          // ),
                        ),

                        const SizedBox(width: 12),

                        InkWell(
                          onTap: widget.onCartTap,
                          child: Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: _borderGrey),
                            ),
                            child: const Icon(Icons.add_shopping_cart),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        /// 🔥 NEW RIBBON (Card-based – top-left → left-center)
        Positioned(
          top: 14,
          left: -48,
          child: Transform.rotate(
            angle: -0.55, // diagonal slash angle
            child: Container(
              width: 160,
              height: 26,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xFF0A84FF),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: const Text(
                "NEW",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImage(CartProductItem item) {
    if (item.imageProvider != null) {
      return Image(image: item.imageProvider!, fit: BoxFit.cover);
    }
    if (item.imageUrl != null && item.imageUrl!.isNotEmpty) {
      return Image.network(item.imageUrl!, fit: BoxFit.cover);
    }
    return const Icon(Icons.image_outlined, color: _iconGrey);
  }
}
