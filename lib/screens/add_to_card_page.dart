import 'package:first/core/app_imports.dart';
import 'package:first/services/api/cart_service.dart';

class CartPageExample extends StatefulWidget {
  const CartPageExample({super.key});

  @override
  State<CartPageExample> createState() => _CartPageExampleState();
}

class _CartPageExampleState extends State<CartPageExample> {
  int _selectedBottomIndex = 3; // Set to 3 for Bag tab
  final UserSessionManager _sessionManager = UserSessionManager();
  final CartService _cartService = CartService();

  bool _isLoading = true;
  String? _cartId;
  List<CartProductItem> cartItems = [];

  @override
  void initState() {
    super.initState();
    _fetchCartData();
  }

  Future<void> _fetchCartData() async {
    try {
      final userId = _sessionManager.userId;
      if (userId == null || userId <= 0) {
        if (!mounted) return;
        setState(() => _isLoading = false);
        return;
      }

      // Fetch cart data from API
      final cartData = await _cartService.getCartByUserId(userId: userId);
      if (cartData == null) {
        if (!mounted) return;
        setState(() => _isLoading = false);
        return;
      }

      _cartId = cartData['cartId']?.toString() ?? cartData['id']?.toString();
      final items =
          (cartData['items'] as List?)?.cast<Map<String, dynamic>>() ?? [];

      print('📦 Cart Data: ${items.length} items found');
      final mappedItems = items.map((item) => _mapApiToCartItem(item)).toList();

      if (!mounted) return;
      setState(() {
        cartItems = mappedItems;
        _isLoading = false;
      });
      print('✅ Cart UI updated with ${cartItems.length} items');
    } catch (e) {
      print('[CartPageExample] Error fetching cart: $e');
      if (!mounted) return;
      setState(() => _isLoading = false);
    }
  }

  CartProductItem _mapApiToCartItem(Map<String, dynamic> item) {
    // Extract variant specifications from API response
    final variantSpecs = item['variantSpecifications'] as List? ?? [];
    final variantSpecificationOptionsId =
        item['variantSpecificationOptionsId'] ?? 0;

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
      '🛒 [CartPageExample] Product: $productName, RAM-Storage: $ramStorageText, Color: $color, variantSpecOptionId: $variantSpecificationOptionsId',
    );

    final priceText = _formatMoney(price);

    return CartProductItem(
      id: cartItemId.toString(),
      title: productName,
      ramStorageText: ramStorageText,
      color: color,
      priceText: priceText,
      quantity: quantity,
      stock: 100,
      imageUrl: imageUrl,
      isSelected: true,
    );
  }

  Future<void> _updateQuantity(int cartItemId, int newQuantity) async {
    if (newQuantity <= 0) {
      await _deleteItem(cartItemId);
      return;
    }

    try {
      final success =
          await _cartService.updateCartItem(
                cartItemId: cartItemId,
                quantity: newQuantity,
              )
              as bool?;

      if ((success ?? false) && mounted) {
        setState(() {
          final idx = cartItems.indexWhere(
            (e) => e.id == cartItemId.toString(),
          );
          if (idx >= 0) {
            cartItems[idx] = cartItems[idx].copyWith(quantity: newQuantity);
          }
        });
      }
    } catch (e) {
      print('[CartPageExample] Error updating quantity: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update quantity: $e')),
        );
      }
    }
  }

  Future<void> _deleteItem(int cartItemId) async {
    try {
      final success =
          await _cartService.deleteCartItem(cartItemId: cartItemId) as bool?;

      if ((success ?? false) && mounted) {
        setState(() {
          cartItems.removeWhere((e) => e.id == cartItemId.toString());
        });
      }
    } catch (e) {
      print('[CartPageExample] Error deleting item: $e');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to delete item: $e')));
      }
    }
  }

  Future<void> _deleteMultipleItems(List<int> cartItemIds) async {
    try {
      final success =
          await _cartService.deleteMultipleCartItems(cartItemIds: cartItemIds)
              as bool?;

      if ((success ?? false) && mounted) {
        setState(() {
          final cartItemIdStrs = cartItemIds.map((id) => id.toString()).toSet();
          cartItems.removeWhere((e) => cartItemIdStrs.contains(e.id));
        });
      }
    } catch (e) {
      print('[CartPageExample] Error deleting items: $e');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to delete items: $e')));
      }
    }
  }

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
    final isLoggedIn = _sessionManager.isLoggedIn;

    return Scaffold(
      backgroundColor: AppColors.backgroundGreyLighter,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        foregroundColor: AppColors.textBlack87,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text(
          'My Cart',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : isLoggedIn
          ? _buildCartContent(selectedItems, selectedCount)
          : _buildLoginRequiredState(),
      bottomNavigationBar: BottomBarWidget(
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

  Widget _buildCartContent(
    List<CartProductItem> selectedItems,
    int selectedCount,
  ) {
    final totalSelected = selectedItems.fold<double>(
      0,
      (sum, item) => sum + (_parsePrice(item.priceText) * item.quantity),
    );
    final totalText = _formatMoney(totalSelected);

    return Column(
      children: [
        Expanded(
          child: CartListWidget(
            items: cartItems,
            onChanged: (updatedItems) {
              // Find which item had quantity changed
              for (int i = 0; i < updatedItems.length; i++) {
                if (i < cartItems.length &&
                    updatedItems[i].quantity != cartItems[i].quantity) {
                  // Quantity changed, update in DB
                  final cartItemId = int.tryParse(updatedItems[i].id) ?? 0;
                  _updateQuantity(cartItemId, updatedItems[i].quantity);
                }
              }

              // If item was deleted (updatedItems.length < cartItems.length)
              if (updatedItems.length < cartItems.length) {
                final deletedIds = cartItems
                    .where((item) => !updatedItems.any((u) => u.id == item.id))
                    .map((item) => int.tryParse(item.id) ?? 0)
                    .where((id) => id > 0)
                    .toList();
                if (deletedIds.isNotEmpty) {
                  _deleteMultipleItems(deletedIds);
                }
              }

              setState(() {
                cartItems = updatedItems;
              });
            },
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
            onSelectPayment: () {},
          ),
      ],
    );
  }

  Widget _buildLoginRequiredState() {
    return EmptyStateWidget(
      emptyMessage:
          "Sign in to your account to add\nitems to your cart and checkout.",
      icon: Icons.shopping_bag_outlined,
      buttonText: "Sign In",
      onButtonPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      },
    );
  }
}

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

  static const Color _divider = AppColors.borderGreyLighter;
  static const Color _labelGrey = AppColors.color9AA0A6;

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
        // color: AppColors.backgroundWhite,
        gradient: AppColors.bgLightGradientColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowBlack,
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
                            color: AppColors.textBlack87,
                          ),
                        ),
                        // const SizedBox(width: 6),
                        Spacer(),

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
                                            color: AppColors.textBlack87,
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
                                      color: AppColors.textBlack87,
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
                                        color: AppColors.textBlack87,
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
                                  color: AppColors.textBlack87,
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
                          color: AppColors.textBlack87,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Button
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
          PrimaryBtnWidget(
            height: 43,
            buttonText: "Checkout",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CheckoutPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
