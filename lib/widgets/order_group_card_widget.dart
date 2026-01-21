import 'package:flutter/material.dart';

class OrderGroupCard extends StatelessWidget {
  final String orderNumber;
  final String? placedDate;
  final String? status;
  final List<Map<String, dynamic>> items;
  final bool isOrderTracking;
  final VoidCallback? onTrackClick;

  const OrderGroupCard({
    super.key,
    required this.orderNumber,
    this.placedDate,
    this.status,
    required this.items,
    this.isOrderTracking = false,
    this.onTrackClick,
  });

  double _parsePriceToDouble(String rawPrice) {
    var s = rawPrice.replaceAll(RegExp(r"[^0-9,\.]"), '');
    if (s.isEmpty) return 0.0;

    // If string contains comma but no dot, decide if comma is thousand or decimal
    if (s.contains(',') && !s.contains('.')) {
      final parts = s.split(',');
      if (parts.last.length == 3) {
        s = s.replaceAll(',', ''); // thousand separator
      } else {
        s = s.replaceAll(',', '.'); // decimal comma
      }
    } else {
      s = s.replaceAll(',', '');
    }

    return double.tryParse(s) ?? 0.0;
  }

  String _formatTotal(double total) {
    if (total % 1 == 0) return total.toInt().toString();
    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    final total = items.fold<double>(0.0, (prev, it) {
      final p = (it['price'] ?? '') as String;
      return prev + _parsePriceToDouble(p);
    });

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    orderNumber,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ),
                if (status != null && status!.isNotEmpty)
                  Text(
                    status!,
                    style: TextStyle(
                      color: status == 'Cancelled' ? Colors.blue : Colors.teal,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 10),

            // Items (2-3 items shown stacked)
            Column(
              children: items.map((it) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.network(
                          it['imageUrl'] ?? '',
                          width: 72,
                          height: 72,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 72,
                            height: 72,
                            color: const Color(0xFFF2F4F7),
                            child: const Icon(Icons.image, color: Colors.grey),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 🔹 Product name + price (same row)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    it['productName'] ?? '',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                      height: 1.1,
                                    ),
                                  ),
                                ),
                                // const SizedBox(width: 8),
                                // Text(
                                //   it['price'] ?? '',
                                //   style: const TextStyle(
                                //     fontWeight: FontWeight.w700,
                                //     fontSize: 13,
                                //   ),
                                // ),
                              ],
                            ),

                            const SizedBox(height: 6),

                            // 🔹 Variant + quantity (same row, top aligned)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    // padding: const EdgeInsets.symmetric(
                                    //   horizontal: 8,
                                    //   vertical: 4,
                                    // ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF3F6F8),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      'Color Family: ${it['variant'] ?? ''}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Color(0xFF8B95A5),
                                        fontSize: 12,
                                        height: 1.1,
                                      ),
                                    ),
                                  ),
                                ),
                                // const SizedBox(width: 8),
                                // Text(
                                //   'Qty: ${it['quantity'] ?? 1}',
                                //   style: const TextStyle(
                                //     fontSize: 12,
                                //     color: Color(0xFF333333),
                                //   ),
                                // ),
                              ],
                            ),

                            const SizedBox(height: 6),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    it['price'] ?? '',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Qty: ${it['quantity'] ?? 1}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF333333),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 8),
            // const Divider(),
            // const SizedBox(height: 8),

            // Total row and actions
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Total(${items.length} Item${items.length > 1 ? 's' : ''}):',
                        style: const TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 9),
                      Text(
                        ' Rs. ${_formatTotal(total)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // OutlinedButton(
                //   onPressed: status == 'Cancelled' ? null : () {},
                //   style: OutlinedButton.styleFrom(
                //     foregroundColor: Colors.black87,
                //     side: const BorderSide(color: Color(0xFFBDBEC2)),
                //     padding: const EdgeInsets.symmetric(
                //       horizontal: 10,
                //       vertical: 8,
                //     ),
                //   ),
                //   child: Text(
                //     status == 'Cancelled' ? 'Cancelled' : 'Cancel/Refund',
                //     style: const TextStyle(fontSize: 12),
                //   ),
                // ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: isOrderTracking ? onTrackClick : () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF7A00),
                    elevation: 0, // shadow/border feel remove
                    minimumSize: const Size(0, 30), // height control
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 0,
                    ),
                    tapTargetSize:
                        MaterialTapTargetSize.shrinkWrap, // extra height remove
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    isOrderTracking ? 'Track Now' : 'Buy again',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
