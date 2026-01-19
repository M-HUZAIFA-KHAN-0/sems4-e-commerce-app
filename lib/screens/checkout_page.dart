// import 'package:first/screens/address_book_page.dart';
// import 'package:first/screens/order_shipping_method_page.dart';
// import 'package:flutter/material.dart';
// import '../widgets/widgets.dart';

// class CheckoutPage extends StatefulWidget {
//   const CheckoutPage({super.key});

//   @override
//   State<CheckoutPage> createState() => _CheckoutPageState();
// }

// class _CheckoutPageState extends State<CheckoutPage> {
//   int _selectedBottomIndex = 3;

//   // Checkout data
//   final String userName = "huzaifa";
//   final String userPhone = "3154699890";
//   final String userAddress =
//       "R196 sector 11c2 north karachi, Sector 11 - C 2, Karachi - North Karachi, Sindh";
//   final String storeName = "Order Items";

//   List<CartProductItem> checkoutItems = [
//     CartProductItem(
//       id: "1",
//       title:
//           "Owl light 12-80v universal Product with 3 function and white owl light with 5 function...",
//       variantText: "No Brand, black owl light and and white owl li...",
//       priceText: "Rs. 562",
//       quantity: 1,
//       stock: 5,
//       imageUrl: "https://picsum.photos/200?1",
//       isSelected: true,
//     ),
//     CartProductItem(
//       id: "2",
//       title:
//           "Owl light 12-80v universal Product with 3 function and white owl light with 5 function...",
//       variantText: "No Brand, black owl light and and white owl li...",
//       priceText: "Rs. 576",
//       quantity: 1,
//       stock: 5,
//       imageUrl: "https://picsum.photos/200?2",
//       isSelected: true,
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F5F5),
//       body: Column(
//         children: [
//           // Header with back button and title
//           _buildHeader(),

//           // Main content scrollable
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   // Address Section
//                   _AddressSection(
//                     name: userName,
//                     phone: userPhone,
//                     address: userAddress,
//                   ),

//                   // Store and Products Section
//                   _StoreProductsSection(items: checkoutItems),

//                   // Delivery Section
//                   const _DeliverySection(),

//                   // Summary Section
//                   _SummarySection(items: checkoutItems),

//                   // Voucher Section
//                   const _VoucherSection(),

//                   // Invoice Section
//                   // const _InvoiceSection(),
//                   const SizedBox(height: 80),
//                 ],
//               ),
//             ),
//           ),

//           // Sticky Total and Pay Button Section
//           _TotalPaymentSection(items: checkoutItems),
//         ],
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Container(
//       color: Colors.white,
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       child: Row(
//         children: [
//           IconButton(
//             icon: const Icon(Icons.arrow_back, color: Colors.black),
//             onPressed: () => Navigator.pop(context),
//           ),
//           const Expanded(
//             child: Text(
//               "Checkout",
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//           const SizedBox(width: 48), // Balance the back button
//         ],
//       ),
//     );
//   }
// }

// // Address Section Widget
// class _AddressSection extends StatelessWidget {
//   final String name;
//   final String phone;
//   final String address;

//   const _AddressSection({
//     required this.name,
//     required this.phone,
//     required this.address,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Icon(Icons.location_on, color: Color(0xFF2196F3), size: 24),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Expanded(
//                           child: Text(
//                             name,
//                             style: const TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => AddressScreen(),
//                               ),
//                             );
//                           },
//                           child: const Icon(
//                             Icons.edit,
//                             size: 20,
//                             color: Color(0xFFCCCCCC),
//                           ),
//                         ),
//                       ],
//                     ),
//                     // const SizedBox(height: 4),
//                     Text(
//                       phone,
//                       style: const TextStyle(
//                         fontSize: 14,
//                         color: Color(0xFF666666),
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       address,
//                       style: const TextStyle(
//                         fontSize: 13,
//                         color: Color(0xFF999999),
//                       ),
//                       maxLines: 3,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ],
//                 ),
//               ),
//               // const Icon(Icons.chevron_right, color: Color(0xFFCCCCCC)),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Store and Products Section Widget
// class _StoreProductsSection extends StatelessWidget {
//   final List<CartProductItem> items;

//   const _StoreProductsSection({required this.items});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(top: 10),
//       color: Colors.white,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: Row(
//               children: [
//                 const Icon(Icons.shopping_bag, color: Colors.black, size: 20),
//                 const SizedBox(width: 8),
//                 const Text(
//                   "Order Items",
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black,
//                   ),
//                 ),
//                 const Spacer(),
//                 Text(
//                   "${items.length} item${items.length > 1 ? 's' : ''}",
//                   style: const TextStyle(
//                     fontSize: 13,
//                     color: Color(0xFF999999),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const Divider(height: 1, color: Color(0xFFEEEEEE)),
//           Column(
//             children: items
//                 .asMap()
//                 .entries
//                 .map(
//                   (entry) => Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 12,
//                           horizontal: 12,
//                         ),
//                         child: _CheckoutProductCard(item: entry.value),
//                       ),
//                       if (entry.key < items.length - 1)
//                         const Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 10),
//                           child: Divider(height: 1, color: Color(0xFFEEEEEE)),
//                         ),
//                     ],
//                   ),
//                 )
//                 .toList(),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Checkout Product Card (reusing cart item structure)
// class _CheckoutProductCard extends StatelessWidget {
//   final CartProductItem item;

//   const _CheckoutProductCard({required this.item});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Product image
//         Container(
//           width: 80,
//           height: 80,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8),
//             color: const Color(0xFFF5F5F5),
//           ),
//           child: item.imageUrl != null
//               ? Image.network(
//                   item.imageUrl!,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) {
//                     return Container(
//                       color: const Color(0xFFEEEEEE),
//                       child: const Icon(Icons.image_not_supported),
//                     );
//                   },
//                 )
//               : const Icon(Icons.image_not_supported),
//         ),
//         const SizedBox(width: 12),
//         // Product details
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 item.title,
//                 style: const TextStyle(
//                   fontSize: 13,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black,
//                 ),
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               const SizedBox(height: 3),
//               Text(
//                 item.variantText,
//                 style: const TextStyle(fontSize: 12, color: Color(0xFF999999)),
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               const SizedBox(height: 4),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     item.priceText,
//                     style: const TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black,
//                     ),
//                   ),
//                   Text(
//                     "Qty: ${item.quantity}",
//                     style: const TextStyle(
//                       fontSize: 13,
//                       color: Color(0xFF666666),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// // Delivery Section Widget
// class _DeliverySection extends StatelessWidget {
//   const _DeliverySection();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(top: 12),
//       color: Colors.white,
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               border: Border.all(color: const Color(0xFFEEEEEE)),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             padding: const EdgeInsets.all(12),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   "Standard Delivery",
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Row(
//                   children: [
//                     const Icon(
//                       Icons.local_shipping,
//                       size: 16,
//                       color: Color(0xFF2196F3),
//                     ),
//                     const SizedBox(width: 8),
//                     const Text(
//                       "Guaranteed by 22-26 Jan",
//                       style: TextStyle(fontSize: 13, color: Color(0xFF666666)),
//                     ),
//                     const Spacer(),
//                     Text(
//                       "Rs. 165",
//                       style: const TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Summary Section Widget
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
//       color: Colors.white,
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Subtotal (${items.length} items)",
//                 style: const TextStyle(fontSize: 13, color: Color(0xFF666666)),
//               ),
//               Text(
//                 "Rs. ${merchandiseTotal.toStringAsFixed(0)}",
//                 style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black,
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
//                 style: TextStyle(fontSize: 13, color: Color(0xFF666666)),
//               ),
//               Text(
//                 "Rs. ${shippingFee.toStringAsFixed(0)}",
//                 style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Voucher Section Widget
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
//       color: Colors.white,
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               const Icon(
//                 Icons.card_giftcard,
//                 color: Color(0xFFFF6B6B),
//                 size: 20,
//               ),
//               const SizedBox(width: 8),
//               const Text(
//                 "Voucher & Code",
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black,
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
//                     "Enter your voucher code >",
//                     style: TextStyle(fontSize: 12, color: Color(0xFF2196F3)),
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
//                     color: Color(0xFFCCCCCC),
//                     size: 20,
//                   ),
//                 ),
//             ],
//           ),
//           if (_showVoucherInput) ...[
//             const SizedBox(height: 12),
//             TextField(
//               controller: _voucherController,
//               decoration: InputDecoration(
//                 hintText: "Enter voucher code",
//                 hintStyle: const TextStyle(color: Color(0xFFCCCCCC)),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: const BorderSide(
//                     color: Color.fromARGB(255, 0, 0, 0),
//                   ),
//                 ),
//                 contentPadding: const EdgeInsets.symmetric(
//                   horizontal: 12,
//                   vertical: 10,
//                 ),
//                 suffixIcon: _voucherController.text.isNotEmpty
//                     ? GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             _voucherController.clear();
//                           });
//                         },
//                         child: const Icon(
//                           Icons.clear,
//                           color: Color(0xFFCCCCCC),
//                           size: 18,
//                         ),
//                       )
//                     : null,
//               ),
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
//                         // Handle voucher code submission
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
//                       : const Color.fromARGB(255, 0, 0, 0),
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
//                     color: Colors.white,
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

// // Total and Payment Section Widget (Sticky Bottom Bar)
// class _TotalPaymentSection extends StatelessWidget {
//   final List<CartProductItem> items;

//   const _TotalPaymentSection({required this.items});

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
//     final total = merchandiseTotal + shippingFee;

//     return Container(
//       color: Colors.white,
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       child: Row(
//         children: [
//           // Total text section
//           Expanded(
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Text(
//                   "Total: ",
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Color(0xFF999999),
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 const SizedBox(width: 4),
//                 Text(
//                   "RS ${total.toStringAsFixed(0)}",
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: Color(0xFFFF6B3B),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // Place Order Button
//           PrimaryBtnWidget(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const OrderShippingMethodPage(),
//                 ),
//               );
//             },
//             buttonText: "Place order",
//             width: 150,
//             height: 40,
//           ),
//         ],
//       ),
//     );
//   }
// }
































import 'package:first/screens/order_shipping_method_page.dart';
import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int _selectedBottomIndex = 3;

  // Checkout data
  final String storeName = "Order Items";

  List<CartProductItem> checkoutItems = [
    CartProductItem(
      id: "1",
      title:
          "Owl light 12-80v universal Product with 3 function and white owl light with 5 function...",
      variantText: "No Brand, black owl light and and white owl li...",
      priceText: "Rs. 562",
      quantity: 1,
      stock: 5,
      imageUrl: "https://picsum.photos/200?1",
      isSelected: true,
    ),
    CartProductItem(
      id: "2",
      title:
          "Owl light 12-80v universal Product with 3 function and white owl light with 5 function...",
      variantText: "No Brand, black owl light and and white owl li...",
      priceText: "Rs. 576",
      quantity: 1,
      stock: 5,
      imageUrl: "https://picsum.photos/200?2",
      isSelected: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          // Header with back button and title
          _buildHeader(),

          // Main content scrollable
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Store and Products Section
                  _StoreProductsSection(items: checkoutItems),

                  // Summary Section
                  _SummarySection(items: checkoutItems),

                  // Voucher Section
                  const _VoucherSection(),

                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),

          // Sticky Total and Pay Button Section
          _TotalPaymentSection(items: checkoutItems),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          const Expanded(
            child: Text(
              "Checkout",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 48), // Balance the back button
        ],
      ),
    );
  }
}

// Store and Products Section Widget
class _StoreProductsSection extends StatelessWidget {
  final List<CartProductItem> items;

  const _StoreProductsSection({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                const Icon(Icons.shopping_bag, color: Colors.black, size: 20),
                const SizedBox(width: 8),
                const Text(
                  "Order Items",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                Text(
                  "${items.length} item${items.length > 1 ? 's' : ''}",
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF999999),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFEEEEEE)),
          Column(
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
                          child: Divider(height: 1, color: Color(0xFFEEEEEE)),
                        ),
                    ],
                  ),
                )
                .toList(),
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
            color: const Color(0xFFF5F5F5),
          ),
          child: item.imageUrl != null
              ? Image.network(
                  item.imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: const Color(0xFFEEEEEE),
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
                  color: Colors.black,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 3),
              Text(
                item.variantText,
                style: const TextStyle(fontSize: 12, color: Color(0xFF999999)),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
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
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "Qty: ${item.quantity}",
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF666666),
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
class _SummarySection extends StatelessWidget {
  final List<CartProductItem> items;

  const _SummarySection({required this.items});

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
    final shippingFee = 165.0;

    return Container(
      margin: const EdgeInsets.only(top: 12),
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Subtotal (${items.length} items)",
                style: const TextStyle(fontSize: 13, color: Color(0xFF666666)),
              ),
              Text(
                "Rs. ${merchandiseTotal.toStringAsFixed(0)}",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Divider(height: 1, color: Color(0xFFEEEEEE)),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Shipping Fee",
                style: TextStyle(fontSize: 13, color: Color(0xFF666666)),
              ),
              Text(
                "Rs. ${shippingFee.toStringAsFixed(0)}",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Voucher Section Widget
class _VoucherSection extends StatefulWidget {
  const _VoucherSection();

  @override
  State<_VoucherSection> createState() => _VoucherSectionState();
}

class _VoucherSectionState extends State<_VoucherSection> {
  bool _showVoucherInput = false;
  final TextEditingController _voucherController = TextEditingController();

  @override
  void dispose() {
    _voucherController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.card_giftcard,
                color: Color(0xFFFF6B6B),
                size: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                "Voucher & Code",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              if (!_showVoucherInput)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _showVoucherInput = true;
                    });
                  },
                  child: const Text(
                    "Enter your voucher code >",
                    style: TextStyle(fontSize: 12, color: Color(0xFF2196F3)),
                  ),
                ),
              if (_showVoucherInput)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _showVoucherInput = false;
                      _voucherController.clear();
                    });
                  },
                  child: const Icon(
                    Icons.close,
                    color: Color(0xFFCCCCCC),
                    size: 20,
                  ),
                ),
            ],
          ),
          if (_showVoucherInput) ...[
            const SizedBox(height: 12),
            TextField(
              controller: _voucherController,
              decoration: InputDecoration(
                hintText: "Enter voucher code",
                hintStyle: const TextStyle(color: Color(0xFFCCCCCC)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                suffixIcon: _voucherController.text.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            _voucherController.clear();
                          });
                        },
                        child: const Icon(
                          Icons.clear,
                          color: Color(0xFFCCCCCC),
                          size: 18,
                        ),
                      )
                    : null,
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: _voucherController.text.isEmpty
                    ? null
                    : () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Voucher code applied: ${_voucherController.text}',
                            ),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                        setState(() {
                          _showVoucherInput = false;
                        });
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _voucherController.text.isEmpty
                      ? const Color(0xFFEEEEEE)
                      : const Color.fromARGB(255, 0, 0, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Apply",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// Total and Payment Section Widget (Sticky Bottom Bar)
class _TotalPaymentSection extends StatelessWidget {
  final List<CartProductItem> items;

  const _TotalPaymentSection({required this.items});

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
    final shippingFee = 165.0;
    final total = merchandiseTotal + shippingFee;

    return Container(
      color: Colors.white,
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
                    color: Color(0xFF999999),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  "RS ${total.toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFF6B3B),
                  ),
                ),
              ],
            ),
          ),
          // Place Order Button
          PrimaryBtnWidget(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OrderShippingMethodPage(),
                ),
              );
            },
            buttonText: "Place order",
            width: 150,
            height: 40,
          ),
        ],
      ),
    );
  }
}
