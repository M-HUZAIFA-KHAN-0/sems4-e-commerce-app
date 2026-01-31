import 'package:first/core/app_imports.dart';
import 'package:first/services/api/product_view_service.dart';
import 'package:first/screens/product_detail_page.dart';

class RecentViewMorePage extends StatefulWidget {
  const RecentViewMorePage({super.key});
  @override
  State<RecentViewMorePage> createState() => _RecentViewMorePageState();
}

class _RecentViewMorePageState extends State<RecentViewMorePage> {
  final ProductViewService _viewService = ProductViewService();

  bool _isLoading = true;
  List<ProductViewDTO> _allViews = [];
  List<ProductViewDTO> _filteredViews = [];
  int _selectedDaysFilter =
      0; // 0 = All, 7 = 7 days, 14 = 14 days, 30 = 30 days

  @override
  void initState() {
    super.initState();
    _loadViews();
  }

  Future<void> _loadViews() async {
    try {
      final views = await _viewService.getAllProductViews();
      if (views == null) {
        if (!mounted) return;
        setState(() => _isLoading = false);
        return;
      }

      // Filter non-discounted products
      final nonDiscounted = _viewService.filterNonDiscounted(views);

      if (!mounted) return;
      setState(() {
        _allViews = nonDiscounted;
        _applyDateFilter();
        _isLoading = false;
      });

      print('✅ Loaded ${_allViews.length} non-discounted views');
    } catch (e) {
      print('❌ Error loading views: $e');
      if (!mounted) return;
      setState(() => _isLoading = false);
    }
  }

  void _applyDateFilter() {
    if (_selectedDaysFilter == 0) {
      // Show all
      _filteredViews = List.from(_allViews);
    } else {
      // Filter by days
      _filteredViews = _viewService.filterByDays(
        _allViews,
        _selectedDaysFilter,
      );
    }

    print(
      '📊 Applied filter: $_selectedDaysFilter days | ${_filteredViews.length} items shown',
    );
  }

  void _onFilterChanged(int days) {
    setState(() {
      _selectedDaysFilter = days;
      _applyDateFilter();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: AppColors.backgroundGreyLighter,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundWhite,
          elevation: 0,
          foregroundColor: AppColors.textBlack87,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, size: 20),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          title: const Text(
            'Recent Views',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundGreyLighter,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        foregroundColor: AppColors.textBlack87,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text(
          'Recent Views',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: Column(
        children: [
          // Filter tabs - Horizontal Scrollable
          Container(
            color: AppColors.backgroundWhite,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  _buildFilterTab('All', 0),
                  const SizedBox(width: 8),
                  _buildFilterTab('3 Days', 3),
                  const SizedBox(width: 8),
                  _buildFilterTab('7 Days', 7),
                  const SizedBox(width: 8),
                  _buildFilterTab('14 Days', 14),
                  const SizedBox(width: 8),
                  _buildFilterTab('30 Days', 30),
                ],
              ),
            ),
          ),
          const Divider(height: 1),
          // Product grid
          Expanded(
            child: _filteredViews.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.visibility_off,
                          size: 64,
                          color: AppColors.textGreyLabel,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No recent views',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.textGreyLabel,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                    itemCount: _filteredViews.length,
                    itemBuilder: (context, index) {
                      final view = _filteredViews[index];
                      return _buildProductCard(view);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTab(String label, int days) {
    final isSelected = _selectedDaysFilter == days;

    return GestureDetector(
      onTap: () => _onFilterChanged(days),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.textBlack
              : AppColors.backgroundGreyLighter,
          borderRadius: BorderRadius.circular(8),
          border: isSelected
              ? null
              : Border.all(color: AppColors.borderGreyLighter),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : AppColors.textGreyLabel,
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(ProductViewDTO view) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(productId: view.productId),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.backgroundGreyLighter,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child:
                    view.productImage != null && view.productImage!.isNotEmpty
                    ? ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                        child: Image.network(
                          view.productImage!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.image_not_supported);
                          },
                        ),
                      )
                    : const Icon(Icons.image_not_supported),
              ),
            ),
            // Product Info
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    view.productName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textBlack87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        'PKR ${view.discountPrice.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                          color: AppColors.textBlack87,
                        ),
                      ),
                      if (view.originalPrice > 0 &&
                          view.originalPrice != view.discountPrice)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Text(
                              'PKR ${view.originalPrice.toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontSize: 11,
                                decoration: TextDecoration.lineThrough,
                                color: AppColors.textGreyLabel,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatDate(view.viewedAt),
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.textGreyLabel,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Yesterday';
    } else if (difference < 7) {
      return '$difference days ago';
    } else if (difference < 30) {
      return '${(difference / 7).toStringAsFixed(0)} weeks ago';
    } else {
      return '${(difference / 30).toStringAsFixed(0)} months ago';
    }
  }
}
