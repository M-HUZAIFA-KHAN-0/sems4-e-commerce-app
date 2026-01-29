import 'package:first/core/app_imports.dart';
// import 'package:first/widgets/categories_drawer_widget.dart';

class CategoryViewPage extends StatefulWidget {
  final int selectedCategoryId;
  final String categoryName;


  const CategoryViewPage({
    super.key,
    required this.selectedCategoryId,
    required this.categoryName,
  });
  // const CategoryViewPage({super.key});

  @override
  State<CategoryViewPage> createState() => _CategoryViewPageState();
}

class _CategoryViewPageState extends State<CategoryViewPage> {
  String selectedFilter = 'All';
  int _selectedBottomIndex = 0;

  final List<Map<String, dynamic>> prodItems = [
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
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        foregroundColor: AppColors.textBlack87,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text(
          widget.categoryName,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, size: 24),
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
          ),
        ],
      ),
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
              ProductDisplayWidget(prodItems: prodItems),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBarWidget(
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
