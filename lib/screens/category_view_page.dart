import 'package:first/core/app_imports.dart';
import 'package:first/widgets/categories_drawer_widget.dart';

class CategoryViewPage extends StatefulWidget {
  const CategoryViewPage({super.key});

  @override
  State<CategoryViewPage> createState() => _CategoryViewPageState();
}

class _CategoryViewPageState extends State<CategoryViewPage> {
  String selectedFilter = 'All';
  int _selectedBottomIndex = 0;

  final List<Map<String, dynamic>> cars = [
    {
      'name': 'BMW M4 Series sasa asas asas asadsadsa',
      'price': '\$155,000',
      'rating': 4.5,
      'status': 'New',
      'image': Icons.directions_car,
      'color': AppColors.backgroundGreyLight,
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
      backgroundColor: AppColors.backgroundWhite,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: Container(
          color: AppColors.backgroundWhite,
          child: const TopBarWidget(),
        ),
      ),
      endDrawer: const CategoriesDrawer(),
      endDrawerEnableOpenDragGesture: false,
      drawerScrimColor: AppColors.textBlack.withOpacity(0.4),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
          } else if (index == 0) {
            // Navigate to Profile page when Profile icon is clicked
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyHomePage()),
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
