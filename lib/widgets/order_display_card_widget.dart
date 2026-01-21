import 'package:flutter/material.dart';

// Data Model taaki parent se data asani se pass ho sake
class OrderStatus {
  final String title;
  final String date;
  final bool isCompleted;

  OrderStatus({
    required this.title,
    required this.date,
    required this.isCompleted,
  });
}

class OrderModel {
  final String orderId;
  final String placedDate;
  final int itemsCount;
  final String price;
  final List<OrderStatus> timeline;
  final String status;

  OrderModel({
    required this.orderId,
    required this.placedDate,
    required this.itemsCount,
    required this.price,
    required this.timeline,
    required this.status
  });
}

class OrderCard extends StatefulWidget {
  final OrderModel order;
  final VoidCallback onTapHeader; // Name/Image click event

  const OrderCard({Key? key, required this.order, required this.onTapHeader})
    : super(key: key);

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          // Header Section (Jo hamesha dikhta hai)
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 6, 16),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Order #${widget.order.orderId}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      widget.order.status,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: _statusColor(widget.order.status),
                      ),
                    ),
                    SizedBox(width: 6)
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    // Box Image/Icon
                    GestureDetector(
                      onTap: widget.onTapHeader,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Icon(
                          Icons.inventory_2_outlined,
                          color: Color(0xFF4CAF50),
                          size: 30,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Text Details
                    Expanded(
                      child: GestureDetector(
                        onTap: widget.onTapHeader,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(
                            //   "Order #${widget.order.orderId}",
                            //   style: const TextStyle(
                            //     fontWeight: FontWeight.bold,
                            //     fontSize: 16,
                            //   ),
                            // ),
                            Text(
                              "Placed on ${widget.order.placedDate}",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Text(
                                  "Items: ",
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "${widget.order.itemsCount}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  "Price: ",
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "\$${widget.order.price}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Expand Icon
                    IconButton(
                      padding: EdgeInsets
                          .zero, // Default padding khatam karne ke liye
                      constraints:
                          const BoxConstraints(), // Extra space hatane ke liye
                      splashRadius: 20,
                      icon: Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: const Color(0xFF4CAF50),
                        size: 38,
                      ),
                      onPressed: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Expanded Section (Timeline)
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 16, 20),
              child: Column(
                children: widget.order.timeline.asMap().entries.map((entry) {
                  int idx = entry.key;
                  OrderStatus status = entry.value;
                  bool isLast = idx == widget.order.timeline.length - 1;

                  return IntrinsicHeight(
                    child: Row(
                      children: [
                        // Timeline Line and Dot
                        Column(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: status.isCompleted
                                    ? const Color(0xFF4CAF50)
                                    : Colors.grey[300],
                                shape: BoxShape.circle,
                              ),
                            ),
                            if (!isLast)
                              Expanded(
                                child: Container(
                                  width: 2,
                                  color: status.isCompleted
                                      ? const Color(0xFF4CAF50)
                                      : Colors.grey[300],
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        // Status Text and Date
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  status.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: status.isCompleted
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                ),
                                Text(
                                  status.date,
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
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
