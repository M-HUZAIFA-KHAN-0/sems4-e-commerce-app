import 'package:first/screens/order_shipping_method_page.dart';
import 'package:first/core/app_imports.dart';
import 'package:first/services/api/cart_service.dart';
import 'package:first/services/api/order_service.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  // Checkout data
  final String storeName = "Order Items";
  final UserSessionManager _sessionManager = UserSessionManager();
  final CartService _cartService = CartService();
  final OrderService _orderService = OrderService();

  bool _isLoading = true;
  bool _isPlacingOrder = false;
  List<CartProductItem> checkoutItems = [];

  @override
  void initState() {
    super.initState();
    _fetchCheckoutData();
  }

  Future<void> _fetchCheckoutData() async {
    try {
      final userId = _sessionManager.userId;
      if (userId == null || userId <= 0) {
        if (!mounted) return;
        setState(() => _isLoading = false);
        return;
      }

      final cartData = await _cartService.getCartByUserId(userId: userId);
      if (cartData == null) {
        if (!mounted) return;
        setState(() => _isLoading = false);
        return;
      }

      final items =
          (cartData['items'] as List?)?.cast<Map<String, dynamic>>() ?? [];

      print('📦 Checkout Data: ${items.length} items found');
      final mappedItems = items.map((item) => _mapApiToCartItem(item)).toList();

      if (!mounted) return;
      setState(() {
        checkoutItems = mappedItems;
        _isLoading = false;
      });
      print('✅ Checkout UI updated with ${checkoutItems.length} items');
    } catch (e) {
      print('[CheckoutPage] Error fetching cart: $e');
      if (!mounted) return;
      setState(() => _isLoading = false);
    }
  }

  Future<void> _placeOrder() async {
    try {
      // Prevent multiple clicks
      if (_isPlacingOrder) return;

      // Get user ID
      final userId = _sessionManager.userId;
      if (userId == null || userId <= 0) {
        _showError('User not logged in');
        return;
      }

      // Calculate total amount
      double totalAmount = 0;
      for (final item in checkoutItems) {
        final price =
            double.tryParse(
              item.priceText.replaceAll('PKR ', '').replaceAll('RS ', ''),
            ) ??
            0;
        totalAmount += price * item.quantity;
      }

      print(
        '💳 [CheckoutPage] Placing order - UserId: $userId, Total: $totalAmount, Items: ${checkoutItems.length}',
      );

      // Update UI to show loading
      setState(() => _isPlacingOrder = true);

      // STEP 1: Create Order
      print('📝 [CheckoutPage] STEP 1: Creating order...');
      final orderResult = await _orderService.createOrder(
        userId: userId,
        totalAmount: totalAmount,
      );

      if (orderResult == null) {
        _showError('Failed to create order');
        setState(() => _isPlacingOrder = false);
        return;
      }

      final orderId = orderResult['orderId'];
      print('✅ [CheckoutPage] Order created - OrderId: $orderId');

      // STEP 2: Create Order Items
      print('📝 [CheckoutPage] STEP 2: Creating order items...');
      final itemsData = checkoutItems
          .map(
            (item) => {
              'variantId': item.variantId ?? 0,
              'quantity': item.quantity,
              'variantSpecificationOptionsId':
                  item.variantSpecificationOptionsId ?? 0,
            },
          )
          .toList();

      print('🛒 [CheckoutPage] Items to create: $itemsData');

      final itemsCreated = await _orderService.createAllOrderItems(
        orderId: orderId,
        items: itemsData,
      );

      if (!itemsCreated) {
        _showError('Failed to create order items');
        setState(() => _isPlacingOrder = false);
        return;
      }

      print('✅ [CheckoutPage] All order items created successfully');

      // SUCCESS: Navigate to Order Shipping Method Page
      if (!mounted) return;
      setState(() => _isPlacingOrder = false);

      print('🎉 [CheckoutPage] Order creation complete - Navigating...');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderShippingMethodPage(
            orderId: orderId,
            itemsTotalAmount: totalAmount,
          ),
        ),
      );
    } catch (e) {
      print('❌ [CheckoutPage] Error placing order: $e');
      _showError('Error placing order: $e');
      setState(() => _isPlacingOrder = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  CartProductItem _mapApiToCartItem(Map<String, dynamic> item) {
    // Extract variant specifications from API response
    final variantSpecs = item['variantSpecifications'] as List? ?? [];
    final variantSpecificationOptionsId =
        item['variantSpecificationOptionsId'] ?? 0;
    final variantId = item['variantId'] as int? ?? 0;

    String ram = '';
    String storage = '';
    String color = '';

    // Extract RAM and Storage
    for (final spec in variantSpecs) {
      if (spec['specificationName'] == 'RAM') {
        ram = spec['optionValue'];
      }
      if (spec['specificationName'] == 'Storage') {
        storage = spec['optionValue'];
      }
    }

    // Build RAM-Storage text
    final ramStorageText = (ram.isNotEmpty && storage.isNotEmpty)
        ? '$ram - $storage'
        : 'Standard';

    // Extract Color - MATCH optionId with variantSpecificationOptionsId
    for (final spec in variantSpecs) {
      if (spec['specificationName'] == 'Color' &&
          spec['optionId'] == variantSpecificationOptionsId) {
        color = spec['optionValue'];
        break; // Found the matching color
      }
    }

    final productName = item['productName']?.toString() ?? 'Product';
    final price = double.tryParse(item['price']?.toString() ?? '0') ?? 0;
    final quantity = item['quantity'] ?? 1;
    final imageUrl = item['image']?.toString() ?? '';
    final cartItemId = item['cartItemId'] ?? 0;

    print(
      '🛒 [CheckoutPage] Product: $productName, RAM-Storage: $ramStorageText, Color: $color, variantId: $variantId, variantSpecOptionId: $variantSpecificationOptionsId',
    );

    return CartProductItem(
      id: cartItemId.toString(),
      title: productName,
      ramStorageText: ramStorageText,
      color: color,
      priceText: 'PKR ${price.toStringAsFixed(2)}',
      quantity: quantity,
      stock: 100,
      imageUrl: imageUrl,
      isSelected: true,
      variantId: variantId,
      variantSpecificationOptionsId: variantSpecificationOptionsId,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: AppColors.backgroundGrey,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundWhite,
          elevation: 0,
          foregroundColor: AppColors.textBlack87,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, size: 20),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          title: const Text(
            'Checkout',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        foregroundColor: AppColors.textBlack87,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text(
          'Checkout',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Store and Products Section
                  _StoreProductsSection(items: checkoutItems),

                  // Summary Section
                  // _SummarySection(items: checkoutItems),

                  // Voucher Section
                  // const _VoucherSection(),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),

          // Sticky Total and Pay Button Section
          _TotalPaymentSection(
            items: checkoutItems,
            isPlacingOrder: _isPlacingOrder,
            onPlaceOrder: _placeOrder,
          ),
        ],
      ),
    );
  }

  // Widget _buildHeader() {
  //   return Container(
  //     color: AppColors.backgroundWhite,
  //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  //     child: Row(
  //       children: [
  //         IconButton(
  //           icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
  //           onPressed: () => Navigator.pop(context),
  //         ),
  //         const Expanded(
  //           child: Text(
  //             "Checkout",
  //             style: TextStyle(
  //               fontSize: 20,
  //               fontWeight: FontWeight.w600,
  //               color: AppColors.textBlack,
  //             ),
  //             textAlign: TextAlign.center,
  //           ),
  //         ),
  //         const SizedBox(width: 48), // Balance the back button
  //       ],
  //     ),
  //   );
  // }
}

// Store and Products Section Widget
class _StoreProductsSection extends StatelessWidget {
  final List<CartProductItem> items;

  const _StoreProductsSection({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      // color: AppColors.backgroundWhite,
      // decoration: BoxDecoration(
      //   gradient: AppColors.secondaryBGGradientColor,
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              // gradient: AppColors.bgLightGradientColor,
              gradient: AppColors.bgGradient,
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Icon(Icons.store, size: 22, color: AppColors.backgroundWhite),
                  const SizedBox(width: 8),
                  Text(
                    "Order Items",
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.backgroundWhite,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "${items.length} item${items.length > 1 ? 's' : ''}",
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.backgroundWhite,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 4, color: Color(0xFFEEEEEE)),
          Container(
            decoration: BoxDecoration(
              gradient: AppColors.secondaryBGGradientColor,
            ),
            child: Column(
              children: items
                  .asMap()
                  .entries
                  .map(
                    (entry) => Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 12,
                          ),
                          child: _CheckoutProductCard(item: entry.value),
                        ),
                        if (entry.key < items.length - 1)
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Divider(
                              height: 0.5,
                              color: Color(0xFFEEEEEE),
                            ),
                          ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// Checkout Product Card (reusing cart item structure)
class _CheckoutProductCard extends StatelessWidget {
  final CartProductItem item;

  const _CheckoutProductCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product image
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.backgroundGrey,
          ),
          child: item.imageUrl != null
              ? Image.network(
                  item.imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppColors.borderGreyDivider,
                      child: const Icon(Icons.image_not_supported),
                    );
                  },
                )
              : const Icon(Icons.image_not_supported),
        ),
        const SizedBox(width: 12),
        // Product details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textBlack,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  if (item.ramStorageText!.isNotEmpty)
                    ShowVariantSpecsWidget(variantText: item.ramStorageText!),

                  if (item.ramStorageText!.isNotEmpty && item.color!.isNotEmpty)
                    const SizedBox(width: 6),

                  if (item.color!.isNotEmpty)
                    ShowVariantSpecsWidget(variantText: item.color!),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.priceText,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textBlack,
                    ),
                  ),
                  Text(
                    "Qty: ${item.quantity}",
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textGreyMedium,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Summary Section Widget
// class _SummarySection extends StatelessWidget {
//   final List<CartProductItem> items;

//   const _SummarySection({required this.items});

//   double _parsePrice(String priceText) {
//     var s = priceText.replaceAll(RegExp(r'[^0-9,\.]'), '');
//     if (s.isEmpty) return 0;

//     final lastComma = s.lastIndexOf(',');
//     final lastDot = s.lastIndexOf('.');
//     final commaIsDecimal = lastComma > lastDot;

//     if (commaIsDecimal) {
//       s = s.replaceAll('.', '');
//       s = s.replaceAll(',', '.');
//     } else {
//       s = s.replaceAll(',', '');
//     }

//     return double.tryParse(s) ?? 0;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final merchandiseTotal = items.fold<double>(
//       0,
//       (sum, item) => sum + (_parsePrice(item.priceText) * item.quantity),
//     );
//     final shippingFee = 165.0;

//     return Container(
//       margin: const EdgeInsets.only(top: 12),
//       // color: AppColors.backgroundWhite,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(gradient: AppColors.secondaryBGGradientColor),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Subtotal (${items.length} items)",
//                 style: const TextStyle(
//                   fontSize: 13,
//                   color: AppColors.textGreyDark,
//                 ),
//               ),
//               Text(
//                 "Rs. ${merchandiseTotal.toStringAsFixed(0)}",
//                 style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                   color: AppColors.textBlack,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 6),
//           const Divider(height: 1, color: Color(0xFFEEEEEE)),
//           const SizedBox(height: 6),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 "Shipping Fee",
//                 style: TextStyle(fontSize: 13, color: AppColors.textGreyDark),
//               ),
//               Text(
//                 "Rs. ${shippingFee.toStringAsFixed(0)}",
//                 style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                   color: AppColors.textBlack,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// Voucher Section Widget
// class _VoucherSection extends StatefulWidget {
//   const _VoucherSection();

//   @override
//   State<_VoucherSection> createState() => _VoucherSectionState();
// }

// class _VoucherSectionState extends State<_VoucherSection> {
//   bool _showVoucherInput = false;
//   final TextEditingController _voucherController = TextEditingController();

//   @override
//   void dispose() {
//     _voucherController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(top: 12),
//       // color: AppColors.backgroundWhite,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(gradient: AppColors.secondaryBGGradientColor),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               GradientIconWidget(icon: Icons.card_giftcard, size: 20),
//               const SizedBox(width: 8),
//               const Text(
//                 "Voucher & Code",
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                   color: AppColors.textBlack,
//                 ),
//               ),
//               const Spacer(),
//               if (!_showVoucherInput)
//                 GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       _showVoucherInput = true;
//                     });
//                   },
//                   child: const Text(
//                     "Voucher code >",
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: AppColors.secondaryColor1,
//                     ),
//                   ),
//                 ),
//               if (_showVoucherInput)
//                 GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       _showVoucherInput = false;
//                       _voucherController.clear();
//                     });
//                   },
//                   child: const Icon(
//                     Icons.close,
//                     color: AppColors.textGreyLightest,
//                     size: 20,
//                   ),
//                 ),
//             ],
//           ),
//           if (_showVoucherInput) ...[
//             const SizedBox(height: 12),
//             TextField(
//               controller: _voucherController,
//               decoration:
//                   OutlineInputDecorationHelper.createInputDecoration(
//                     labelText: 'Voucher Code',
//                     hintText: "Enter voucher code",
//                     borderColor: AppColors.borderGreyDivider,
//                     focusedBorderColor: AppColors.formBlack,
//                     hintColor: AppColors.textGreyLightest,
//                     contentPadding: const EdgeInsets.symmetric(
//                       horizontal: 12,
//                       vertical: 10,
//                     ),
//                     suffixIcon: _voucherController.text.isNotEmpty
//                         ? Icons.clear
//                         : null,
//                   ).copyWith(
//                     suffixIcon: _voucherController.text.isNotEmpty
//                         ? GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 _voucherController.clear();
//                               });
//                             },
//                             child: const Icon(
//                               Icons.clear,
//                               color: AppColors.textGreyLightest,
//                               size: 18,
//                             ),
//                           )
//                         : null,
//                   ),
//               onChanged: (value) {
//                 setState(() {});
//               },
//             ),
//             const SizedBox(height: 8),
//             SizedBox(
//               width: double.infinity,
//               height: 40,
//               child: ElevatedButton(
//                 onPressed: _voucherController.text.isEmpty
//                     ? null
//                     : () {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text(
//                               'Voucher code applied: ${_voucherController.text}',
//                             ),
//                             duration: const Duration(seconds: 2),
//                           ),
//                         );
//                         setState(() {
//                           _showVoucherInput = false;
//                         });
//                       },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: _voucherController.text.isEmpty
//                       ? const Color(0xFFEEEEEE)
//                       : AppColors.formBlack,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(26),
//                   ),
//                   elevation: 0,
//                 ),
//                 child: const Text(
//                   "Apply",
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.backgroundWhite,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }

// Total and Payment Section Widget (Sticky Bottom Bar)
class _TotalPaymentSection extends StatelessWidget {
  final List<CartProductItem> items;
  final bool isPlacingOrder;
  final VoidCallback onPlaceOrder;

  const _TotalPaymentSection({
    required this.items,
    required this.isPlacingOrder,
    required this.onPlaceOrder,
  });

  double _parsePrice(String priceText) {
    var s = priceText.replaceAll(RegExp(r'[^0-9,\.]'), '');
    if (s.isEmpty) return 0;

    final lastComma = s.lastIndexOf(',');
    final lastDot = s.lastIndexOf('.');
    final commaIsDecimal = lastComma > lastDot;

    if (commaIsDecimal) {
      s = s.replaceAll('.', '');
      s = s.replaceAll(',', '.');
    } else {
      s = s.replaceAll(',', '');
    }

    return double.tryParse(s) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final merchandiseTotal = items.fold<double>(
      0,
      (sum, item) => sum + (_parsePrice(item.priceText) * item.quantity),
    );
    // final shippingFee = 165.0;
    final shippingFee = 0;
    final total = merchandiseTotal + shippingFee;

    return Container(
      // color: AppColors.backgroundWhite,
      decoration: BoxDecoration(gradient: AppColors.bgLightGradientColor),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Total text section
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Total: ",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textGreyDark,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 4),
                // GradientText(
                //   text: "Rs. ${total.toStringAsFixed(0)}",
                //   fontSize: 16,
                // ),
                Text(
                  "RS ${total.toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textBlack,
                  ),
                ),
              ],
            ),
          ),
          // Place Order Button
          PrimaryBtnWidget(
            onPressed: () => isPlacingOrder ? null : onPlaceOrder(),
            buttonText: isPlacingOrder ? "Creating..." : "Place order",
            width: 140,
            height: 40,
          ),
        ],
      ),
    );
  }
}
