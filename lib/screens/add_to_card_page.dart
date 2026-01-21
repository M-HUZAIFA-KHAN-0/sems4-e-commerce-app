import 'package:first/main-home.dart';
import 'package:first/screens/checkout_page.dart';
import 'package:first/screens/notification_page.dart';
import 'package:first/screens/profile_page.dart';
import 'package:first/screens/wishlist_page.dart';
import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import '../app_colors.dart';

class CartPageExample extends StatefulWidget {
  const CartPageExample({super.key});

  @override
  State<CartPageExample> createState() => _CartPageExampleState();
}

class _CartPageExampleState extends State<CartPageExample> {
  int _selectedBottomIndex = 3; // Set to 3 for Bag tab

  // Parent controls initial data + stock values
  List<CartProductItem> cartItems = [
    CartProductItem(
      id: "1",
      title: "Air pods max by Apple",
      variantText: "Grey",
      priceText: "\$ 1999,99",
      quantity: 1,
      stock: 2,
      imageUrl: "https://picsum.photos/200?1",
      isSelected: true,
    ),
    CartProductItem(
      id: "2",
      title: "Monitor LG 22”inc 4K 120Fps",
      variantText: "120 Fps",
      priceText: "\$ 299,99",
      quantity: 1,
      stock: 5,
      imageUrl: "https://picsum.photos/200?2",
      isSelected: true,
    ),
    CartProductItem(
      id: "3",
      title: "Earphones for monitor",
      variantText: "Combo",
      priceText: "\$ 199,99",
      quantity: 1,
      stock: 1,
      imageUrl: "https://picsum.photos/200?3",
      isSelected: true,
    ),
    CartProductItem(
      id: "3",
      title: "Earphones for monitor",
      variantText: "Combo",
      priceText: "\$ 199,99",
      quantity: 1,
      stock: 1,
      imageUrl: "https://picsum.photos/200?3",
      isSelected: true,
    ),
    CartProductItem(
      id: "3",
      title: "Earphones for monitor",
      variantText: "Combo",
      priceText: "\$ 199,99",
      quantity: 1,
      stock: 1,
      imageUrl: "https://picsum.photos/200?3",
      isSelected: true,
    ),
    CartProductItem(
      id: "3",
      title: "Earphones for monitor",
      variantText: "Combo",
      priceText: "\$ 199,99",
      quantity: 1,
      stock: 1,
      imageUrl: "https://picsum.photos/200?3",
      isSelected: true,
    ),
    CartProductItem(
      id: "3",
      title: "Earphones for monitor",
      variantText: "Combo",
      priceText: "\$ 199,99",
      quantity: 1,
      stock: 1,
      imageUrl: "https://picsum.photos/200?3",
      isSelected: true,
    ),
  ];

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

  String _formatMoney(double value) {
    final fixed = value.toStringAsFixed(2).replaceAll('.', ',');
    return "\$ $fixed";
  }

  @override
  Widget build(BuildContext context) {
    // ✅ calculate ONLY selected items
    final selectedItems = cartItems.where((e) => e.isSelected).toList();
    final selectedCount = selectedItems.length;

    final totalSelected = selectedItems.fold<double>(
      0,
      (sum, item) => sum + (_parsePrice(item.priceText) * item.quantity),
    );

    final totalText = _formatMoney(totalSelected);

    return Scaffold(
      backgroundColor: AppColors.backgroundGreyLighter,
      appBar: AppBar(
        title: const Text("Cart"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: CartListWidget(
              items: cartItems,
              onChanged: (updatedItems) {
                setState(() {
                  cartItems = updatedItems;
                });
              },
              // emptyMessage: "Your cart is empty",
              emptyMessage:
                  "Your bag is empty.\nWhen you add products, they'll\nappear here.",
            ),
          ),

          // ✅ Collapsible Order Summary (dropdown)
          if (cartItems.isNotEmpty)
            OrderSummaryDropdown(
              items: cartItems,
              selectedItems: selectedItems,
              itemCount: selectedCount,
              totalText: totalText,
              parsePrice: _parsePrice,
              formatMoney: _formatMoney,
              onSelectPayment: () {
                // TODO: handle payment method selection
              },
            ),
        ],
      ),
      bottomNavigationBar: BottomBarWidget(
        isLoggedIn: false,
        currentIndex: _selectedBottomIndex,
        onIndexChanged: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyHomePage()),
            );
          } else if (index == 1) {
            // Navigate to Profile page when Profile icon is clicked
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NotificationPage()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WishlistPage()),
            );
          } else if (index == 4) {
            // Navigate to Profile page when Profile icon is clicked
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          } else {
            setState(() {
              _selectedBottomIndex = index;
            });
          }
          setState(() {
            _selectedBottomIndex = index;
          });
        },
      ),
    );
  }
}

/// ✅ Dropdown Order Summary:
/// - Initially CLOSED (only header line visible)
/// - Tap anywhere on header to open/close
/// - Expands from bottom to top with smooth animation
/// - Shows each selected item's total price (price × quantity)
/// - Shows grand total at the bottom
class OrderSummaryDropdown extends StatefulWidget {
  const OrderSummaryDropdown({
    super.key,
    required this.items,
    required this.selectedItems,
    required this.itemCount,
    required this.totalText,
    required this.parsePrice,
    required this.formatMoney,
    required this.onSelectPayment,
  });

  final List<CartProductItem> items;
  final List<CartProductItem> selectedItems;
  final int itemCount;
  final String totalText;
  final Function(String) parsePrice;
  final Function(double) formatMoney;
  final VoidCallback onSelectPayment;

  @override
  State<OrderSummaryDropdown> createState() => _OrderSummaryDropdownState();
}

class _OrderSummaryDropdownState extends State<OrderSummaryDropdown>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;

  static const Color _divider = Color(0xFFE7E9EE);
  static const Color _labelGrey = Color(0xFF9AA0A6);
  static const Color _buttonGreen = Color(0xFF63C7A8);

  void _toggle() {
    setState(() => _expanded = !_expanded);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 12,
            offset: Offset(0, -3),
          ),
        ],
      ),
      // Keep padding consistent with SS
      padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header line (clickable anywhere)
          // InkWell(
          //   onTap: _toggle,
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(vertical: 4),
          //     child: Row(
          //       children: [
          //         Expanded(
          //           child: const Text(
          //             "Order Summary",
          //             style: TextStyle(
          //               fontSize: 14,
          //               fontWeight: FontWeight.w700,
          //               color: Colors.black87,
          //             ),
          //           ),
          //         ),
          //         AnimatedRotation(
          //           turns: _expanded ? 0.5 : 0.0,
          //           duration: const Duration(milliseconds: 220),
          //           curve: Curves.easeOut,
          //           child: const Icon(
          //             Icons.keyboard_arrow_up,
          //             size: 22,
          //             color: Colors.black54,
          //           ),
          //         ),
          //         PrimaryBtnWidget(
          //           height: 40,
          //           width: 190,
          //           buttonText: "Select payment method",
          //           onPressed: () {
          //             Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                 builder: (context) => const CheckoutPage(),
          //               ),
          //             );
          //           },
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          InkWell(
            onTap: _toggle, // Order summary + arrow click
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  // Order Summary
                  Expanded(
                    child: Row(
                      children: [
                        const Text(
                          "Order Summary",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(width: 6),

                        // Arrow right after text
                        AnimatedRotation(
                          turns: _expanded ? 0.5 : 0.0,
                          duration: const Duration(milliseconds: 220),
                          curve: Curves.easeOut,
                          child: const Icon(
                            Icons.keyboard_arrow_up,
                            size: 22,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Button (only when NOT expanded)
                  if (!_expanded)
                    PrimaryBtnWidget(
                      height: 43,
                      width: 150,
                      buttonText: "Checkout",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CheckoutPage(),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ),

          // Expanding content (bottom -> top feel: it appears above bottom edge)
          ClipRect(
            child: AnimatedAlign(
              duration: const Duration(milliseconds: 280),
              curve: Curves.easeInOut,
              alignment: _expanded ? Alignment.topCenter : Alignment.topCenter,
              heightFactor: _expanded ? 1.0 : 0.0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 5),
                  const Divider(height: 1, thickness: 1, color: _divider),
                  const SizedBox(height: 10),

                  // ✅ Item details with individual totals
                  if (widget.selectedItems.length > 3)
                    SizedBox(
                      height: 150,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: List.generate(widget.selectedItems.length, (
                            index,
                          ) {
                            final item = widget.selectedItems[index];
                            final itemTotal =
                                widget.parsePrice(item.priceText) *
                                item.quantity;
                            final itemTotalText = widget.formatMoney(itemTotal);

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: item.priceText,
                                                style: const TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w600,
                                                  color: _labelGrey,
                                                ),
                                              ),
                                              const TextSpan(
                                                text: " × ",
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w600,
                                                  color: _labelGrey,
                                                ),
                                              ),
                                              TextSpan(
                                                text: "${item.quantity}",
                                                style: const TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w600,
                                                  color: _labelGrey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    itemTotalText,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
                    )
                  else
                    Column(
                      children: List.generate(widget.selectedItems.length, (
                        index,
                      ) {
                        final item = widget.selectedItems[index];
                        final itemTotal =
                            widget.parsePrice(item.priceText) * item.quantity;
                        final itemTotalText = widget.formatMoney(itemTotal);

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: item.priceText,
                                            style: const TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                              color: _labelGrey,
                                            ),
                                          ),
                                          const TextSpan(
                                            text: " × ",
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                              color: _labelGrey,
                                            ),
                                          ),
                                          TextSpan(
                                            text: "${item.quantity}",
                                            style: const TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                              color: _labelGrey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                itemTotalText,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),

                  const SizedBox(height: 10),
                  const Divider(height: 1, thickness: 1, color: _divider),
                  const SizedBox(height: 10),

                  // ✅ Grand total row
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Total price (${widget.itemCount} items)",
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.formBlack,
                          ),
                        ),
                      ),
                      Text(
                        widget.totalText,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Button
                  PrimaryBtnWidget(
                    height: 43,
                    buttonText: "Checkout",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CheckoutPage(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
          // PrimaryBtnWidget(
          //                 buttonText: "Select payment method",
          //                 onPressed: (){
          //                   Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckoutPage()));
          //                 }
          //               ),
        ],
      ),
    );
  }
}
