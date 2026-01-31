import 'package:first/core/app_imports.dart';

class OrderHistoryPage extends StatefulWidget {
  final int initialTabIndex;

  const OrderHistoryPage({super.key, this.initialTabIndex = 0});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  // ---------------- SAMPLE DATA ----------------
  // final List<Map<String, dynamic>> _allOrders = [];

  final List<Map<String, dynamic>> _toPayOrders = [
    {
      'orderNumber': 'ORD-1001',
      'placedDate': 'Jan 07, 2026',
      // 'imageUrl': 'https://picsum.photos/200?10',
      'imageUrl': '',
      'productName': 'AirPods Max by Apple',
      'variant': 'Grey',
      'quantity': 1,
      'price': '\$ 1999,99',
      'status': 'Pending',
    },
  ];

  // final List<Map<String, dynamic>> _toShipOrders = [];
  final List<Map<String, dynamic>> _toReceiveOrders = [
    {
      'orderNumber': 'ORD-1001',
      'placedDate': 'Jan 07, 2026',
      // 'imageUrl': 'https://picsum.photos/200?10',
      'imageUrl': '',
      'productName': 'AirPods Max by Apple',
      'variant': 'Grey',
      'quantity': 1,
      'price': '\$ 1999,99',
      'status': 'To pay',
    },
  ];
  // final List<Map<String, dynamic>> _toReviewOrders = [];
  final List<Map<String, dynamic>> _cancelledOrders = [
    {
      'orderNumber': 'ORD-1001',
      'placedDate': 'Jan 07, 2026',
      // 'imageUrl': 'https://picsum.photos/200?10',
      'imageUrl': '',
      'productName': 'AirPods Max by Apple',
      'variant': 'Grey',
      'quantity': 1,
      'price': '\$ 1999,99',
      'status': 'Cancelled',
    },
  ];

  // Review related data
  final List<Map<String, dynamic>> _pendingReviewProducts = [
    {
      'productName': 'Apple iPhone 15',
      // 'imageUrl': 'https://picsum.photos/200?1',
      'imageUrl': '',
      'price': 'Rs. 79,999',
      'quantity': 1,
    },
    {
      'productName': 'Samsung Galaxy Watch',
      // 'imageUrl': 'https://picsum.photos/200?2',
      'imageUrl': '',
      'price': 'Rs. 24,999',
      'quantity': 1,
    },
  ];

  final List<Map<String, dynamic>> _reviewedProducts = [
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

  // @override
  // void initState() {
  //   super.initState();
  //   _tabController = TabController(length: 6, vsync: this);
  // }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: widget.initialTabIndex,
    );
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

      body: Column(
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
