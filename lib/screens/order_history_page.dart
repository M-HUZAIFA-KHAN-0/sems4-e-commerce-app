import 'package:first/core/app_imports.dart';
import 'package:first/services/api/order_service.dart';
import 'package:first/services/user_session_manager.dart';

class OrderHistoryPage extends StatefulWidget {
  final int initialTabIndex;

  const OrderHistoryPage({super.key, this.initialTabIndex = 0});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final OrderService _orderService = OrderService();
  final UserSessionManager _sessionManager = UserSessionManager();

  bool _isLoading = true;
  String? _errorMessage;

  // API Data mapped to existing structures
  List<Map<String, dynamic>> _toPayOrders = [];
  List<Map<String, dynamic>> _toReceiveOrders = [];
  List<Map<String, dynamic>> _cancelledOrders = [];
  List<Map<String, dynamic>> _pendingReviewProducts = [];
  List<Map<String, dynamic>> _reviewedProducts = [];

  // Sample data (fallback if needed)
  final List<Map<String, dynamic>> _sampleToPayOrders = [
    {
      'orderNumber': 'ORD-1001',
      'placedDate': 'Jan 07, 2026',
      'imageUrl': '',
      'productName': 'AirPods Max by Apple',
      'variant': 'Grey',
      'quantity': 1,
      'price': '\$ 1999,99',
      'status': 'Pending',
    },
  ];

  final List<Map<String, dynamic>> _sampleToReceiveOrders = [
    {
      'orderNumber': 'ORD-1001',
      'placedDate': 'Jan 07, 2026',
      'imageUrl': '',
      'productName': 'AirPods Max by Apple',
      'variant': 'Grey',
      'quantity': 1,
      'price': '\$ 1999,99',
      'status': 'To pay',
    },
  ];

  final List<Map<String, dynamic>> _sampleCancelledOrders = [
    {
      'orderNumber': 'ORD-1001',
      'placedDate': 'Jan 07, 2026',
      'imageUrl': '',
      'productName': 'AirPods Max by Apple',
      'variant': 'Grey',
      'quantity': 1,
      'price': '\$ 1999,99',
      'status': 'Cancelled',
    },
  ];

  final List<Map<String, dynamic>> _samplePendingReviewProducts = [
    {
      'productName': 'Apple iPhone 15',
      'imageUrl': '',
      'price': 'Rs. 79,999',
      'quantity': 1,
    },
    {
      'productName': 'Samsung Galaxy Watch',
      'imageUrl': '',
      'price': 'Rs. 24,999',
      'quantity': 1,
    },
  ];

  final List<Map<String, dynamic>> _sampleReviewedProducts = [
    {
      'productName': 'Sony WH-1000XM4 Headphones',
      // 'imageUrl': 'https://picsum.photos/200?3',
      'imageUrl': '',
      'rating': 5,
      'reviewText':
          'Excellent sound quality and very comfortable to wear. Battery life is impressive.',
      'reviewImages': [
        'https://picsum.photos/60?4',
        'https://picsum.photos/60?5',
      ],
    },
    {
      'productName': 'iPad Pro 12.9',
      // 'imageUrl': 'https://picsum.photos/200?6',
      'imageUrl': '',
      'rating': 4,
      'reviewText':
          'Great tablet for productivity and entertainment. Screen is beautiful.',
      'reviewImages': [],
    },
  ];

  // ------------------------------------------------

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: widget.initialTabIndex,
    );
    _fetchOrders();
  }

  // --------

  /// Fetch orders from API using userId from session
  Future<void> _fetchOrders() async {
    try {
      final userId = _sessionManager.userId;
      if (userId == null) {
        setState(() {
          _errorMessage = 'User not logged in';
          _isLoading = false;
        });
        print('❌ [OrderHistory] User ID not found in session');
        return;
      }

      print('📋 [OrderHistory] Fetching orders for userId: $userId');

      final orders = await _orderService.getOrdersByUserId(userId);

      if (!mounted) return;

      if (orders == null) {
        setState(() {
          _errorMessage = 'Failed to load orders';
          _isLoading = false;
        });
        return;
      }

      // Process orders and filter by delivery status
      _processOrdersData(orders);

      setState(() {
        _isLoading = false;
      });

      print('✅ [OrderHistory] Orders loaded successfully');
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Error: ${e.toString()}';
        _isLoading = false;
      });
      print('❌ [OrderHistory] Error fetching orders: $e');
    }
  }

  /// Process API response and filter orders by delivery status
  void _processOrdersData(List<Map<String, dynamic>> apiOrders) {
    _toPayOrders.clear();
    _toReceiveOrders.clear();
    _cancelledOrders.clear();

    for (final order in apiOrders) {
      final String deliveryStatus = order['deliveryStatus'] ?? 'Pending';
      final List<dynamic> items = order['items'] ?? [];
      final Map<String, dynamic>? orderAddress = order['orderAddress'];
      final String placedDate = _formatDate(
        order['createdAt'] ?? DateTime.now().toString(),
      );
      final int orderId = order['orderId'] ?? 0;
      final double totalAmount = (order['totalAmount'] ?? 0).toDouble();

      // Create order card data for each item
      for (final item in items) {
        final Map<String, dynamic> orderItem = {
          'orderNumber': 'ORD-${orderId.toString().padLeft(4, '0')}',
          'placedDate': placedDate,
          'imageUrl': item['image'] ?? '',
          'productName': item['productName'] ?? 'Unknown Product',
          'variant': _getVariantName(item['variantSpecifications']),
          'quantity': item['quantity'] ?? 1,
          'price': 'Rs. ${(item['price'] ?? 0).toStringAsFixed(2)}',
          'status': deliveryStatus,
          'address': orderAddress,
        };

        // Filter by delivery status for each tab
        if (deliveryStatus.toLowerCase() == 'pending') {
          _toPayOrders.add(orderItem);
        } else if (deliveryStatus.toLowerCase().contains('ship') ||
            deliveryStatus.toLowerCase().contains('delivery') ||
            deliveryStatus.toLowerCase() == 'confirmed') {
          _toReceiveOrders.add(orderItem);
        } else if (deliveryStatus.toLowerCase() == 'cancelled') {
          _cancelledOrders.add(orderItem);
        }
      }
    }

    print(
      '📊 [OrderHistory] Processed orders - ToPay: ${_toPayOrders.length}, ToReceive: ${_toReceiveOrders.length}, Cancelled: ${_cancelledOrders.length}',
    );
  }

  /// Format date from API response
  String _formatDate(String dateString) {
    try {
      final DateTime date = DateTime.parse(dateString);
      final months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      return '${months[date.month - 1]} ${date.day}, ${date.year}';
    } catch (e) {
      return 'Unknown Date';
    }
  }

  /// Extract variant name from variant specifications
  String _getVariantName(List<dynamic>? specs) {
    if (specs == null || specs.isEmpty) return '';
    // Return the color if available, otherwise the first spec option value
    try {
      final colorSpec = specs.firstWhere(
        (s) => s['specificationName'] == 'Color',
        orElse: () => null,
      );
      if (colorSpec != null) {
        return colorSpec['optionValue'] ?? '';
      }
      return specs.first['optionValue'] ?? '';
    } catch (e) {
      return '';
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // ---------------- TAB JUMP METHOD ----------------
  void goToTab(int index) {
    _tabController.animateTo(index);
  }

  // ---------------- EMPTY STATE ----------------
  Widget _emptyState(String text) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                color: AppColors.statusBlueVeryLight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                size: 72,
                color: AppColors.primaryBlue,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              text,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- ORDER LIST BUILDER ----------------
  Widget _buildList(
    List<Map<String, dynamic>>? items, {
    bool isOrderTracking = false,
  }) {
    if (items == null || items.isEmpty) {
      return _emptyState('There are no orders yet');
    }

    final Map<String, Map<String, dynamic>> groups = {};

    for (final it in items) {
      final id = it['orderNumber'];
      groups.putIfAbsent(id, () {
        return {
          'orderNumber': id,
          'placedDate': it['placedDate'],
          'status': it['status'],
          'items': <Map<String, dynamic>>[],
        };
      });
      groups[id]!['items'].add(it);
    }

    final grouped = groups.values.toList();

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
      itemCount: grouped.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final g = grouped[index];
        return OrderGroupCard(
          orderNumber: g['orderNumber'],
          placedDate: g['placedDate'],
          status: g['status'],
          items: List<Map<String, dynamic>>.from(g['items']),
          isOrderTracking: isOrderTracking,
          onTrackClick: isOrderTracking
              ? () => _navigateToTracking(
                  g['orderNumber'],
                  '${g['items'].length}',
                  _calculateTotal(g['items']),
                  g['placedDate'],
                )
              : null,
        );
      },
    );
  }

  double _calculateTotal(List<dynamic> items) {
    double total = 0.0;
    for (var item in items) {
      String price = (item['price'] ?? '0') as String;
      var s = price.replaceAll(RegExp(r"[^0-9,\.]"), '');
      if (s.isNotEmpty) {
        if (s.contains(',') && !s.contains('.')) {
          final parts = s.split(',');
          if (parts.last.length == 3) {
            s = s.replaceAll(',', '');
          } else {
            s = s.replaceAll(',', '.');
          }
        } else {
          s = s.replaceAll(',', '');
        }
        total += double.tryParse(s) ?? 0.0;
      }
    }
    return total;
  }

  void _navigateToTracking(
    String orderId,
    String itemsCount,
    double price,
    String placedDate,
  ) {
    // Create sample tracking steps
    final trackingSteps = [
      OrderTrackingStatus(title: 'Order Placed', isCompleted: true),
      OrderTrackingStatus(title: 'Order Confirmed', isCompleted: true),
      OrderTrackingStatus(title: 'Order Shipped', isCompleted: true),
      OrderTrackingStatus(title: 'Out for Delivery', isCompleted: false),
      OrderTrackingStatus(title: 'Order Delivered', isCompleted: false),
    ];

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderTrackingPage(
          orderId: orderId,
          itemsCount: itemsCount,
          totalPrice: 'Rs. ${price.toStringAsFixed(2)}',
          trackingSteps: trackingSteps,
          placedDate: placedDate,
        ),
      ),
    );
  }

  // ---------------- REVIEW TAB BUILDER ----------------
  Widget _buildReviewTab() {
    final hasPending = _pendingReviewProducts.isNotEmpty;
    final hasReviewed = _reviewedProducts.isNotEmpty;

    // If both are empty, show empty state
    if (!hasPending && !hasReviewed) {
      return _emptyState('No reviews yet');
    }

    return SingleChildScrollView(
      child: Container(
        color: AppColors.backgroundGrey,
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            // Pending Reviews Widget
            if (hasPending)
              PendingReviewWidget(products: _pendingReviewProducts),

            // Reviewed Products Widget
            if (hasReviewed) ReviewedProductWidget(products: _reviewedProducts),
          ],
        ),
      ),
    );
  }

  // ---------------- UI ----------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        foregroundColor: AppColors.textBlack87,
        title: const Text(
          'Order History',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorColor: AppColors.primaryBlue,
              labelColor: AppColors.textBlack87,
              tabs: const [
                // Tab(text: 'All'),
                Tab(text: 'Orders'),
                Tab(text: 'Received'),
                Tab(text: 'Reviews'),
                Tab(text: 'Cancellation'),
              ],
            ),
          ),
        ),
      ),

      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    _errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isLoading = true;
                        _errorMessage = null;
                      });
                      _fetchOrders();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                // ---------------- TAB VIEWS ----------------
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // _buildList(_allOrders),
                      _buildList(_toPayOrders, isOrderTracking: true),
                      // _buildList(_toShipOrders),
                      _buildList(_toReceiveOrders),
                      _buildReviewTab(),
                      _buildList(_cancelledOrders),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
