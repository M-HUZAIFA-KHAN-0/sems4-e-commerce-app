import 'package:first/core/app_imports.dart';

class ReturnedRefundedCardWidget extends StatelessWidget {
  final String productId;
  final String productName;
  final String productImage;
  final String price;
  final int quantity;
  final String receivedDate;
  final String returnedDate;
  final String refundAmount;
  final String refundMethod;
  final String returnRequestDate;

  const ReturnedRefundedCardWidget({
    super.key,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.price,
    required this.quantity,
    required this.receivedDate,
    required this.returnedDate,
    required this.refundAmount,
    required this.refundMethod,
    required this.returnRequestDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        // color: AppColors.backgroundWhite,
        gradient: AppColors.secondaryBGGradientColor,
        borderRadius: BorderRadius.circular(12),
        
      ),
      // child: Padding(
      //   padding: const EdgeInsets.all(12),
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
                        color: AppColors.textGreyDark,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      returnRequestDate,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textBlack87,
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
                    color: AppColors.statusGreenLight,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Completed',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.statusGreenDark,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: AppColors.borderGreyLight),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              children: [
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
                            color: AppColors.borderGreyLight,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.image,
                            color: AppColors.textGrey,
                          ),
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
                              color: AppColors.textBlack87,
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
                                  color: AppColors.textBlack87,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Qty: $quantity',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: AppColors.textGreyDark,
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
                              color: AppColors.textGreyDark,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                const Divider(height: 1, color: AppColors.borderGreyLight),
                const SizedBox(height: 12),

                // Timeline: Received -> Returned -> Refunded
                OrderReturnTimelineStatusWidget(status: 'refunded',),

                const SizedBox(height: 12),
                const Divider(height: 1, color: AppColors.borderGreyLight),
                const SizedBox(height: 12),

                // Refund Amount
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Payment Method',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.color666666,
                      ),
                    ),
                    Text(
                      refundMethod,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textGreyMedium,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Refund Amount',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.color666666,
                      ),
                    ),
                    // Text(
                    //   refundAmount,
                    //   style: const TextStyle(
                    //     fontSize: 14,
                    //     fontWeight: FontWeight.w700,
                    //     color: AppColors.statusGreen,
                    //   ),
                    // ),
                    GradientText(text: refundAmount,fontSize: 16,fontWeight: FontWeight.w700,)
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      // ),
    );
  }
}
