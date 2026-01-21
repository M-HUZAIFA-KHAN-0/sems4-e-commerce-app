import 'package:first/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PendingReviewWidget extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  const PendingReviewWidget({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.only(top: 12, bottom: 18),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 6),
          // Heading
          const Text(
            ' Pending Reviews',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),

          // Product Cards
          Column(
            children: products.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> product = entry.value;
              bool isLast = index == products.length - 1;

              return Column(
                children: [
                  _buildProductCard(context, product),
                  if (!isLast) const SizedBox(height: 12),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Map<String, dynamic> product) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFEEEEEE), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              product['imageUrl'] ?? '',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8E8E8),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.image, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Receive Date
                Text(
                  'Received At: ${product['receivedDate'] ?? 'Jan 15, 2026'}',
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF999999),
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
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),

                // Price & Quantity
                Row(
                  children: [
                    Text(
                      product['price'] ?? '0',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Qty: ${product['quantity'] ?? 1}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF666666),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Review Button
                PrimaryBtnWidget(
                  onPressed: () => _navigateToReview(context, product),
                  buttonText: 'Add My Review',
                  height: 32,
                  fontSize: 11,
                  width: 130,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToReview(BuildContext context, Map<String, dynamic> product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddReviewWidget(
          productId: product['productId'] ?? '123',
          productName: product['productName'] ?? 'Product',
          productImage: product['imageUrl'] ?? '',
        ),
      ),
    );
  }
}
