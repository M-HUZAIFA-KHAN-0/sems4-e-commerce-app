import 'package:first/core/app_imports.dart';
import 'dart:math';

class CategoryViewCard extends StatefulWidget {
  const CategoryViewCard({super.key});

  @override
  State<CategoryViewCard> createState() => _CategoryViewCardState();
}

class _CategoryViewCardState extends State<CategoryViewCard> {
  final CategoryService _categoryService = CategoryService();
  List<CategoryModel> _categories = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  /// Fetch categories from API
  Future<void> _fetchCategories() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final categories = await _categoryService.fetchCategories();

      setState(() {
        _categories = categories;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching categories: $e');
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to load categories';
      });
    }
  }

  /// Get max 4 categories randomly
  List<CategoryModel> _getRandomCategories() {
    if (_categories.isEmpty) return [];

    // If categories <= 4, return all
    if (_categories.length <= 4) {
      return _categories;
    }

    // If categories > 4, return 4 random ones
    final random = Random();
    final randomCategories = <CategoryModel>[];
    final indices = <int>{};

    while (indices.length < 4) {
      indices.add(random.nextInt(_categories.length));
    }

    for (var index in indices) {
      randomCategories.add(_categories[index]);
    }

    return randomCategories;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        padding: const EdgeInsets.all(16),
        child: const SizedBox(
          height: 100,
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    if (_errorMessage != null || _categories.isEmpty) {
      return const SizedBox.shrink();
    }

    // Get random categories (max 4)
    final displayCategories = _getRandomCategories();

    // Convert to ShopCategoryCardData
    final categoryCards = displayCategories.map((category) {
      return ShopCategoryCardData(
        image:
            category.categoryImage != null && category.categoryImage!.isNotEmpty
            ? NetworkImage(category.categoryImage!)
            : const AssetImage("../assets/brands/dell.png") as ImageProvider,
        title: category.categoryName,
        onTap: () {
          // Navigate to category view page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryViewPage(
                selectedCategoryId: category.categoryId,
                categoryName: category.categoryName,
              ),
            ),
          );
        },
      );
    }).toList();

    return Container(
      child: Column(
        children: [
          ShopMoreCategoriesWidget(
            title: "Popular Categories",
            items: categoryCards,
          ),
        ],
      ),
    );
  }
}
