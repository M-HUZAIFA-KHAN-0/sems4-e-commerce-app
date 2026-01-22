import 'package:first/core/app_imports.dart';

class ComparisonProductSlotWidget extends StatefulWidget {
  final Map<String, dynamic>? product;
  final List<Map<String, dynamic>> allProducts;
  final VoidCallback onSelect;
  final VoidCallback onClear;
  final Function(Map<String, dynamic>) onProductPicked;

  const ComparisonProductSlotWidget({
    super.key,
    required this.product,
    required this.allProducts,
    required this.onSelect,
    required this.onClear,
    required this.onProductPicked,
  });

  @override
  State<ComparisonProductSlotWidget> createState() =>
      _ComparisonProductSlotWidgetState();
}

class _ComparisonProductSlotWidgetState
    extends State<ComparisonProductSlotWidget> {
  late TextEditingController _searchCtrl;

  @override
  void initState() {
    super.initState();
    _searchCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _showProductPicker() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return ListView.builder(
          itemCount: widget.allProducts.length,
          itemBuilder: (ctx, idx) {
            final p = widget.allProducts[idx];
            return ListTile(
              leading: Image.network(
                p['imageUrl'],
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Container(width: 50, height: 50, color: Colors.grey[200]),
              ),
              title: Text(p['title']),
              subtitle: Text(p['price']),
              onTap: () {
                widget.onProductPicked(p);
                Navigator.pop(ctx);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // close button in top right - only show if product exists
            if (widget.product != null)
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: widget.onClear,
                  child: Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      color: AppColors.backgroundGreyLight,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.close, size: 18, color: Colors.grey[600]),
                  ),
                ),
              )
            else
              const SizedBox(height: 12),
            if (widget.product != null) const SizedBox(height: 12),
            if (widget.product != null) ...[
              // Product image
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  widget.product!['imageUrl'],
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return Container(
                      width: 90,
                      height: 90,
                      color: Colors.grey[200],
                      child: const Center(
                        child: Icon(Icons.image_not_supported),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              // Product name
              Text(
                (widget.product!['title'] ?? 'Product') as String,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  height: 1.1,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              // Price
              Text(
                (widget.product!['price'] ?? 'Price not available') as String,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: AppColors.textBlack87,
                ),
              ),
              if (widget.product!['discount'] != null)
                // Container(
                //   padding: const EdgeInsets.symmetric(
                //     horizontal: 8,
                //     vertical: 4,
                //   ),
                //   decoration: BoxDecoration(
                //     color: Colors.greenAccent[100],
                //     borderRadius: BorderRadius.circular(4),
                //   ),
                //   // child: Text(
                //   //   widget.product!['discount'],
                //   //   style: const TextStyle(
                //   //     color: Colors.green,
                //   //     fontWeight: FontWeight.w600,
                //   //     fontSize: 12,
                //   //   ),
                //   // ),
                // ),
                const SizedBox(height: 12),
              // Add to Cart button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryOrange,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text(
                    'Add to Cart',
                    style: TextStyle(
                      color: AppColors.backgroundWhite,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ] else ...[
              Text(
                "Select a product to compare",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              // Empty state with search input
              const SizedBox(height: 24),
              GestureDetector(
                onTap: _showProductPicker,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue.shade300, width: 2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Compare with',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blue.shade700,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
