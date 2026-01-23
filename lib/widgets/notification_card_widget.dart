import 'package:first/core/app_imports.dart';

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
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            // color: AppColors.backgroundWhite,
            gradient: AppColors.secondaryBGGradientColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _borderGrey),
          ),
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
                        color: AppColors.textGreyLabel,
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
                            side: const BorderSide(color: AppColors.borderGrey, width: 1.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "View Details",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                              color: AppColors.textGreyLabel,
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

                        const SizedBox(width: 8),

                        // const Spacer(),
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
          top: 11,
          left: -48,
          child: Transform.rotate(
            angle: -0.65, // diagonal slash angle
            child: Container(
              width: 160,
              height: 26,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                // color: Color(0xFF0A84FF),
                gradient: AppColors.bgGradient,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: const Text(
                "NEW ",
                style: TextStyle(
                  color: AppColors.backgroundWhite,
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
