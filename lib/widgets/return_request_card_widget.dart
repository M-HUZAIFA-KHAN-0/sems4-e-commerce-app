import 'package:first/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ReturnRequestCardWidget extends StatelessWidget {
  final String productId;
  final String productName;
  final String productImage;
  final String price;
  final int quantity;
  final String receivedDate;
  final String returnRequestDate;
  final String refundAmount;
  final String status; // "Pending" or "Approved"
  final VoidCallback onCancelReturn;

  const ReturnRequestCardWidget({
    super.key,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.price,
    required this.quantity,
    required this.receivedDate,
    required this.returnRequestDate,
    required this.refundAmount,
    required this.status,
    required this.onCancelReturn,
  });

  String _getStatusMessage() {
    if (status == 'Approved') {
      return 'Your product will be picked up by Jan 28, 2026. Refund will be processed afterward.';
    } else {
      return 'You will receive a response on this return request within 3-5 days.';
    }
  }

  Color _getStatusBoxColor() {
    if (status == 'Approved') {
      return const Color(0xFFE8F5E9); // Light green
    } else {
      return const Color(0xFFFFF3E0); // Light orange
    }
  }

  Color _getStatusBorderColor() {
    if (status == 'Approved') {
      return const Color(0xFF4CAF50); // Green
    } else {
      return const Color(0xFFFF9800); // Orange
    }
  }

  Color _getStatusTextColor() {
    if (status == 'Approved') {
      return const Color(0xFF2E7D32); // Dark green
    } else {
      return const Color(0xFFE65100); // Dark orange
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Status Badge
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // -------- Left side (Return Request Date) --------
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Return Request Date',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFF999999),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      returnRequestDate,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),

                // -------- Right side (Status badge) --------
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: status == 'Approved'
                        ? const Color(0xFFE8F5E9)
                        : const Color(0xFFFFF3E0),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: _getStatusTextColor(),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: Color(0xFFE8E8E8)),
          const SizedBox(height: 2),

          // Status Message Box
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _getStatusBoxColor(),
              border: Border.all(color: _getStatusBorderColor(), width: 1),
              borderRadius: BorderRadius.circular(8),
            ),

            child: Row(
              children: [
                Icon(
                  status == 'Approved'
                      ? Icons.check_circle_outline
                      : Icons.info_outline,
                  color: _getStatusTextColor(),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _getStatusMessage(),
                    style: TextStyle(
                      fontSize: 12,
                      color: _getStatusTextColor(),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                const SizedBox(height: 8),

                // Product Section
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        productImage,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8E8E8),
                            borderRadius: BorderRadius.circular(8),
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
                          // Product Name
                          Text(
                            productName,
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
                                price,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Qty: $quantity',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFF666666),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),

                          // Received Date
                          Text(
                            'Received: $receivedDate',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Color(0xFF999999),
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          if (status == 'Pending') ...[ 
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              PrimaryBtnWidget(onPressed: (){}, buttonText: 'Cancel Request', height: 30, fontSize: 11, width: 130,),
                            ],
                          )
                          ]
                        ],
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 12),
                const Divider(height: 1, color: Color(0xFFE8E8E8)),
                const SizedBox(height: 12),

                // Timeline: Received -> Returned -> Refunded
                Row(
                  children: [
                    // Received
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: status == 'Approved'
                        ? const Color(0xFF4CAF50) : const Color(0xFF666666),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Approved',
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFF666666),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            status == 'Approved'
                        ? receivedDate : "date",
                            style: const TextStyle(
                              fontSize: 9,
                              color: Color(0xFF999999),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Arrow
                    // Expanded(
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 2,
                            width: 50,
                            color: const Color(0xFF666666),
                          ),
                          // const SizedBox(height: 14),
                          // const Icon(
                          //   Icons.arrow_forward,
                          //   size: 18,
                          //   color: Color(0xFF4CAF50),
                          // ),
                        ],
                      ),
                    ),
                    // ),

                    // Returned
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: const Color(0xFF666666),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              Icons.restart_alt_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Returned',
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFF666666),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "date",
                            style: const TextStyle(
                              fontSize: 9,
                              color: Color(0xFF999999),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Arrow
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 2,
                            width: 50,
                            color: const Color(0xFF666666),
                          ),
                          // const SizedBox(height: 14),
                          // const Icon(
                          //   Icons.arrow_forward,
                          //   size: 18,
                          //   color: Color(0xFF4CAF50),
                          // ),
                        ],
                      ),
                    ),
                    // ),

                    // Refunded
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: const Color(0xFF666666),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              Icons.account_balance_wallet_outlined,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Refunded',
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFF666666),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "date",
                            style: const TextStyle(
                              fontSize: 9,
                              color: Color(0xFF999999),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                const Divider(height: 1, color: Color(0xFFE8E8E8)),
                const SizedBox(height: 12),

                // Refund Amount
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Refund Amount',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF666666),
                      ),
                    ),
                    Text(
                      refundAmount,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF4CAF50),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
