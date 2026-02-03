import 'package:first/screens/order_address_confirm_page.dart';
import 'package:first/core/app_imports.dart';

class ShippingOption {
  final String id;
  final String title;
  final String description;
  final String price;

  ShippingOption({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
  });
}

class OrderShippingMethodPage extends StatefulWidget {
  final int orderId;
  final double itemsTotalAmount;

  const OrderShippingMethodPage({
    required this.orderId,
    required this.itemsTotalAmount,
    super.key,
  });

  @override
  State<OrderShippingMethodPage> createState() =>
      _OrderShippingMethodPageState();
}

class _OrderShippingMethodPageState extends State<OrderShippingMethodPage> {
  late List<ShippingOption> _shippingOptions;
  String _selectedShippingId = 'standard'; // ✅ FIX (was final before)

  @override
  void initState() {
    super.initState();
    _shippingOptions = [
      ShippingOption(
        id: 'standard',
        title: 'Standard Delivery',
        description:
            'Order will be delivered between 3 - 4 business days straight to your doorstep',
        price: '150',
      ),
      ShippingOption(
        id: 'nextday',
        title: 'Next Day Delivery',
        description:
            'Order will be delivered between 1 - 2 business days straight to your doorstep',
        price: '250',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGreyLight,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Shipping Method',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // ✅ STEPS WIDGET (UNCHANGED)
            const SizedBox(height: 16),

            _buildProgressIndicator(),

            const SizedBox(height: 24),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _shippingOptions.length,
                itemBuilder: (context, index) {
                  return _buildShippingOption(_shippingOptions[index]);
                },
              ),
            ),

            // ✅ PRIMARY BUTTON (UNCHANGED)
            Padding(
              padding: const EdgeInsets.all(10),
              child: PrimaryBtnWidget(
                onPressed: () {
                  // Get selected shipping option price
                  final selectedShipping = _shippingOptions.firstWhere(
                    (s) => s.id == _selectedShippingId,
                  );
                  final shippingPrice =
                      double.tryParse(selectedShipping.price) ?? 0.0;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderAddressConfirmPage(
                        orderId: widget.orderId,
                        itemsTotalAmount: widget.itemsTotalAmount,
                        shippingPrice: shippingPrice,
                      ),
                    ),
                  );
                },
                buttonText: "Next",
                width: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ---------------- STEPS ----------------
  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: const [
          StepCircle(active: true, label: "DELIVERY", stepNumber: 1),
          StepLine(active: false),
          StepCircle(active: false, label: "ADDRESS", stepNumber: 2),
          StepLine(active: false),
          StepCircle(active: false, label: "PAYMENT", stepNumber: 3),
        ],
      ),
    );
  }

  /// ---------------- SHIPPING OPTION ----------------
  Widget _buildShippingOption(ShippingOption option) {
    final bool isSelected = _selectedShippingId == option.id;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedShippingId = option.id;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          // color: AppColors.backgroundWhite,
          gradient: AppColors.secondaryBGGradientColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.bgPrimaryColor : AppColors.borderGrey,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
          ],
        ),
        child: Row(
          children: [
            // RADIO
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.bgPrimaryColor
                      : Colors.grey.shade400,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Container(
                      margin: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        // color: AppColors.primaryGreen,
                        gradient: AppColors.bgGradient,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),

            // CONTENT
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    option.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    option.description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            // PRICE
            // Text(
            //   option.price,
            //   style: const TextStyle(
            //     fontSize: 18,
            //     fontWeight: FontWeight.w600,
            //     color: AppColors.primaryGreen,
            //   ),
            // ),
            GradientText(text: option.price, fontSize: 18),
          ],
        ),
      ),
    );
  }
}
