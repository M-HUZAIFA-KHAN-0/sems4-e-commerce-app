import 'package:first/core/app_imports.dart';

/// Reusable Add to Cart Confirmation Drawer
///
/// This drawer shows the selected Storage, Color, and Quantity options
/// with the exact same UI styling as the Product Detail Page.
/// It opens when the user taps "Add to Cart" to confirm their selections.
class AddToCartConfirmationDrawer extends StatefulWidget {
  final String selectedStorage;
  final String selectedColor;
  final int selectedQuantity;
  final int availableStock;
  final Map<String, dynamic> product;
  final Function(String storage, String color, int quantity) onConfirm;

  const AddToCartConfirmationDrawer({
    super.key,
    required this.selectedStorage,
    required this.selectedColor,
    required this.selectedQuantity,
    required this.availableStock,
    required this.product,
    required this.onConfirm,
  });

  @override
  State<AddToCartConfirmationDrawer> createState() =>
      _AddToCartConfirmationDrawerState();
}

class _AddToCartConfirmationDrawerState
    extends State<AddToCartConfirmationDrawer> {
  late String _currentStorage;
  late String _currentColor;
  late int _currentQuantity;
  bool _stockLimitReached = false;

  @override
  void initState() {
    super.initState();
    _currentStorage = widget.selectedStorage;
    _currentColor = widget.selectedColor;
    _currentQuantity = widget.selectedQuantity;
    _checkStockLimit();
  }

  void _checkStockLimit() {
    _stockLimitReached = _currentQuantity >= widget.availableStock;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.5,
      minChildSize: 0.4,
      maxChildSize: 0.8,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.backgroundWhite,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            children: [
              /// HEADER
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Confirm Selection',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryColor1,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              /// STORAGE SECTION
              const Text(
                'Storage',
                style: TextStyle(
                  fontSize: FontSize.homePageTitle,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondaryColor1,
                ),
              ),

              const SizedBox(height: 8),

              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _buildStorageOption('512GB - 8GB RAM'),
                  _buildStorageOption('256GB - 8GB RAM'),
                  _buildStorageOption('512GB - 16GB RAM'),
                ],
              ),

              const SizedBox(height: 24),

              /// COLOR SECTION
              const Text(
                'Colors',
                style: TextStyle(
                  fontSize: FontSize.homePageTitle,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondaryColor1,
                ),
              ),

              const SizedBox(height: 8),

              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildColorOption('Gold'),
                    const SizedBox(width: 12),
                    _buildColorOption('Silver'),
                    const SizedBox(width: 12),
                    _buildColorOption('Black'),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// QUANTITY SECTION
              const Text(
                'Quantity',
                style: TextStyle(
                  fontSize: FontSize.homePageTitle,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondaryColor1,
                ),
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  Container(
                    height: 44,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.backgroundGreyLight!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(
                            minWidth: 28,
                            minHeight: 28,
                          ),
                          icon: const Icon(Icons.remove, size: 20),
                          onPressed: () {
                            setState(() {
                              if (_currentQuantity > 1) {
                                _currentQuantity -= 1;
                                if (_currentQuantity < widget.availableStock) {
                                  _stockLimitReached = false;
                                }
                              }
                            });
                          },
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            _currentQuantity.toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(
                            minWidth: 28,
                            minHeight: 28,
                          ),
                          icon: const Icon(Icons.add, size: 20),
                          onPressed: () {
                            setState(() {
                              if (_currentQuantity < widget.availableStock) {
                                _currentQuantity += 1;
                                _stockLimitReached = false;
                              } else {
                                _stockLimitReached = true;
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    _stockLimitReached ? 'Stock not available' : '',
                    style: TextStyle(
                      color: _stockLimitReached ? Colors.red : Colors.grey[600],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              /// CONFIRM BUTTON
              Container(
                height: 46,
                decoration: BoxDecoration(
                  gradient: AppColors.bgGradient,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: ElevatedButton.icon(
                  onPressed: () {
                    widget.onConfirm(
                      _currentStorage,
                      _currentColor,
                      _currentQuantity,
                    );
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.white,
                    size: 24,
                  ),
                  label: const Text(
                    'Add to Cart',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// BUILD STORAGE OPTION - EXACT SAME UI AS PRODUCT DETAIL PAGE
  Widget _buildStorageOption(String storage) {
    bool isSelected = _currentStorage == storage;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentStorage = storage;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: isSelected ? AppColors.bgGradient : null,
          border: !isSelected
              ? Border.all(color: Colors.black, width: 1.5)
              : null,
        ),
        child: Container(
          padding: isSelected
              ? const EdgeInsets.symmetric(horizontal: 10, vertical: 7)
              : const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue[50] : AppColors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: ShaderMask(
            shaderCallback: (bounds) => isSelected
                ? AppColors.bgGradient.createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  )
                : LinearGradient(
                    colors: [AppColors.textBlack, AppColors.textBlack],
                  ).createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  ),
            child: Text(
              storage,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// BUILD COLOR OPTION - EXACT SAME UI AS PRODUCT DETAIL PAGE
  Widget _buildColorOption(String color) {
    bool isSelected = _currentColor == color;
    Color colorValue;

    switch (color) {
      case 'Gold':
        colorValue = AppColors.accentGold;
        break;
      case 'Silver':
        colorValue = AppColors.accentSilver;
        break;
      case 'Black':
        colorValue = AppColors.textBlack;
        break;
      default:
        colorValue = AppColors.textGrey;
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentColor = color;
        });
      },
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            padding: const EdgeInsets.all(1.5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              gradient: isSelected
                  ? AppColors.bgGradient
                  : LinearGradient(
                      colors: [
                        const Color.fromARGB(255, 255, 255, 255),
                        const Color.fromARGB(255, 255, 255, 255),
                      ],
                    ),
            ),
            child: Container(
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: colorValue,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            color,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
