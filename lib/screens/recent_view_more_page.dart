import 'package:flutter/material.dart';
import '../widgets/widgets.dart';


// class RecentViewMorePage extends StatefulWidget {
//   const RecentViewMorePage({super.key});

//   @override
//   State<RecentViewMorePage> createState() => _RecentViewMorePageState();
// }

// class _RecentViewMorePageState extends State<RecentViewMorePage> {
//   String selectedFilter = 'All';

//   // 🔹 Dummy recent data (replace with API data)
//   final List<Map<String, dynamic>> allRecentItems = [
//     {
//       'name': 'Laptop',
//       'viewedAt': DateTime.now().subtract(const Duration(days: 1)),
//     },
//     {
//       'name': 'Mobile',
//       'viewedAt': DateTime.now().subtract(const Duration(days: 5)),
//     },
//     {
//       'name': 'Headphones',
//       'viewedAt': DateTime.now().subtract(const Duration(days: 10)),
//     },
//     {
//       'name': 'Mouse',
//       'viewedAt': DateTime.now().subtract(const Duration(days: 20)),
//     },
//   ];

//   List<Map<String, dynamic>> get filteredItems {
//     if (selectedFilter == 'All') {
//       return allRecentItems;
//     }

//     int days = 0;

//     switch (selectedFilter) {
//       case 'Last 3 days':
//         days = 3;
//         break;
//       case 'Last 7 days':
//         days = 7;
//         break;
//       case 'Last 14 days':
//         days = 14;
//         break;
//       case 'Last 30 days':
//         days = 30;
//         break;
//     }

//     final cutoffDate = DateTime.now().subtract(Duration(days: days));

//     return allRecentItems
//         .where((item) =>
//             (item['viewedAt'] as DateTime).isAfter(cutoffDate))
//         .toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF3F4F6),
//       appBar: AppBar(
//         title: const Text("Recently Viewed"),
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black87,
//         elevation: 0,
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // 🔥 FILTER WIDGET
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: TopDealsWidget(
//               title: 'Filter by',
//               items: const [
//                 'All',
//                 'Last 3 days',
//                 'Last 7 days',
//                 'Last 14 days',
//                 'Last 30 days',
//               ],
//               initialSelected: selectedFilter,
//               onItemTap: (value) {
//                 setState(() {
//                   selectedFilter = value;
//                 });
//               },
//             ),
//           ),

//           // 🔹 LIST
//           Expanded(
//             child: filteredItems.isEmpty
//                 ? const Center(
//                     child: Text(
//                       'No recently viewed items',
//                       style: TextStyle(color: Colors.grey),
//                     ),
//                   )
//                 : ListView.builder(
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     itemCount: filteredItems.length,
//                     itemBuilder: (context, index) {
//                       final item = filteredItems[index];

//                       return Card(
//                         margin: const EdgeInsets.only(bottom: 12),
//                         child: ListTile(
//                           title: Text(item['name']),
//                           subtitle: Text(
//                             'Viewed on ${item['viewedAt'].toString().split(' ').first}',
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }




























class RecentViewMorePage extends StatefulWidget {
  const RecentViewMorePage({super.key});

  @override
  State<RecentViewMorePage> createState() => _RecentViewMorePageState();
}

class _RecentViewMorePageState extends State<RecentViewMorePage> {
  String selectedFilter = 'All';

  // 🔹 Dummy recent data (replace with API data)
  final List<Map<String, dynamic>> allRecentItems = [
    {
      'name': 'Laptop',
      'viewedAt': DateTime.now().subtract(const Duration(days: 1)),
      'imageUrl': 'https://picsum.photos/200?3',
      'price': 'Rs 55,000',
      'originalPrice': 'Rs 65,000',
      'discount': '15',
    },
    {
      'name': 'Mobile',
      'viewedAt': DateTime.now().subtract(const Duration(days: 5)),
      'imageUrl': 'https://picsum.photos/200?3',
      'price': 'Rs 25,000',
      'originalPrice': 'Rs 30,000',
      'discount': '17',
    },
    {
      'name': 'Headphones',
      'viewedAt': DateTime.now().subtract(const Duration(days: 10)),
      'imageUrl': 'https://picsum.photos/200?3',
      'price': 'Rs 2,999',
      'originalPrice': 'Rs 4,000',
      'discount': '25',
    },
    {
      'name': 'Mouse',
      'viewedAt': DateTime.now().subtract(const Duration(days: 20)),
      'imageUrl': 'https://picsum.photos/200?3',
      'price': 'Rs 999',
      'originalPrice': 'Rs 1,500',
      'discount': '33',
    },
  ];

  List<Map<String, dynamic>> get filteredItems {
    if (selectedFilter == 'All') {
      return allRecentItems;
    }

    int days = 0;
    switch (selectedFilter) {
      case 'Last 3 days':
        days = 3;
        break;
      case 'Last 7 days':
        days = 7;
        break;
      case 'Last 14 days':
        days = 14;
        break;
      case 'Last 30 days':
        days = 30;
        break;
    }

    final cutoffDate = DateTime.now().subtract(Duration(days: days));
    return allRecentItems
        .where((item) => (item['viewedAt'] as DateTime).isAfter(cutoffDate))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        title: const Text("Recently Viewed"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔥 FILTER WIDGET (same design as tumhara TopDealsWidget)
          Padding(
            padding: const EdgeInsets.all(16),
            child: TopDealsWidget(
              title: 'Filter by',
              items: const [
                'All',
                'Last 3 days',
                'Last 7 days',
                'Last 14 days',
                'Last 30 days',
              ],
              initialSelected: selectedFilter,
              onItemTap: (value) {
                setState(() {
                  selectedFilter = value;
                });
              },
            ),
          ),

          // 🔹 LIST
          Expanded(
            child: filteredItems.isEmpty
                ? const Center(
                    child: Text(
                      'No recently viewed items',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: ProductCardGrid(
                      items: filteredItems.map((item) {
                        return ProductItem(
                          prodName: item['name'],
                          imageUrl: item['imageUrl'],
                          price: item['price'],
                          originalPrice: item['originalPrice'],
                          discount: item['discount'],
                          tag: 'Viewed on ${item['viewedAt'].toString().split(' ')[0]}',
                          onTap: () {
                            print('Image tapped: ${item['name']}');
                          },
                        );
                      }).toList(),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}