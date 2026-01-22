import 'package:first/core/app_imports.dart';

class OrderTrackingPage extends StatefulWidget {
  final String orderId;
  final String itemsCount;
  final String totalPrice;
  final List<OrderTrackingStatus> trackingSteps;
  final String placedDate;

  const OrderTrackingPage({
    super.key,
    required this.orderId,
    required this.itemsCount,
    required this.totalPrice,
    required this.trackingSteps,
    required this.placedDate,
  });

  @override
  State<OrderTrackingPage> createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: AppBar(
        foregroundColor: AppColors.textBlack87,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back, color: AppColors.textBlack87),
        ),
        title: const Text(
          'Track Order',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.textBlack87,
            fontSize: 18,
          ),
        ),
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
      ),
      body: OrderTrackingWidget(
        orderId: widget.orderId,
        items: widget.itemsCount,
        price: widget.totalPrice,
        trackingSteps: widget.trackingSteps,
        placedDate: widget.placedDate,
      ),
    );
  }
}
