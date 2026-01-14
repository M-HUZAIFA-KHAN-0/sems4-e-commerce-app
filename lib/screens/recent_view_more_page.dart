



// import 'package:flutter/material.dart';
// import '../widgets/widgets.dart';

// class RecentViewMorePage extends StatefulWidget {
//   const RecentViewMorePage({super.key});
//   @override
//   State<RecentViewMorePage> createState() => _RecentViewMorePageState();
// }

// class _RecentViewMorePageState extends State<RecentViewMorePage> {
//   String selectedFilter = 'All';

//   // Function to parse date string 'dd/M/yyyy' to DateTime
//   DateTime parseDate(String dateStr) {
//     final parts = dateStr.split('/');
//     final day = int.parse(parts[0]);
//     final month = int.parse(parts[1]);
//     final year = int.parse(parts[2]);
//     return DateTime(year, month, day);
//   }

//   // 🔹 Dummy recent data (replace with API data)
//   // Changed 'viewedAt' to String in format 'dd/M/yyyy'
//   final List<Map<String, dynamic>> allRecentItems = [
//     {
//       'name': 'Laptop',
//       'viewedAt': '13/1/2026',
//       'imageUrl': 'https://picsum.photos/200?3',
//       'price': 'Rs 55,000',
//       'originalPrice': 'Rs 65,000',
//       'discount': '15',
//     },
//     {
//       'name': 'Laptop',
//       'viewedAt': '13/1/2026',
//       'imageUrl': 'https://picsum.photos/200?3',
//       'price': 'Rs 55,000',
//       'originalPrice': 'Rs 65,000',
//       'discount': '15',
//     },
//     {
//       'name': 'Laptop',
//       'viewedAt': '13/1/2026',
//       'imageUrl': 'https://picsum.photos/200?3',
//       'price': 'Rs 55,000',
//       'originalPrice': 'Rs 65,000',
//       'discount': '15',
//     },
//     {
//       'name': 'Mobile',
//       'viewedAt': '9/1/2026',
//       'imageUrl': 'https://picsum.photos/200?3',
//       'price': 'Rs 25,000',
//       'originalPrice': 'Rs 30,000',
//       'discount': '17',
//     },
//     {
//       'name': 'Headphones',
//       'viewedAt': '4/1/2026',
//       'imageUrl': 'https://picsum.photos/200?3',
//       'price': 'Rs 2,999',
//       'originalPrice': 'Rs 4,000',
//       'discount': '25',
//     },
//     {
//       'name': 'Headphones',
//       'viewedAt': '4/1/2026',
//       'imageUrl': 'https://picsum.photos/200?3',
//       'price': 'Rs 2,999',
//       'originalPrice': 'Rs 4,000',
//       'discount': '25',
//     },
//     {
//       'name': 'Headphones',
//       'viewedAt': '4/1/2026',
//       'imageUrl': 'https://picsum.photos/200?3',
//       'price': 'Rs 2,999',
//       'originalPrice': 'Rs 4,000',
//       'discount': '25',
//     },
//     {
//       'name': 'Mouse',
//       'viewedAt': '25/12/2025',
//       'imageUrl': 'https://picsum.photos/200?3',
//       'price': 'Rs 999',
//       'originalPrice': 'Rs 1,500',
//       'discount': '33',
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
//     final now = DateTime.now();
//     final cutoffDate = DateTime(now.year, now.month, now.day).subtract(Duration(days: days));
//     return allRecentItems
//         .where((item) {
//           final viewedStr = item['viewedAt'] as String;
//           final viewedDate = parseDate(viewedStr);
//           return !viewedDate.isBefore(cutoffDate);
//         })
//         .toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final items = filteredItems;

//     // Sort items by viewedAt descending
//     items.sort((a, b) => parseDate(b['viewedAt'] as String).compareTo(parseDate(a['viewedAt'] as String)));

//     // Group by date string (since it's already the formatted date)
//     final Map<String, List<Map<String, dynamic>>> groups = {};
//     for (var item in items) {
//       final dateStr = item['viewedAt'] as String;
//       groups.putIfAbsent(dateStr, () => []);
//       groups[dateStr]!.add(item);
//     }

//     final dateKeys = groups.keys.toList();

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
//           // 🔥 FILTER WIDGET (same design as tumhara TopDealsWidget)
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
//             child: items.isEmpty
//                 ? const Center(
//                     child: Text(
//                       'No recently viewed items',
//                       style: TextStyle(color: Colors.grey),
//                     ),
//                   )
//                 : Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 7),
//                     child: ListView.builder(
//                       itemCount: dateKeys.length,
//                       itemBuilder: (context, index) {
//                         final dateStr = dateKeys[index];
//                         final groupItems = groups[dateStr]!;
//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.fromLTRB(9, 16, 0, 8),
//                               child: Text(
//                                 dateStr,
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.black87,
//                                 ),
//                               ),
//                             ),
//                             ProductCardGrid(
//                               items: groupItems.map((item) {
//                                 return ProductItem(
//                                   prodName: item['name'],
//                                   imageUrl: item['imageUrl'],
//                                   price: item['price'],
//                                   originalPrice: item['originalPrice'],
//                                   discount: item['discount'],
//                                   tag: 'Viewed on ${item['viewedAt']}',
//                                   onTap: () {
//                                     print('Image tapped: ${item['name']}');
//                                   },
//                                 );
//                               }).toList(),
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }








































import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class RecentViewMorePage extends StatefulWidget {
  const RecentViewMorePage({super.key});
  @override
  State<RecentViewMorePage> createState() => _RecentViewMorePageState();
}

class _RecentViewMorePageState extends State<RecentViewMorePage> {
  String selectedFilter = 'All';

  // Function to parse date string 'dd/M/yyyy' to DateTime
  DateTime parseDate(String dateStr) {
    final parts = dateStr.split('/');
    final day = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final year = int.parse(parts[2]);
    return DateTime(year, month, day);
  }

  // 🔹 Dummy recent data (replace with API data)
  // Changed 'viewedAt' to String in format 'dd/M/yyyy'
  final List<Map<String, dynamic>> allRecentItems = [
    {
      'name': 'Laptop',
      'viewedAt': '13/1/2026',
      'imageUrl': 'https://picsum.photos/200?3',
      'price': 'Rs 55,000',
      'originalPrice': 'Rs 65,000',
      'discount': '15',
    },
    {
      'name': 'Mobile',
      'viewedAt': '9/1/2026',
      'imageUrl': 'https://picsum.photos/200?3',
      'price': 'Rs 25,000',
      'originalPrice': 'Rs 30,000',
      'discount': '17',
    },
    {
      'name': 'Mobile',
      'viewedAt': '9/1/2026',
      'imageUrl': 'https://picsum.photos/200?3',
      'price': 'Rs 25,000',
      'originalPrice': 'Rs 30,000',
      'discount': '17',
    },
    {
      'name': 'Mobile',
      'viewedAt': '9/1/2026',
      'imageUrl': 'https://picsum.photos/200?3',
      'price': 'Rs 25,000',
      'originalPrice': 'Rs 30,000',
      'discount': '17',
    },
    {
      'name': 'Mobile',
      'viewedAt': '9/1/2026',
      'imageUrl': 'https://picsum.photos/200?3',
      'price': 'Rs 25,000',
      'originalPrice': 'Rs 30,000',
      'discount': '17',
    },
    {
      'name': 'Mobile',
      'viewedAt': '9/1/2026',
      'imageUrl': 'https://picsum.photos/200?3',
      'price': 'Rs 25,000',
      'originalPrice': 'Rs 30,000',
      'discount': '17',
    },
    {
      'name': 'Mobile',
      'viewedAt': '9/1/2026',
      'imageUrl': 'https://picsum.photos/200?3',
      'price': 'Rs 25,000',
      'originalPrice': 'Rs 30,000',
      'discount': '17',
    },
    {
      'name': 'Headphones',
      'viewedAt': '4/1/2026',
      'imageUrl': 'https://picsum.photos/200?3',
      'price': 'Rs 2,999',
      'originalPrice': 'Rs 4,000',
      'discount': '25',
    },
    {
      'name': 'Mouse',
      'viewedAt': '25/12/2025',
      'imageUrl': 'https://picsum.photos/200?3',
      'price': 'Rs 999',
      'originalPrice': 'Rs 1,500',
      'discount': '33',
    },
    {
      'name': 'Mouse',
      'viewedAt': '25/12/2025',
      'imageUrl': 'https://picsum.photos/200?3',
      'price': 'Rs 999',
      'originalPrice': 'Rs 1,500',
      'discount': '33',
    },
    {
      'name': 'Mouse',
      'viewedAt': '25/12/2025',
      'imageUrl': 'https://picsum.photos/200?3',
      'price': 'Rs 999',
      'originalPrice': 'Rs 1,500',
      'discount': '33',
    },
    {
      'name': 'Mouse',
      'viewedAt': '25/12/2025',
      'imageUrl': 'https://picsum.photos/200?3',
      'price': 'Rs 999',
      'originalPrice': 'Rs 1,500',
      'discount': '33',
    },
    {
      'name': 'Mouse',
      'viewedAt': '25/12/2025',
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
    final now = DateTime.now();
    final cutoffDate = DateTime(now.year, now.month, now.day).subtract(Duration(days: days));
    return allRecentItems
        .where((item) {
          final viewedStr = item['viewedAt'] as String;
          final viewedDate = parseDate(viewedStr);
          return !viewedDate.isBefore(cutoffDate);
        })
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final items = filteredItems;

    // Sort items by viewedAt descending
    items.sort((a, b) => parseDate(b['viewedAt'] as String).compareTo(parseDate(a['viewedAt'] as String)));

    // Group by date string (since it's already the formatted date)
    final Map<String, List<Map<String, dynamic>>> groups = {};
    for (var item in items) {
      final dateStr = item['viewedAt'] as String;
      groups.putIfAbsent(dateStr, () => []);
      groups[dateStr]!.add(item);
    }

    final dateKeys = groups.keys.toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        title: const Text("Recently Viewed"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: ListView(
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
          if (filteredItems.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: const Center(
                child: Text(
                  'No recently viewed items',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ...dateKeys.map((dateStr) {
            final groupItems = groups[dateStr]!;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(9, 16, 0, 8),
                    child: Text(
                      dateStr,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  ProductCardGrid(
                    items: groupItems.map((item) {
                      return ProductItem(
                        prodName: item['name'],
                        imageUrl: item['imageUrl'],
                        price: item['price'],
                        originalPrice: item['originalPrice'],
                        discount: item['discount'],
                        tag: 'Viewed on ${item['viewedAt']}',
                        onTap: () {
                          print('Image tapped: ${item['name']}');
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}