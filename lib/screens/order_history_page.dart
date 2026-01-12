// import 'package:flutter/material.dart';
// import '../widgets/order_group_card_widget.dart';

// class OrderHistoryPage extends StatefulWidget {
//   const OrderHistoryPage({super.key});

//   @override
//   State<OrderHistoryPage> createState() => _OrderHistoryPageState();
// }

// class _OrderHistoryPageState extends State<OrderHistoryPage>
//     with SingleTickerProviderStateMixin {
//   late final TabController _tabController;

//   // sample data per tab
//   final List<Map<String, dynamic>> _currentOrders = [];
//   final List<Map<String, dynamic>> _pendingOrders = [
//     {
//       'orderNumber': 'ORD-1001',
//       'placedDate': 'Jan 07, 2026',
//       'imageUrl': 'https://picsum.photos/200?10',
//       'productName': 'Air pods max by Apple',
//       'variant': 'Grey',
//       'quantity': 1,
//       'price': '\$ 1999,99',
//       'status': 'Pending',
//     },
//     {
//       'orderNumber': 'ORD-1001',
//       'placedDate': 'Jan 07, 2026',
//       'imageUrl': 'https://picsum.photos/200?20',
//       'productName': 'iPhone 15 Pro Max',
//       'variant': '256 GB, Silver',
//       'quantity': 1,
//       'price': '\$ 1299,99',
//       'status': 'Pending',
//     },
//     {
//       'orderNumber': 'ORD-1002',
//       'placedDate': 'Jan 10, 2026',
//       'imageUrl': 'https://picsum.photos/200?30',
//       'productName': 'MacBook Pro 16-inch',
//       'variant': '16 GB RAM, 512 GB SSD',
//       'quantity': 1,
//       'price': '\$ 2399,99',
//       'status': 'Pending',
//     },
//   ];
//   final List<Map<String, dynamic>> _reviewPending = [];
//   final List<Map<String, dynamic>> _oldOrders = [];

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 4, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   Widget _emptyState(String text) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               width: 140,
//               height: 140,
//               decoration: BoxDecoration(
//                 color: const Color(0xFFEBF6FF),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: const Center(
//                 child: Icon(
//                   Icons.shopping_bag_outlined,
//                   size: 72,
//                   color: Color(0xFF2196F3),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 18),
//             Text(
//               text,
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildList(List<Map<String, dynamic>> items) {
//     if (items.isEmpty) return _emptyState('There are no orders placed yet');

//     // Group items by orderNumber so multiple products in the same order
//     // render inside a single card (show 2-3 items stacked inside).
//     final Map<String, Map<String, dynamic>> groups = {};
//     for (final it in items) {
//       final id = (it['orderNumber'] ?? '') as String;
//       if (!groups.containsKey(id)) {
//         groups[id] = {
//           'orderNumber': id,
//           'placedDate': it['placedDate'],
//           'status': it['status'] ?? '',
//           'items': <Map<String, dynamic>>[],
//         };
//       }
//       (groups[id]!['items'] as List).add(it);
//     }

//     final grouped = groups.values.toList();

//     return ListView.separated(
//       padding: const EdgeInsets.fromLTRB(10, 10, 10, 24),
//       itemCount: grouped.length,
//       separatorBuilder: (_, __) => const SizedBox(height: 12),
//       itemBuilder: (context, index) {
//         final g = grouped[index];
//         return OrderGroupCard(
//           orderNumber: g['orderNumber'] ?? '',
//           placedDate: g['placedDate'] ?? '',
//           status: g['status'] ?? '',
//           items: List<Map<String, dynamic>>.from(g['items'] ?? []),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         foregroundColor: Colors.black87,
//         title: const Text(
//           'Order History',
//           style: TextStyle(fontWeight: FontWeight.w700),
//         ),
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(48),
//           child: Align(
//             alignment: Alignment.centerLeft,
//             child: TabBar(
//               controller: _tabController,
//               isScrollable: true,
//               indicatorColor: const Color(0xFF2196F3),
//               labelColor: Colors.black87,
//               tabs: const [
//                 Tab(text: 'Current Orders'),
//                 Tab(text: 'Pending Orders'),
//                 Tab(text: 'Review Pending'),
//                 Tab(text: 'Old Orders'),
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           _buildList(_currentOrders),
//           _buildList(_pendingOrders),
//           _buildList(_reviewPending),
//           _buildList(_oldOrders),
//         ],
//       ),
//     );
//   }
// }















import 'package:flutter/material.dart';
import '../widgets/order_group_card_widget.dart';

// class OrderHistoryPage extends StatefulWidget {
//   const OrderHistoryPage({super.key});

//   @override
//   State<OrderHistoryPage> createState() => _OrderHistoryPageState();
// }

class OrderHistoryPage extends StatefulWidget {
  final int initialTabIndex;

  const OrderHistoryPage({
    super.key,
    this.initialTabIndex = 0, // default = All tab
  });

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}


class _OrderHistoryPageState extends State<OrderHistoryPage>
    with SingleTickerProviderStateMixin {

  late final TabController _tabController;

  // ---------------- SAMPLE DATA ----------------
  final List<Map<String, dynamic>> _allOrders = [];

  final List<Map<String, dynamic>> _toPayOrders = [
    {
      'orderNumber': 'ORD-1001',
      'placedDate': 'Jan 07, 2026',
      'imageUrl': 'https://picsum.photos/200?10',
      'productName': 'AirPods Max by Apple',
      'variant': 'Grey',
      'quantity': 1,
      'price': '\$ 1999,99',
      'status': 'To pay',
    },
  ];

  final List<Map<String, dynamic>> _toShipOrders = [];
  final List<Map<String, dynamic>> _toReceiveOrders = [];
  final List<Map<String, dynamic>> _toReviewOrders = [];
  final List<Map<String, dynamic>> _cancelledOrders = [];

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
    length: 6,
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
                color: const Color(0xFFEBF6FF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                size: 72,
                color: Color(0xFF2196F3),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- ORDER LIST BUILDER ----------------
  Widget _buildList(List<Map<String, dynamic>>? items) {
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
        );
      },
    );
  }

  // ---------------- UI ----------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black87,
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
              indicatorColor: const Color(0xFF2196F3),
              labelColor: Colors.black87,
              tabs: const [
                Tab(text: 'All'),
                Tab(text: 'To pay'),
                Tab(text: 'To ship'),
                Tab(text: 'To receive'),
                Tab(text: 'To review'),
                Tab(text: 'Cancellation'),
              ],
            ),
          ),
        ),
      ),

      body: Column(
        children: [

          // ---------- DEMO BUTTONS (REMOVE LATER) ----------
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Wrap(
          //     spacing: 8,
          //     children: [
          //       ElevatedButton(
          //         onPressed: () => goToTab(1),
          //         child: const Text('Go to To Pay'),
          //       ),
          //       ElevatedButton(
          //         onPressed: () => goToTab(4),
          //         child: const Text('Go to To Review'),
          //       ),
          //       ElevatedButton(
          //         onPressed: () => goToTab(5),
          //         child: const Text('Go to Cancellation'),
          //       ),
          //     ],
          //   ),
          // ),

          // ---------------- TAB VIEWS ----------------
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildList(_allOrders),
                _buildList(_toPayOrders),
                _buildList(_toShipOrders),
                _buildList(_toReceiveOrders),
                _buildList(_toReviewOrders),
                _buildList(_cancelledOrders),
              ],
            ),
          ),
        ],
      ),
    
    );
  }
}
