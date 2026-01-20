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
      'name': 'BMW M4 Series sasa asas asas asadsadsa',
      'price': '\$155,000',
      'rating': 4.5,
      'status': 'New',
      'image': Icons.directions_car,
      'color': Colors.grey[300],
      'discount': 20,
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: const TopBarWidget(),
      ),
      endDrawer: const CategoriesDrawer(),
      endDrawerEnableOpenDragGesture: false,
      drawerScrimColor: Colors.black.withOpacity(0.4),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// SPECIAL OFFERS TITLE
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 16, 10, 4),
                child: const Text(
                  'Special Offers',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),

              // const SizedBox(height: 12),

              /// 🔥 SPECIAL OFFERS CAROUSEL
              Padding(
                padding: const EdgeInsets.all(4),
                child: const CarouselWidget(),
              ),

              const SizedBox(height: 16),

              /// BRANDS
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: const BrandBoxesWidget(),
              ),

              const SizedBox(height: 24),

              /// TOP DEALS
              // const TopDealsWidget(
              //   title: 'Top Brands',
              //   items: ['All', 'Mercedes', 'Tesla', 'BMW'],
              // ),
              
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(12, 24, 12, 24),
                decoration: BoxDecoration(
                  color: Colors.blue[50], // light blue background
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Heighest Discounted Products",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    ProductDisplayWidget(
                      cars: [
                        {
                          'name': 'BMW M4 Series',
                          'price': '\$155,000',
                          'rating': 4.5,
                          'status': 'New',
                          'image': Icons.directions_car,
                          'color': Colors.grey,
                        },
                        {
                          'name': 'Camaro Sports',
                          'price': '\$170,000',
                          'rating': 4.7,
                          'status': 'New',
                          'image': Icons.directions_car,
                          'color': Colors.amber,
                        },
                        {
                          'name': 'Audi Sports',
                          'price': '\$133,000',
                          'rating': 4.1,
                          'status': 'Used',
                          'image': Icons.directions_car,
                          'color': Colors.red,
                        },
                        {
                          'name': 'Audi Sports',
                          'price': '\$133,000',
                          'rating': 4.1,
                          'status': 'Used',
                          'image': Icons.directions_car,
                          'color': Colors.red,
                        },
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// CAR GRID
              Padding(
                padding: const EdgeInsets.all(10),
                child: ProductDisplayWidget(cars: cars),
              ),

              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(12, 24, 12, 24),
                decoration: BoxDecoration(
                  color: Colors.blue[50], // light blue background
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Latest Laptops",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        PrimaryBtnWidget(
                          onPressed: () {},
                          buttonText: "View All",
                          width: 100,
                          height: 36,
                          fontSize: 12,
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    ProductDisplayWidget(
                      cars: [
                        {
                          'name': 'BMW M4 Series',
                          'price': '\$155,000',
                          'rating': 4.5,
                          'status': 'New',
                          'image': Icons.directions_car,
                          'color': Colors.grey,
                        },
                        {
                          'name': 'Camaro Sports',
                          'price': '\$170,000',
                          'rating': 4.7,
                          'status': 'New',
                          'image': Icons.directions_car,
                          'color': Colors.amber,
                        },
                        {
                          'name': 'Audi Sports',
                          'price': '\$133,000',
                          'rating': 4.1,
                          'status': 'Used',
                          'image': Icons.directions_car,
                          'color': Colors.red,
                        },
                        {
                          'name': 'Audi Sports',
                          'price': '\$133,000',
                          'rating': 4.1,
                          'status': 'Used',
                          'image': Icons.directions_car,
                          'color': Colors.red,
                        },
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              CategoryViewCard(),
              const SizedBox(height: 24),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(12, 24, 12, 24),
                decoration: BoxDecoration(
                  color: Colors.blue[50], // light blue background
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Latest Earbuds",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        PrimaryBtnWidget(
                          onPressed: () {},
                          buttonText: "View All",
                          width: 100,
                          height: 36,
                          fontSize: 12,
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    ProductDisplayWidget(
                      cars: [
                        {
                          'name': 'BMW M4 Series',
                          'price': '\$155,000',
                          'rating': 4.5,
                          'status': 'New',
                          'image': Icons.directions_car,
                          'color': Colors.grey,
                        },
                        {
                          'name': 'Camaro Sports',
                          'price': '\$170,000',
                          'rating': 4.7,
                          'status': 'New',
                          'image': Icons.directions_car,
                          'color': Colors.amber,
                        },
                        {
                          'name': 'Audi Sports',
                          'price': '\$133,000',
                          'rating': 4.1,
                          'status': 'Used',
                          'image': Icons.directions_car,
                          'color': Colors.red,
                        },
                        {
                          'name': 'Audi Sports',
                          'price': '\$133,000',
                          'rating': 4.1,
                          'status': 'Used',
                          'image': Icons.directions_car,
                          'color': Colors.red,
                        },
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              ShopByPriceWidget(),

              const SizedBox(height: 24),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(12, 24, 12, 24),
                decoration: BoxDecoration(
                  color: Colors.blue[50], // light blue background
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Latest Watches",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        PrimaryBtnWidget(
                          onPressed: () {},
                          buttonText: "View All",
                          width: 100,
                          height: 36,
                          fontSize: 12,
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    ProductDisplayWidget(
                      cars: [
                        {
                          'name': 'BMW M4 Series',
                          'price': '\$155,000',
                          'rating': 4.5,
                          'status': 'New',
                          'image': Icons.directions_car,
                          'color': Colors.grey,
                        },
                        {
                          'name': 'Camaro Sports',
                          'price': '\$170,000',
                          'rating': 4.7,
                          'status': 'New',
                          'image': Icons.directions_car,
                          'color': Colors.amber,
                        },
                        {
                          'name': 'Audi Sports',
                          'price': '\$133,000',
                          'rating': 4.1,
                          'status': 'Used',
                          'image': Icons.directions_car,
                          'color': Colors.red,
                        },
                        {
                          'name': 'Audi Sports',
                          'price': '\$133,000',
                          'rating': 4.1,
                          'status': 'Used',
                          'image': Icons.directions_car,
                          'color': Colors.red,
                        },
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
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
