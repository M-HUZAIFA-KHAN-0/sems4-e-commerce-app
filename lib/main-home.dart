// import 'package:flutter/material.dart';

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   String selectedFilter = 'All';

//   final List<Map<String, dynamic>> cars = [
//     {
//       'name': 'BMW M4 Series',
//       'price': '\$155,000',
//       'rating': 4.5,
//       'status': 'New',
//       'image': Icons.directions_car,
//       'color': Colors.grey[300],
//     },
//     {
//       'name': 'Camaro Sports',
//       'price': '\$170,000',
//       'rating': 4.7,
//       'status': 'New',
//       'image': Icons.directions_car,
//       'color': Colors.amber[100],
//     },
//     {
//       'name': 'Audi Sports',
//       'price': '\$133,000',
//       'rating': 4.1,
//       'status': 'Used',
//       'image': Icons.directions_car,
//       'color': Colors.red[100],
//     },
//     {
//       'name': 'McLaren Supercar',
//       'price': '\$190,000',
//       'rating': 4.9,
//       'status': 'New',
//       'image': Icons.directions_car,
//       'color': Colors.grey[200],
//     },
//     {
//       'name': 'Sedan Series',
//       'price': '\$167,000',
//       'rating': 4.6,
//       'status': 'New',
//       'image': Icons.directions_car,
//       'color': Colors.blue[100],
//     },
//     {
//       'name': 'Ferrari Sports',
//       'price': '\$185,000',
//       'rating': 4.5,
//       'status': 'Used',
//       'image': Icons.directions_car,
//       'color': Colors.yellow[100],
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 16),
//               // Header with profile
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 24,
//                         backgroundColor: Colors.grey[300],
//                         child: const Icon(Icons.person, color: Colors.grey),
//                       ),
//                       const SizedBox(width: 12),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'Good Morning 👋',
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Colors.grey,
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           const Text(
//                             'Andrew Ainsley',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       IconButton(
//                         icon: const Icon(Icons.notifications_none),
//                         onPressed: () {},
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.favorite_border),
//                         onPressed: () {},
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               // Search Bar
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(
//                         hintText: 'Search',
//                         prefixIcon: const Icon(Icons.search, color: Colors.grey),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: Colors.grey[300]!),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: Colors.grey[300]!),
//                         ),
//                         contentPadding: const EdgeInsets.symmetric(
//                           horizontal: 16,
//                           vertical: 12,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Colors.grey[200],
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     padding: const EdgeInsets.all(12),
//                     child: const Icon(Icons.tune, color: Colors.black54),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 24),
//               // Special Offers Section
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     'Special Offers',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () {},
//                     child: const Text(
//                       'See All',
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 12),
//               // Special Offers Card
//               Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 padding: const EdgeInsets.all(16),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             '20%',
//                             style: TextStyle(
//                               fontSize: 36,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const Text(
//                             'Week Deals!',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           const Text(
//                             'Get a new car discount\nonly valid this week',
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Colors.black54,
//                               height: 1.5,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       child: Container(
//                         height: 120,
//                         decoration: BoxDecoration(
//                           color: Colors.grey[300],
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Icon(
//                           Icons.directions_car,
//                           size: 60,
//                           color: Colors.grey[400],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 24),
//               // Car Brands Grid
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   GridView.count(
//                     crossAxisCount: 4,
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     mainAxisSpacing: 12,
//                     crossAxisSpacing: 12,
//                     children: [
//                       _buildBrandIcon('Mercedes'),
//                       _buildBrandIcon('Tesla'),
//                       _buildBrandIcon('BMW'),
//                       _buildBrandIcon('Toyota'),
//                       _buildBrandIcon('Volvo'),
//                       _buildBrandIcon('Bugatti'),
//                       _buildBrandIcon('Honda'),
//                       _buildBrandIcon('More'),
//                     ],
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 24),
//               // Top Deals Section
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     'Top Deals',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () {},
//                     child: const Text(
//                       'See All',
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 12),
//               // Filter Chips
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: [
//                     _buildFilterChip('All'),
//                     const SizedBox(width: 8),
//                     _buildFilterChip('Mercedes'),
//                     const SizedBox(width: 8),
//                     _buildFilterChip('Tesla'),
//                     const SizedBox(width: 8),
//                     _buildFilterChip('BMW'),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               // Car Grid
//               GridView.builder(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   mainAxisSpacing: 16,
//                   crossAxisSpacing: 12,
//                   childAspectRatio: 0.75,
//                 ),
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: cars.length,
//                 itemBuilder: (context, index) {
//                   return _buildCarCard(cars[index]);
//                 },
//               ),
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildBrandIcon(String brand) {
//     final icons = {
//       'Mercedes': Icons.star,
//       'Tesla': Icons.flash_on,
//       'BMW': Icons.settings,
//       'Toyota': Icons.directions_car,
//       'Volvo': Icons.build,
//       'Bugatti': Icons.speed,
//       'Honda': Icons.nature,
//       'More': Icons.more_horiz,
//     };

//     return Column(
//       children: [
//         Container(
//           width: 50,
//           height: 50,
//           decoration: BoxDecoration(
//             color: Colors.grey[200],
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Icon(
//             icons[brand] ?? Icons.directions_car,
//             color: Colors.black54,
//             size: 24,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           brand,
//           style: const TextStyle(
//             fontSize: 11,
//             fontWeight: FontWeight.w500,
//           ),
//           textAlign: TextAlign.center,
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//         ),
//       ],
//     );
//   }

//   Widget _buildFilterChip(String label) {
//     bool isSelected = selectedFilter == label;
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selectedFilter = label;
//         });
//       },
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         decoration: BoxDecoration(
//           color: isSelected ? Colors.black : Colors.transparent,
//           border: Border.all(
//             color: isSelected ? Colors.black : Colors.grey[300]!,
//           ),
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Text(
//           label,
//           style: TextStyle(
//             fontSize: 12,
//             fontWeight: FontWeight.w500,
//             color: isSelected ? Colors.white : Colors.black87,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildCarCard(Map<String, dynamic> car) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 5,
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Car Image Container
//           Stack(
//             children: [
//               Container(
//                 height: 140,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: car['color'],
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(12),
//                     topRight: Radius.circular(12),
//                   ),
//                 ),
//                 child: Icon(
//                   car['image'],
//                   size: 80,
//                   color: Colors.grey[400],
//                 ),
//               ),
//               // Heart Icon
//               Positioned(
//                 top: 8,
//                 right: 8,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(6),
//                   ),
//                   padding: const EdgeInsets.all(4),
//                   child: const Icon(
//                     Icons.favorite_border,
//                     size: 16,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           // Car Details
//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   car['name'],
//                   style: const TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 const SizedBox(height: 4),
//                 Row(
//                   children: [
//                     const Icon(
//                       Icons.star,
//                       size: 12,
//                       color: Colors.amber,
//                     ),
//                     const SizedBox(width: 4),
//                     Text(
//                       car['rating'].toString(),
//                       style: const TextStyle(
//                         fontSize: 11,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     const SizedBox(width: 6),
//                     Text(
//                       car['status'],
//                       style: TextStyle(
//                         fontSize: 10,
//                         color: Colors.grey[600],
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   car['price'],
//                   style: const TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:first/screens/notification_page.dart';
import 'package:first/screens/profile_page.dart';
import 'package:first/screens/wishlist_page.dart';
import 'package:first/widgets/categories_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'widgets/widgets.dart';
import 'screens/add_to_card_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selectedFilter = 'All';
  int _selectedBottomIndex = 0;

  final List<Map<String, dynamic>> cars = [
    {
      'name': 'BMW M4 Series',
      'price': '\$155,000',
      'rating': 4.5,
      'status': 'New',
      'image': Icons.directions_car,
      'color': Colors.grey[300],
    },
    {
      'name': 'Camaro Sports',
      'price': '\$170,000',
      'rating': 4.7,
      'status': 'New',
      'image': Icons.directions_car,
      'color': Colors.amber[100],
    },
    {
      'name': 'Audi Sports',
      'price': '\$133,000',
      'rating': 4.1,
      'status': 'Used',
      'image': Icons.directions_car,
      'color': Colors.red[100],
    },
    {
      'name': 'McLaren Supercar',
      'price': '\$190,000',
      'rating': 4.9,
      'status': 'New',
      'image': Icons.directions_car,
      'color': Colors.grey[200],
    },
    {
      'name': 'Sedan Series',
      'price': '\$167,000',
      'rating': 4.6,
      'status': 'New',
      'image': Icons.directions_car,
      'color': Colors.blue[100],
    },
    {
      'name': 'Ferrari Sports',
      'price': '\$185,000',
      'rating': 4.5,
      'status': 'Used',
      'image': Icons.directions_car,
      'color': Colors.yellow[100],
    },
  ];

  // hello check

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: Container(color: Colors.white, child: const TopBarWidget()),
      ),
      endDrawer: const CategoriesDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// SPECIAL OFFERS TITLE
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Special Offers',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  // TextButton(onPressed: () {}, child: const Text('See All')),
                ],
              ),

              const SizedBox(height: 12),

              /// 🔥 SPECIAL OFFERS CAROUSEL
              const CarouselWidget(),

              const SizedBox(height: 24),

              /// BRANDS
              const BrandBoxesWidget(),

              const SizedBox(height: 24),

              /// TOP DEALS
              const TopDealsWidget(
                title: 'Top Brands',
                items: ['All', 'Mercedes', 'Tesla', 'BMW'],
              ),

              const SizedBox(height: 20),

              /// CAR GRID
              ProductDisplayWidget(cars: cars),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBarWidget(
        isLoggedIn: false,
        currentIndex: _selectedBottomIndex,
        onIndexChanged: (index) {
          if (index == 3) {
            // Navigate to Cart page when Bag icon is clicked
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartPageExample()),
            );
          } else if (index == 2) {
            // Navigate to Profile page when Profile icon is clicked
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WishlistPage()),
            );
          } else if (index == 1) {
            // Navigate to Profile page when Profile icon is clicked
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NotificationPage()),
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
        },
      ),
    );
  }
}
