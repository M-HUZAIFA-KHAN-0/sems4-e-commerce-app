// import 'package:flutter/material.dart';

// // Status enum for order tracking
// enum OrderStatus { placed, confirmed, shipped, outForDelivery, delivered }

// // Model for order status update
// class OrderStatusStep {
//   final OrderStatus status;
//   final String label;
//   final DateTime? date;
//   bool isCompleted;

//   OrderStatusStep({
//     required this.status,
//     required this.label,
//     this.date,
//     this.isCompleted = false,
//   });
// }

// // Order model
// class Order {
//   final String orderId;
//   final DateTime placedDate;
//   final int itemsCount;
//   final double price;
//   final List<OrderStatusStep> statusSteps;
//   OrderStatus currentStatus;

//   Order({
//     required this.orderId,
//     required this.placedDate,
//     required this.itemsCount,
//     required this.price,
//     required this.currentStatus,
//     required this.statusSteps,
//   });

//   void updateStatus(OrderStatus newStatus) {
//     currentStatus = newStatus;
//     // Update completed status for all steps up to current
//     for (var step in statusSteps) {
//       step.isCompleted =
//           _getStatusIndex(step.status) <= _getStatusIndex(newStatus);
//     }
//   }

//   int _getStatusIndex(OrderStatus status) {
//     return [
//       OrderStatus.placed,
//       OrderStatus.confirmed,
//       OrderStatus.shipped,
//       OrderStatus.outForDelivery,
//       OrderStatus.delivered,
//     ].indexOf(status);
//   }
// }

// class OrderHistoryPage extends StatefulWidget {
//   const OrderHistoryPage({super.key});

//   @override
//   State<OrderHistoryPage> createState() => _OrderHistoryPageState();
// }

// class _OrderHistoryPageState extends State<OrderHistoryPage> {
//   late List<Order> _orders;

//   @override
//   void initState() {
//     super.initState();
//     _initializeOrders();
//   }

//   void _initializeOrders() {
//     _orders = [
//       Order(
//         orderId: '90B97',
//         placedDate: DateTime(2021, 10, 28),
//         itemsCount: 2,
//         price: 18.90,
//         currentStatus: OrderStatus.delivered,
//         statusSteps: [
//           OrderStatusStep(
//             status: OrderStatus.placed,
//             label: 'Order placed',
//             date: DateTime(2021, 10, 19),
//             isCompleted: true,
//           ),
//           OrderStatusStep(
//             status: OrderStatus.confirmed,
//             label: 'Order confirmed',
//             date: DateTime(2021, 10, 20),
//             isCompleted: true,
//           ),
//           OrderStatusStep(
//             status: OrderStatus.shipped,
//             label: 'Order shipped',
//             date: DateTime(2021, 10, 22),
//             isCompleted: true,
//           ),
//           OrderStatusStep(
//             status: OrderStatus.outForDelivery,
//             label: 'Out for delivery',
//             date: DateTime(2021, 10, 23),
//             isCompleted: true,
//           ),
//           OrderStatusStep(
//             status: OrderStatus.delivered,
//             label: 'Order delivered',
//             date: DateTime(2021, 10, 24),
//             isCompleted: true,
//           ),
//         ],
//       ),
//       Order(
//         orderId: '90B97',
//         placedDate: DateTime(2021, 10, 28),
//         itemsCount: 1,
//         price: 10.90,
//         currentStatus: OrderStatus.shipped,
//         statusSteps: [
//           OrderStatusStep(
//             status: OrderStatus.placed,
//             label: 'Order placed',
//             date: DateTime(2021, 10, 19),
//             isCompleted: true,
//           ),
//           OrderStatusStep(
//             status: OrderStatus.confirmed,
//             label: 'Order confirmed',
//             date: DateTime(2021, 10, 20),
//             isCompleted: true,
//           ),
//           OrderStatusStep(
//             status: OrderStatus.shipped,
//             label: 'Order shipped',
//             date: DateTime(2021, 10, 22),
//             isCompleted: true,
//           ),
//           OrderStatusStep(
//             status: OrderStatus.outForDelivery,
//             label: 'Out for delivery',
//             date: null,
//             isCompleted: false,
//           ),
//           OrderStatusStep(
//             status: OrderStatus.delivered,
//             label: 'Order delivered',
//             date: null,
//             isCompleted: false,
//           ),
//         ],
//       ),
//       Order(
//         orderId: '90B97',
//         placedDate: DateTime(2021, 8, 29),
//         itemsCount: 1,
//         price: 10.90,
//         currentStatus: OrderStatus.delivered,
//         statusSteps: [
//           OrderStatusStep(
//             status: OrderStatus.placed,
//             label: 'Order placed',
//             date: DateTime(2021, 8, 25),
//             isCompleted: true,
//           ),
//           OrderStatusStep(
//             status: OrderStatus.confirmed,
//             label: 'Order confirmed',
//             date: DateTime(2021, 8, 26),
//             isCompleted: true,
//           ),
//           OrderStatusStep(
//             status: OrderStatus.shipped,
//             label: 'Order shipped',
//             date: DateTime(2021, 8, 27),
//             isCompleted: true,
//           ),
//           OrderStatusStep(
//             status: OrderStatus.outForDelivery,
//             label: 'Out for delivery',
//             date: DateTime(2021, 8, 28),
//             isCompleted: true,
//           ),
//           OrderStatusStep(
//             status: OrderStatus.delivered,
//             label: 'Order delivered',
//             date: DateTime(2021, 8, 29),
//             isCompleted: true,
//           ),
//         ],
//       ),
//       Order(
//         orderId: '90B97',
//         placedDate: DateTime(2021, 8, 29),
//         itemsCount: 2,
//         price: 18.90,
//         currentStatus: OrderStatus.delivered,
//         statusSteps: [
//           OrderStatusStep(
//             status: OrderStatus.placed,
//             label: 'Order placed',
//             date: DateTime(2021, 8, 25),
//             isCompleted: true,
//           ),
//           OrderStatusStep(
//             status: OrderStatus.confirmed,
//             label: 'Order confirmed',
//             date: DateTime(2021, 8, 26),
//             isCompleted: true,
//           ),
//           OrderStatusStep(
//             status: OrderStatus.shipped,
//             label: 'Order shipped',
//             date: DateTime(2021, 8, 27),
//             isCompleted: true,
//           ),
//           OrderStatusStep(
//             status: OrderStatus.outForDelivery,
//             label: 'Out for delivery',
//             date: DateTime(2021, 8, 28),
//             isCompleted: true,
//           ),
//           OrderStatusStep(
//             status: OrderStatus.delivered,
//             label: 'Order delivered',
//             date: DateTime(2021, 8, 29),
//             isCompleted: true,
//           ),
//         ],
//       ),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: GestureDetector(
//           onTap: () => Navigator.pop(context),
//           child: const Icon(
//             Icons.arrow_back_ios,
//             color: Colors.black87,
//             size: 20,
//           ),
//         ),
//         title: const Text(
//           'My Order',
//           style: TextStyle(
//             color: Colors.black87,
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         centerTitle: false,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.filter_list, color: Colors.black87),
//             onPressed: () {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                   content: Text('Filter options'),
//                   duration: Duration(milliseconds: 1000),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         padding: const EdgeInsets.symmetric(vertical: 16),
//         itemCount: _orders.length,
//         itemBuilder: (context, index) {
//           return OrderCard(
//             order: _orders[index],
//             onStatusUpdate: (newStatus) {
//               setState(() {
//                 _orders[index].updateStatus(newStatus);
//               });
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// class OrderCard extends StatefulWidget {
//   final Order order;
//   final Function(OrderStatus) onStatusUpdate;

//   const OrderCard({
//     super.key,
//     required this.order,
//     required this.onStatusUpdate,
//   });

//   @override
//   State<OrderCard> createState() => _OrderCardState();
// }

// class _OrderCardState extends State<OrderCard> {
//   bool _isExpanded = false;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 8,
//             spreadRadius: 0,
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           // Order Header
//           GestureDetector(
//             onTap: () => setState(() => _isExpanded = !_isExpanded),
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Container(
//                         width: 40,
//                         height: 40,
//                         decoration: BoxDecoration(
//                           color: const Color(0xFF7CB342).withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: const Icon(
//                           Icons.local_shipping,
//                           color: Color(0xFF7CB342),
//                           size: 20,
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Order #${order.orderId}',
//                               style: const TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               'Placed on ${_formatDate(order.placedDate)}',
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w400,
//                                 color: Colors.grey[600],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         width: 32,
//                         height: 32,
//                         decoration: const BoxDecoration(
//                           color: Color(0xFF4CAF50),
//                           shape: BoxShape.circle,
//                         ),
//                         child: const Icon(
//                           Icons.check,
//                           color: Colors.white,
//                           size: 18,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 12),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Items ${order.itemsCount}, Koroi: \$${order.price.toStringAsFixed(2)}',
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.grey[600],
//                         ),
//                       ),
//                       Icon(
//                         _isExpanded ? Icons.expand_less : Icons.expand_more,
//                         color: Colors.grey[400],
//                         size: 20,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           // Order Status Timeline (Expanded)
//           if (_isExpanded) ...[
//             const Divider(height: 1, color: Color(0xFFEEEEEE)),
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 children: [
//                   _buildOrderTimeline(),
//                   const SizedBox(height: 16),
//                   // Update Status Buttons (for testing)
//                   _buildStatusUpdateButtons(),
//                 ],
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }

//   Widget _buildOrderTimeline() {
//     return Column(
//       children: List.generate(order.statusSteps.length, (index) {
//         final step = order.statusSteps[index];
//         final isLast = index == order.statusSteps.length - 1;

//         return Column(
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Timeline dot
//                 Column(
//                   children: [
//                     Container(
//                       width: 20,
//                       height: 20,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: step.isCompleted
//                             ? const Color(0xFF4CAF50)
//                             : Colors.grey[300],
//                         border: Border.all(
//                           color: step.isCompleted
//                               ? const Color(0xFF4CAF50)
//                               : Colors.grey[400]!,
//                           width: 2,
//                         ),
//                       ),
//                       child: step.isCompleted
//                           ? const Icon(
//                               Icons.check,
//                               color: Colors.white,
//                               size: 12,
//                             )
//                           : null,
//                     ),
//                     if (!isLast)
//                       Container(
//                         width: 2,
//                         height: 30,
//                         color: step.isCompleted
//                             ? const Color(0xFF4CAF50)
//                             : Colors.grey[300],
//                         margin: const EdgeInsets.only(top: 4),
//                       ),
//                   ],
//                 ),
//                 const SizedBox(width: 12),
//                 // Status text
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         step.label,
//                         style: TextStyle(
//                           fontSize: 13,
//                           fontWeight: FontWeight.w600,
//                           color: step.isCompleted
//                               ? Colors.black87
//                               : Colors.grey[600],
//                         ),
//                       ),
//                       if (step.date != null)
//                         Padding(
//                           padding: const EdgeInsets.only(top: 4),
//                           child: Text(
//                             _formatDate(step.date!),
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w400,
//                               color: Colors.grey[600],
//                             ),
//                           ),
//                         )
//                       else
//                         Padding(
//                           padding: const EdgeInsets.only(top: 4),
//                           child: Text(
//                             'pending',
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w400,
//                               color: Colors.grey[500],
//                             ),
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         );
//       }),
//     );
//   }

//   Widget _buildStatusUpdateButtons() {
//     final statuses = [
//       OrderStatus.placed,
//       OrderStatus.confirmed,
//       OrderStatus.shipped,
//       OrderStatus.outForDelivery,
//       OrderStatus.delivered,
//     ];

//     return Wrap(
//       spacing: 8,
//       children: statuses.map((status) {
//         return SizedBox(
//           height: 32,
//           child: ElevatedButton.icon(
//             onPressed: () {
//               onStatusUpdate(status);
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text(
//                     'Status updated to ${status.toString().split('.').last}',
//                   ),
//                   duration: const Duration(milliseconds: 1500),
//                 ),
//               );
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: order.currentStatus == status
//                   ? const Color(0xFF4CAF50)
//                   : Colors.grey[300],
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//             ),
//             icon: const Icon(Icons.update, size: 14),
//             label: Text(
//               _statusLabel(status),
//               style: const TextStyle(fontSize: 11),
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }

//   String _formatDate(DateTime date) {
//     final months = [
//       'January',
//       'February',
//       'March',
//       'April',
//       'May',
//       'June',
//       'July',
//       'August',
//       'September',
//       'October',
//       'November',
//       'December',
//     ];
//     return '${months[date.month - 1]} ${date.day} ${date.year}';
//   }

//   String _statusLabel(OrderStatus status) {
//     switch (status) {
//       case OrderStatus.placed:
//         return 'Placed';
//       case OrderStatus.confirmed:
//         return 'Confirmed';
//       case OrderStatus.shipped:
//         return 'Shipped';
//       case OrderStatus.outForDelivery:
//         return 'Out';
//       case OrderStatus.delivered:
//         return 'Delivered';
//     }
//   }
// }











import 'package:flutter/material.dart';
import '../widgets/order_group_card_widget.dart';

class OrderHistoryPage extends StatefulWidget {
  final int initialTabIndex;

  const OrderHistoryPage({
    super.key,
    this.initialTabIndex = 0,
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
