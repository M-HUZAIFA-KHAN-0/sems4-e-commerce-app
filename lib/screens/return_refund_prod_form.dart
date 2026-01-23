import 'package:first/core/app_imports.dart';

class ReturnRefundProdForm extends StatefulWidget {
  const ReturnRefundProdForm({super.key});

  @override
  State<ReturnRefundProdForm> createState() => _ReturnRefundProdFormState();
}

class _ReturnRefundProdFormState extends State<ReturnRefundProdForm> {
  // Form controllers
  final _orderNumberController = TextEditingController();
  final _reasonController = TextEditingController();

  // State variables
  String? _selectedOrderId;
  String? _selectedProductId;
  int _returnQuantity = 1;
  bool _isProductDropdownExpanded = false;

  // Sample orders data (would come from API)
  final List<Map<String, dynamic>> _userOrders = [
    {
      'orderNumber': 'ORD-1001',
      'orderDate': 'Jan 07, 2026',
      'products': [
        {
          'productId': 'P001',
          'productName': 'Samsung Galaxy Watch 5 Pro',
          'productImage': 'https://via.placeholder.com/150?text=Galaxy+Watch+5',
          'price': '\$399.99',
          'quantity': 1,
        },
      ],
    },
    {
      'orderNumber': 'ORD-1002',
      'orderDate': 'Jan 12, 2026',
      'products': [
        {
          'productId': 'P002',
          'productName': 'Apple AirPods Pro (2nd Gen)',
          'productImage': 'https://via.placeholder.com/150?text=AirPods+Pro',
          'price': '\$249.99',
          'quantity': 2,
        },
        {
          'productId': 'P003',
          'productName': 'Sony WH-1000XM5 Headphones',
          'productImage':
              'https://via.placeholder.com/150?text=Sony+Headphones',
          'price': '\$399.99',
          'quantity': 1,
        },
      ],
    },
    {
      'orderNumber': 'ORD-1003',
      'orderDate': 'Dec 20, 2025',
      'products': [
        {
          'productId': 'P004',
          'productName': 'iPad Pro 12.9" (2024)',
          'productImage': 'https://via.placeholder.com/150?text=iPad+Pro',
          'price': '\$1,299.99',
          'quantity': 3,
        },
      ],
    },
  ];

  @override
  void dispose() {
    _orderNumberController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  List<String> _getOrderSuggestions(String query) {
    if (query.isEmpty) return [];
    return _userOrders
        .where(
          (order) =>
              order['orderNumber'].toLowerCase().contains(
                query.toLowerCase(),
              ) ||
              order['orderDate'].contains(query),
        )
        .map((order) => order['orderNumber'] as String)
        .toList();
  }

  List<Map<String, dynamic>> _getProductsForOrder(String orderNumber) {
    final order = _userOrders.firstWhere(
      (o) => o['orderNumber'] == orderNumber,
      orElse: () => {'products': []},
    );
    return List<Map<String, dynamic>>.from(order['products'] ?? []);
  }

  void _selectOrder(String orderNumber) {
    final products = _getProductsForOrder(orderNumber);

    setState(() {
      _selectedOrderId = orderNumber;
      _selectedProductId = null;
      _returnQuantity = 1;
      _isProductDropdownExpanded = false;

      // Auto-select if only 1 product
      if (products.length == 1) {
        _selectedProductId = products[0]['productId'];
      }
    });
  }

  void _selectProduct(String productId) {
    setState(() {
      _selectedProductId = productId;
      _returnQuantity = 1;
    });
  }

  void _submitForm() {
    if (_selectedOrderId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select an order')));
      return;
    }

    if (_selectedProductId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a product')));
      return;
    }

    if (_reasonController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please provide a reason')));
      return;
    }

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Return request submitted for Order $_selectedOrderId'),
        backgroundColor: AppColors.primaryGreen,
      ),
    );

    // Navigate back
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        foregroundColor: AppColors.textBlack87,
        title: const Text(
          'Request Return / Refund',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          children: [
            // Main Form Container
            Container(
              decoration: BoxDecoration(
                color: AppColors.backgroundWhite,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowBlack,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Step 1: Order Number Field
                  const Text(
                    ' Order Number',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textBlack87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      return _getOrderSuggestions(textEditingValue.text);
                    },
                    onSelected: (String selection) {
                      _selectOrder(selection);
                    },
                    fieldViewBuilder:
                        (
                          BuildContext context,
                          TextEditingController textEditingController,
                          FocusNode focusNode,
                          VoidCallback onFieldSubmitted,
                        ) {
                          return TextField(
                            controller: textEditingController,
                            focusNode: focusNode,
                            decoration:
                                OutlineInputDecorationHelper.createInputDecoration(
                                  labelText: 'Order Number',
                                  hintText:
                                      'Search order number (e.g., ORD-1001)',
                                  borderColor: AppColors.borderGrey,
                                  focusedBorderColor: AppColors.primaryBlue,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 12,
                                  ),
                                ),
                          );
                        },
                    optionsViewBuilder:
                        (
                          BuildContext context,
                          AutocompleteOnSelected<String> onSelected,
                          Iterable<String> options,
                        ) {
                          return Material(
                            elevation: 4,
                            borderRadius: BorderRadius.circular(8),
                            child: ListView(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              shrinkWrap: true,
                              children: options.map((String option) {
                                return ListTile(
                                  title: Text(option),
                                  onTap: () => onSelected(option),
                                );
                              }).toList(),
                            ),
                          );
                        },
                  ),
                  const SizedBox(height: 16),

                  // Step 2: Product Selector (enabled only after order selection)
                  if (_selectedOrderId != null) ...[
                    _buildProductSelectorDropdown(),
                    const SizedBox(height: 16),
                  ],

                  // Step 3: Selected Product Card
                  if (_selectedProductId != null) ...[
                    // const Divider(height: 24, color: Color(0xFFE0E0E0)),
                    Divider(
                      height: 1,
                      color: Color.fromARGB(255, 158, 158, 158),
                    ),
                    SizedBox(height: 16),
                    _buildSelectedProductCard(),
                    const SizedBox(height: 16),
                  ],

                  // Step 4: Quantity Handler (if product selected)
                  if (_selectedProductId != null) ...[
                    _buildQuantitySection(),
                    const SizedBox(height: 16),
                  ],

                  // Step 5: Return Reason Field (if product selected)
                  if (_selectedProductId != null) ...[
                    const Text(
                      ' Return / Refund Reason',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textBlack87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    MultilineTextFieldWidget(
                      controller: _reasonController,
                      labelText: 'Reason for Return/Refund',
                      hintText:
                          'Please explain your reason for return/refund...',
                      minLines: 6,
                      maxLines: 10,
                      borderColor: AppColors.borderGrey,
                      focusedBorderColor: AppColors.primaryBlue,
                    ),

                    const SizedBox(height: 22),
                    Divider(
                      height: 1,
                      color: Color.fromARGB(255, 158, 158, 158),
                    ),
                    SizedBox(height: 12),

                    // Step 6: Refund Amount Display
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Refund Amount',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.formBlack,
                          ),
                        ),
                        Text(
                          "222",
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textGreyMedium,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Submit Button
            if (_selectedProductId != null)
              PrimaryBtnWidget(
                onPressed: _submitForm,
                buttonText: 'Submit Return / Refund Request',
              ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildProductSelectorDropdown() {
    final products = _getProductsForOrder(_selectedOrderId!);

    // If only 1 product, don't show dropdown - just show it as selected
    if (products.length == 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(height: ),
          Divider(height: 1, color: Color.fromARGB(255, 158, 158, 158)),
          SizedBox(height: 10),
          const Text(
            ' Select Product',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.textBlack87,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.backgroundGrey,
              border: Border.all(color: const Color(0xFFE0E0E0)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                // Product Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    products[0]['productImage'],
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppColors.borderGreyLight,
                        borderRadius: BorderRadius.circular(6),
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
                      Text(
                        products[0]['productName'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textBlack87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            products[0]['price'],
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textBlack87,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Qty: ${products[0]['quantity']}',
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.textGreyMedium,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    // If multiple products, show dropdown
    final selectedProduct = _selectedProductId != null
        ? products.firstWhere(
            (p) => p['productId'] == _selectedProductId,
            orElse: () => products[0],
          )
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(height: 1, color: Color.fromARGB(255, 158, 158, 158)),
        SizedBox(height: 10),
        const Text(
          ' Select Product',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textBlack87,
          ),
        ),
        const SizedBox(height: 8),
        // Dropdown Field
        GestureDetector(
          onTap: () {
            setState(() {
              _isProductDropdownExpanded = !_isProductDropdownExpanded;
            });
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(
                color: _isProductDropdownExpanded
                    ? const Color(0xFF2196F3)
                    : AppColors.borderGrey,
              ),
              borderRadius: BorderRadius.circular(8),
              color: AppColors.backgroundWhite,
            ),
            child: Row(
              children: [
                if (selectedProduct != null) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.network(
                      selectedProduct['productImage'],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 50,
                        height: 50,
                        color: AppColors.borderGreyLight,
                        child: const Icon(Icons.image, color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          selectedProduct['productName'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textBlack87,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          selectedProduct['price'],
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textBlack87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  Expanded(
                    child: Text(
                      'Choose a product',
                      style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                    ),
                  ),
                ],
                Icon(
                  _isProductDropdownExpanded
                      ? Icons.expand_less
                      : Icons.expand_more,
                  color: AppColors.primaryBlue,
                ),
              ],
            ),
          ),
        ),

        // Expanded Dropdown List
        if (_isProductDropdownExpanded)
          Container(
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE0E0E0)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length,
              separatorBuilder: (_, __) =>
                  const Divider(height: 1, color: Color(0xFFE0E0E0)),
              itemBuilder: (context, index) {
                final product = products[index];
                final isSelected = _selectedProductId == product['productId'];

                return GestureDetector(
                  onTap: () => setState(() {
                    _selectProduct(product['productId']);
                    _isProductDropdownExpanded = false;
                  }),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: isSelected
                        ? AppColors.statusBlueLight
                        : AppColors.transparent,
                    child: Row(
                      children: [
                        // Product Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                            product['productImage'],
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: AppColors.borderGreyLight,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Icon(
                                Icons.image,
                                color: Colors.grey,
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
                              Text(
                                product['productName'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textBlack87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    product['price'],
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textBlack87,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Qty: ${product['quantity']}',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: AppColors.textGreyMedium,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  List<Widget> _buildProductSelector() {
    final products = _getProductsForOrder(_selectedOrderId!);

    return [
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE0E0E0)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: products.length,
          separatorBuilder: (_, __) =>
              const Divider(height: 1, color: Color(0xFFE0E0E0)),
          itemBuilder: (context, index) {
            final product = products[index];
            final isSelected = _selectedProductId == product['productId'];

            return GestureDetector(
              onTap: () => _selectProduct(product['productId']),
              child: Container(
                color: isSelected
                    ? const Color(0xFFE3F2FD)
                    : AppColors.transparent,
                padding: const EdgeInsets.all(12),

                child: Row(
                  children: [
                    // Product Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        product['productImage'],
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: AppColors.borderGreyLight,
                            borderRadius: BorderRadius.circular(6),
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
                          Text(
                            product['productName'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textBlack87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                product['price'],
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textBlack87,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Qty: ${product['quantity']}',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: AppColors.textGreyMedium,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ];
  }

  Widget _buildSelectedProductCard() {
    final products = _getProductsForOrder(_selectedOrderId!);
    final selectedProduct = products.firstWhere(
      (p) => p['productId'] == _selectedProductId,
    );

    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundGrey,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              selectedProduct['productImage'],
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.borderGreyLight,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.image, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selected Product',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  selectedProduct['productName'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textBlack87,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  selectedProduct['price'],
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textBlack87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantitySection() {
    final products = _getProductsForOrder(_selectedOrderId!);
    final selectedProduct = products.firstWhere(
      (p) => p['productId'] == _selectedProductId,
    );
    final orderedQuantity = selectedProduct['quantity'] as int;

    if (orderedQuantity == 1) {
      // Read-only quantity display
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            ' Quantity to Return',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.textBlack87,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.backgroundGrey,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE0E0E0)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Quantity',
                  style: TextStyle(fontSize: 13, color: Colors.black87),
                ),
                Text(
                  '1',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      // Adjustable quantity
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quantity to Return',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textBlack87,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.backgroundWhite,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE0E0E0)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select quantity (Max: $orderedQuantity)',
                  style: const TextStyle(fontSize: 13, color: Colors.black87),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_returnQuantity > 1) _returnQuantity--;
                        });
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFE0E0E0)),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(Icons.remove, size: 22),
                      ),
                    ),
                    const SizedBox(width: 2),
                    SizedBox(
                      width: 30,
                      child: Text(
                        '$_returnQuantity',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 2),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_returnQuantity < orderedQuantity) {
                            _returnQuantity++;
                          }
                        });
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFE0E0E0)),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(Icons.add, size: 22),
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
}
