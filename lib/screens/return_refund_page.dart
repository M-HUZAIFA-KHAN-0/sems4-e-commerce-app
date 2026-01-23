import 'package:first/core/app_imports.dart';
import 'return_refund_prod_form.dart';

class ReturnRefundPage extends StatefulWidget {
  const ReturnRefundPage({super.key});

  @override
  State<ReturnRefundPage> createState() => _ReturnRefundPageState();
}

class _ReturnRefundPageState extends State<ReturnRefundPage>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  // Sample data
  late List<Map<String, dynamic>> _returnRequests;
  late List<Map<String, dynamic>> _approvedRequests;
  late List<Map<String, dynamic>> _returnedRefunded;
  late List<Map<String, dynamic>> _cancelledReturns;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _initializeData();
  }

  void _initializeData() {
    _returnRequests = [
      {
        'productId': 'P001',
        'productName': 'Samsung Galaxy Watch 5 Pro',
        'productImage': 'https://via.placeholder.com/150?text=Galaxy+Watch+5',
        'price': '\$399.99',
        'quantity': 1,
        'receivedDate': 'Jan 15, 2026',
        'returnRequestDate': 'Jan 18, 2026',
        'refundAmount': '\$399.99',
        'status': 'Pending',
      },
    ];

    _approvedRequests = [
      {
        'productId': 'P002',
        'productName': 'Apple AirPods Pro (2nd Gen)',
        'productImage': 'https://via.placeholder.com/150?text=AirPods+Pro',
        'price': '\$249.99',
        'quantity': 1,
        'receivedDate': 'Jan 12, 2026',
        'returnRequestDate': 'Jan 19, 2026',
        'refundAmount': '\$249.99',
        'status': 'Approved',
      },
    ];

    _returnedRefunded = [
      {
        'productId': 'P003',
        'productName': 'Sony WH-1000XM5 Headphones',
        'productImage': 'https://via.placeholder.com/150?text=Sony+Headphones',
        'price': '\$399.99',
        'quantity': 1,
        'receivedDate': 'Dec 28, 2025',
        'returnedDate': 'Jan 10, 2026',
        'refundAmount': '\$399.99',
        'refundMethod': 'Original Payment',
        'returnRequestDate': 'Jan 19, 2026',
      },
      {
        'productId': 'P004',
        'productName': 'iPad Pro 12.9" (2024)',
        'productImage': 'https://via.placeholder.com/150?text=iPad+Pro',
        'price': '\$1,299.99',
        'quantity': 1,
        'receivedDate': 'Dec 20, 2025',
        'returnedDate': 'Jan 5, 2026',
        'refundAmount': '\$1,299.99',
        'refundMethod': 'Wallet Credit',
        'returnRequestDate': 'Jan 19, 2026',
      },
    ];

    _cancelledReturns = [
      {
        'productId': 'P005',
        'productName': 'Tecno Camon 40 Pro',
        'productImage': 'https://via.placeholder.com/150?text=Tecno+Camon',
        'price': '\$249.99',
        'quantity': 1,
        'receivedDate': 'Jan 5, 2026',
        'cancelledDate': 'Jan 16, 2026',
        'refundAmount': '\$249.99',
        'adminMessage':
            'Return request cancelled. Product shows no physical damage or defects. Return reason did not meet return policy guidelines.',
        'returnRequestDate': 'Jan 19, 2026',
      },
    ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildRequestTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          // Request Return/Refund Button
          // SizedBox(
          //   width: double.infinity,
          //   height: 44,
          //   child: ElevatedButton(
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor:  AppColors.primaryBlue,
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(8),
          //       ),
          //     ),
          //     onPressed: () {
          //       ScaffoldMessenger.of(context).showSnackBar(
          //         const SnackBar(
          //           content: Text('Request Return/Refund functionality'),
          //         ),
          //       );
          //     },
          //     child: const Text(
          //       'Request Return / Refund Product',
          //       style: TextStyle(
          //         color: AppColors.backgroundWhite,
          //         fontSize: 14,
          //         fontWeight: FontWeight.w600,
          //       ),
          //     ),
          //   ),
          // ),
          PrimaryBtnWidget(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ReturnRefundProdForm(),
                ),
              );
            },
            buttonText: 'Request Return / Refund Product',
          ),

          const SizedBox(height: 16),

          // Return Requests List
          if (_returnRequests.isEmpty)
            const EmptyTabStateWidget(message: 'No Return Requests')
          else
            Column(
              children: _returnRequests.map((request) {
                return ReturnRequestCardWidget(
                  productId: request['productId'],
                  productName: request['productName'],
                  productImage: request['productImage'],
                  price: request['price'],
                  quantity: request['quantity'],
                  receivedDate: request['receivedDate'],
                  returnRequestDate: request['returnRequestDate'],
                  refundAmount: request['refundAmount'],
                  status: request['status'],
                  onCancelReturn: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Cancel return request for ${request['productName']}',
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildApprovedRequestsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          if (_approvedRequests.isEmpty)
            const EmptyTabStateWidget(message: 'No Approved Requests')
          else
            Column(
              children: _approvedRequests.map((request) {
                return ReturnRequestCardWidget(
                  productId: request['productId'],
                  productName: request['productName'],
                  productImage: request['productImage'],
                  price: request['price'],
                  quantity: request['quantity'],
                  receivedDate: request['receivedDate'],
                  returnRequestDate: request['returnRequestDate'],
                  refundAmount: request['refundAmount'],
                  status: request['status'],
                  onCancelReturn: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Cancel return request for ${request['productName']}',
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildReturnedRefundedTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          if (_returnedRefunded.isEmpty)
            const EmptyTabStateWidget(message: 'No Returned/Refunded Items')
          else
            Column(
              children: _returnedRefunded.map((item) {
                return ReturnedRefundedCardWidget(
                  productId: item['productId'],
                  productName: item['productName'],
                  productImage: item['productImage'],
                  price: item['price'],
                  quantity: item['quantity'],
                  receivedDate: item['receivedDate'],
                  returnedDate: item['returnedDate'],
                  refundAmount: item['refundAmount'],
                  refundMethod: item['refundMethod'],
                  returnRequestDate: item['returnRequestDate'],
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildCancelledTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          if (_cancelledReturns.isEmpty)
            const EmptyTabStateWidget(message: 'No Cancelled Returns')
          else
            Column(
              children: _cancelledReturns.map((item) {
                return CancelledReturnCardWidget(
                  productId: item['productId'],
                  productName: item['productName'],
                  productImage: item['productImage'],
                  price: item['price'],
                  quantity: item['quantity'],
                  receivedDate: item['receivedDate'],
                  cancelledDate: item['cancelledDate'],
                  refundAmount: item['refundAmount'],
                  adminMessage: item['adminMessage'],
                  returnRequestDate: item['returnRequestDate'],
                );
              }).toList(),
            ),
        ],
      ),
    );
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
          'Return / Refund',
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
                Tab(text: 'Requests'),
                Tab(text: 'Approved'),
                Tab(text: 'Returned/Refunded'),
                Tab(text: 'Cancelled'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildRequestTab(),
          _buildApprovedRequestsTab(),
          _buildReturnedRefundedTab(),
          _buildCancelledTab(),
        ],
      ),
    );
  }
}






























