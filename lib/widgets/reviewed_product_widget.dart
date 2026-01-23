import 'package:first/core/app_imports.dart';

class ReviewedProductWidget extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  const ReviewedProductWidget({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 6),
          // Heading
          GradientText(text: " Reviewed Products"),
          // const Text(
          // const Text(
          //   ' Your Reviews',
          //   style: TextStyle(
          //     fontSize: 18,
          //     fontWeight: FontWeight.w700,
          //     color: AppColors.textBlack87,
          //   ),
          // ),
          const SizedBox(height: 12),

          // Reviewed Product Cards
          Column(
            children: products.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> product = entry.value;
              bool isLast = index == products.length - 1;

              return Column(
                children: [
                  _buildReviewCard(product),
                  if (!isLast) const SizedBox(height: 12),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> product) {
    final rating = product['rating'] as int? ?? 0;
    final reviewText = product['reviewText'] as String? ?? '';
    final reviewImagesRaw = product['reviewImages'] as List<dynamic>? ?? [];
    final reviewImages = reviewImagesRaw.cast<String>();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        // color: AppColors.backgroundGrey,
        gradient: AppColors.secondaryBGGradientColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderGrey, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Header (Image + Name)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  product['imageUrl'] ?? '',
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: AppColors.borderGreyLight,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(Icons.image, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Product Name & Rating
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Receive Date
                    Text(
                      'Received At: ${product['receivedDate'] ?? 'Jan 15, 2026'}',
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppColors.formGrey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Product Name
                    Text(
                      product['productName'] ?? 'Product',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textBlack87,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Row(
                      children: [
                        const Text(
                          'Rating',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textGreyMedium,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Row(
                          children: List.generate(5, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 2),
                              child: Icon(
                                index < rating
                                    ? Icons.star
                                    : Icons.star_outline,
                                color: index < rating
                                    ? AppColors.ratingFilled
                                    : AppColors.ratingEmpty,
                                size: 16,
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFE0E0E0)),
          const SizedBox(height: 12),

          // Review Text
          if (reviewText.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Review Message',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textGreyMedium,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  reviewText,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textBlack87,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),

          // Review Images
          if (reviewImages.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Review Images',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textGreyMedium,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 60,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: reviewImages.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.network(
                          reviewImages[index],
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: AppColors.borderGreyLight,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Icon(
                              Icons.image,
                              color: Colors.grey,
                              size: 20,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
