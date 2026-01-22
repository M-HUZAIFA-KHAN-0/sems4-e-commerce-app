import 'package:first/core/app_imports.dart';

// Order Status Model
class OrderTrackingStatus {
  final String title;
  final bool isCompleted;

  OrderTrackingStatus({required this.title, required this.isCompleted});
}

class OrderTrackingWidget extends StatelessWidget {
  final String orderId;
  final String items;
  final String price;
  final List<OrderTrackingStatus> trackingSteps;
  final String placedDate;

  const OrderTrackingWidget({
    super.key,
    required this.orderId,
    required this.items,
    required this.price,
    required this.trackingSteps,
    required this.placedDate,
  });

  IconData _getIconForStep(int index) {
    switch (index) {
      case 0: // Order Placed
        return Icons.shopping_bag_outlined;
      case 1: // Order Confirmed
        return Icons.check_circle_outline;
      case 2: // Order Shipped
        return Icons.local_shipping_outlined;
      case 3: // Out for Delivery
        return Icons.delivery_dining_outlined;
      case 4: // Order Delivered
        return Icons.home_outlined;
      default:
        return Icons.circle_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(0),
      child: Column(
        children: [
          // Order Details Card
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.backgroundWhite,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.statusGreenLight,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.local_shipping_outlined,
                          color: AppColors.primaryGreen,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Order # $orderId",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "Placed on $placedDate",
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
                                    '$items',
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
                                    "$price",
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
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Tracking Timeline Card
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.backgroundWhite,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: List.generate(trackingSteps.length, (index) {
                  final step = trackingSteps[index];
                  final isLast = index == trackingSteps.length - 1;

                  return Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Timeline dot and line
                          Column(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: step.isCompleted
                                      ? const Color(0xFF4CAF50)
                                      : AppColors.borderGreyLight,
                                ),
                                child: Icon(
                                  _getIconForStep(index),
                                  color: step.isCompleted
                                      ? AppColors.backgroundWhite
                                      : const Color(0xFFB0B0B0),
                                  size: 24,
                                ),
                              ),
                              if (!isLast)
                                Container(
                                  width: 2,
                                  height: 30,
                                  color: step.isCompleted
                                      ? const Color(0xFF4CAF50)
                                      : AppColors.borderGreyLight,
                                  // margin: const EdgeInsets.only(top: 8),
                                ),
                            ],
                          ),
                          const SizedBox(width: 20),

                          // Status text
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    step.title,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: step.isCompleted
                                          ? Colors.black87
                                          : const Color(0xFFB0B0B0),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    step.isCompleted ? 'Completed' : 'Pending',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: step.isCompleted
                                          ? const Color(0xFF4CAF50)
                                          : const Color(0xFFB0B0B0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      // if (!isLast) const SizedBox(height: 8),
                    ],
                  );
                }),
              ),
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
