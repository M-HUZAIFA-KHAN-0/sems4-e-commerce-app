import 'package:first/widgets/categories_drawer_widget.dart';
import 'package:first/core/app_imports.dart';

// import 'app_colors.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selectedFilter = 'All';
  int _selectedBottomIndex = 0;

  List<Map<String, dynamic>> cars = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeProducts();
  }

  Future<void> _initializeProducts() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final ProductService service = ProductService();
      List<ProductModel> products = await service.fetchProducts();

      setState(() {
        cars = products.map((product) => product.toMap()).toList();
        _isLoading = false;
        if (cars.isEmpty) {
          _errorMessage = 'No products available';
        }
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage =
            'Failed to load products. Please check your connection.';
      });
      print('Error initializing products: $e');
    }
  }

  // hello check

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        toolbarHeight: 60,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: const TopBarWidget(),
      ),
      drawer: const CategoriesDrawerWidget(),
      drawerEnableOpenDragGesture: false,
      drawerScrimColor: Colors.black.withOpacity(0.4),
      body: _errorMessage != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    _errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _initializeProducts,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// SPECIAL OFFERS TITLE
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 16, 10, 0),
                      child: GradientText(text: 'Special Offers'),
                    ),

                    /// 🔥 SPECIAL OFFERS CAROUSEL
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: const CarouselWidget(),
                    ),

                    const SizedBox(height: 10),

                    /// BRANDS
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: const CategoriesDisplayWidget(),
                    ),

                    const SizedBox(height: 24),

                    BGColorProdDisplayCard(
                      heading: "Heighest Discounted Products",
                      cars: cars,
                    ),

                    const SizedBox(height: 20),

                    /// CAR GRID
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ProductDisplayWidget(cars: cars),
                    ),

                    const SizedBox(height: 20),

                    BGColorProdDisplayCard(
                      heading: "Latest Laptops",
                      cars: cars,
                    ),

                    const SizedBox(height: 24),

                    CategoryViewCard(),
                    const SizedBox(height: 24),

                    BGColorProdDisplayCard(
                      heading: "Latest Earbuds",
                      cars: cars,
                    ),

                    const SizedBox(height: 24),

                    ShopByPriceWidget(),

                    const SizedBox(height: 24),

                    BGColorProdDisplayCard(
                      heading: "Latest Watches",
                      cars: cars,
                    ),

                    const SizedBox(height: 24),
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
