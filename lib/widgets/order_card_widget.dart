import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.orderNumber,
    required this.placedDate,
    required this.imageUrl,
    required this.productName,
    required this.variant,
    required this.quantity,
    required this.price,
    required this.status,
  });

  final String orderNumber;
  final String placedDate;
  final String imageUrl;
  final String productName;
  final String variant;
  final int quantity;
  final String price;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // left: image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 72,
              height: 72,
              color: const Color(0xFFF3F4F6),
              child: imageUrl.isNotEmpty
                  ? Image.network(imageUrl, fit: BoxFit.cover)
                  : const Icon(
                      Icons.image_outlined,
                      size: 36,
                      color: Colors.grey,
                    ),
            ),
          ),

          const SizedBox(width: 12),

          // middle: product details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        productName,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                Text(
                  'Variant: $variant',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF9AA0A6),
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 6),

                Row(
                  children: [
                    Text(
                      'Qty: $quantity',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF9AA0A6),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Order: $orderNumber',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF9AA0A6),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // right: status and date
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _statusColor(status).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: _statusColor(status),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                placedDate,
                style: const TextStyle(fontSize: 12, color: Color(0xFF9AA0A6)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _statusColor(String s) {
    final lower = s.toLowerCase();
    if (lower.contains('delivered') || lower.contains('received'))
      return const Color(0xFF55C59A);
    if (lower.contains('pending')) return const Color(0xFFFFC107);
    if (lower.contains('cancel') || lower.contains('rejected'))
      return const Color(0xFFE53935);
    return Colors.black87;
  }
}
