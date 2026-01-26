import 'package:first/core/app_imports.dart';
import 'package:intl/intl.dart';

class OrderReceiptPage extends StatelessWidget {
  final String orderNumber;
  final String productName;
  final String productPrice;
  final String productColor;
  final String productImage;
  final Map<String, dynamic> orderData;

  const OrderReceiptPage({
    super.key,
    required this.orderNumber,
    required this.productName,
    required this.productPrice,
    required this.productColor,
    required this.productImage,
    required this.orderData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGreyLight,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        leading: const SizedBox.shrink(),
        centerTitle: false,
        title: const Text(
          'Order Receipt',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),

            /// ORDER NUMBER HEADER - BLUE CONTAINER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: AppColors.bgGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Order Number $orderNumber, $productName',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// TRACK ORDER SECTION - ORANGE CONTAINER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primaryOrange,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'To track your order,',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Menu > Track My Order',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    PrimaryBtnWidget(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderTrackingPage(
                              orderId: "btn1",
                              trackingSteps: [],
                              placedDate: (DateTime.now()).toString(),
                              totalPrice: "0",
                              itemsCount: "0",
                            ),
                          ),
                        );
                      },
                      buttonText: "Track Now",
                      height: 36,
                      width: 110,
                      fontSize: 11,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            /// CONTACT DETAILS SECTION
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const Text(
                ' Contact Details',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.backgroundWhite,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name:',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textGreyDark,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              orderData['name'] ?? 'N/A',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email:',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textGreyDark,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              orderData['email'] ?? 'N/A',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Phone:',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textGreyDark,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              orderData['phone'] ?? 'N/A',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            /// DELIVERY INFORMATION SECTION
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const Text(
                ' Delivery Information',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.backgroundWhite,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'City:',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textGreyDark,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            orderData['city'] ?? 'N/A',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Address:',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textGreyDark,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            orderData['address'] ?? 'N/A',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            /// DELIVERY TYPE SECTION
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const Text(
                ' Delivery Type',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.backgroundWhite,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Standard Shipping',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textGreyDark,
                      ),
                    ),
                    // const SizedBox(width: 8),
                    const Spacer(),
                    Text(
                      orderData['shippingCost']?.toString() ?? '149',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            /// DELIVERY ESTIMATES SECTION
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const Text(
                ' Delivery Estimates',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.backgroundWhite,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Text(
                      ' Expected Delivery:',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textGreyDark,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      orderData['expectedDelivery'] ?? 'Oct 30 - Nov 01',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    // ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            /// ORDER SUMMARY SECTION
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const Text(
                ' Order Summary',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.backgroundWhite,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppColors.backgroundGreyLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.network(
                        productImage,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.image_not_supported_outlined,
                            color: AppColors.textGreyLight,
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productName,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Rs $productPrice',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Color',
                            style: TextStyle(
                              fontSize: 11,
                              color: AppColors.textGreyLight,
                            ),
                          ),
                          Text(
                            productColor,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            /// TOTAL PRICE & BUTTONS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: AppColors.bgGradient,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Total Price:',
                          style: TextStyle(fontSize: 13, color: Colors.white),
                        ),
                        const Spacer(),
                        Text(
                          'Rs ${orderData['totalPrice'] ?? productPrice}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Text(
                          'Paid Amount:',
                          style: TextStyle(fontSize: 13, color: Colors.white),
                        ),
                        const Spacer(),
                        Text(
                          'Rs ${orderData['paidAmount'] ?? 000}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Divider(color: AppColors.textGreyVeryLight, thickness: 1),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Text(
                          'Remaining Amount:',
                          style: TextStyle(fontSize: 13, color: Colors.white),
                        ),
                        const Spacer(),
                        Text(
                          'Rs ${NumberFormat('#,##0').format((int.tryParse(orderData['totalPrice'].toString().replaceAll(',', '')) ?? 0) - (int.tryParse(orderData['paidAmount'].toString().replaceAll(',', '')) ?? 0))}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.all(12),
              child: PrimaryBtnWidget(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyHomePage()),
                  );
                },
                buttonText: "Shop More",
              ),
            ),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
