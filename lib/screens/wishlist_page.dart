import 'package:first/core/app_imports.dart';
import 'package:first/services/api/wishlist_service.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  int _selectedBottomIndex = 2; // Set to 2 for wishlist page
  final UserSessionManager _sessionManager = UserSessionManager();

  bool _isLoading = true;
  String? _errorMessage;
  final _wishlistService = WishlistService();

  // Parent controls initial data + stock values
  List<CartProductItem> wishlistItems = [
    // CartProductItem(
    //   id: "1",
    //   title: "Air pods max by Apple",
    //   variantText: "Grey",
    //   priceText: "\$ 1999,99",
    //   quantity: 1,
    //   stock: 2,
    //   // imageUrl: "https://picsum.photos/200?1",
    //   imageUrl: "",
    //   isSelected: true,
    // ),
    // CartProductItem(
    //   id: "2",
    //   title: "Monitor LG 22”inc 4K 120Fps",
    //   variantText: "120 Fps",
    //   priceText: "\$ 299,99",
    //   quantity: 1,
    //   stock: 5,
    //   // imageUrl: "https://picsum.photos/200?2",
    //   imageUrl: "",
    //   isSelected: true,
    // ),
    // CartProductItem(
    //   id: "3",
    //   title: "Earphones for monitor",
    //   variantText: "Combo",
    //   priceText: "\$ 199,99",
    //   quantity: 1,
    //   stock: 1,
    //   // imageUrl: "https://picsum.photos/200?3",
    //   imageUrl: "",
    //   isSelected: true,
    // ),
  ];

  @override
  void initState() {
    super.initState();
    _fetchWishlistData();
  }

  Future<void> _fetchWishlistData() async {
    if (!_sessionManager.isLoggedIn) {
      setState(() => _isLoading = false);
      return;
    }

    try {
      final userId = _sessionManager.userId;
      if (userId == null) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'User ID not found';
        });
        return;
      }

      final wishlistData = await _wishlistService.getUserWishlist(
        userId: userId,
      );

      if (wishlistData != null && wishlistData['items'] is List) {
        final items = wishlistData['items'] as List;
        final convertedItems = items.map((item) {
          return _mapApiToCartItem(item as Map<String, dynamic>);
        }).toList();

        setState(() {
          wishlistItems = convertedItems;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage = 'No wishlist data found';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error loading wishlist: $e';
      });
      print('❌ Error fetching wishlist: $e');
    }
  }

  //  delete prod from wishlist API
  Future<void> _deleteWishlistItem(int wishlistItemId) async {
    try {
      await _wishlistService.removeItemFromWishlist(
        wishlistItemId: wishlistItemId,
      );

      // ✅ local list se bhi remove
      setState(() {
        wishlistItems.removeWhere((e) => e.id == wishlistItemId.toString());
      });

      print('✅ Wishlist item deleted: $wishlistItemId');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Item removed from wishlist'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      print('❌ Error deleting wishlist item: $e');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('❌ Failed to remove item from wishlist'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// Delete multiple items from wishlist
  Future<void> _deleteMultipleWishlistItems(List<int> wishlistItemIds) async {
    try {
      // Delete all items in parallel
      await Future.wait(
        wishlistItemIds.map(
          (id) => _wishlistService.removeItemFromWishlist(wishlistItemId: id),
        ),
      );

      // Remove from local list
      setState(() {
        for (var id in wishlistItemIds) {
          wishlistItems.removeWhere((e) => e.id == id.toString());
        }
      });

      print('✅ ${wishlistItemIds.length} items deleted from wishlist');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '✅ ${wishlistItemIds.length} items removed from wishlist',
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      print('❌ Error deleting multiple items: $e');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('❌ Failed to remove items from wishlist'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  CartProductItem _mapApiToCartItem(Map<String, dynamic> apiItem) {
    // final variantSpecs = apiItem['variantSpecifications'] as List? ?? [];
    // final variantText = variantSpecs.isNotEmpty
    //     ? variantSpecs.map((spec) => '${spec['optionValue']}').join(', ')
    //     : 'Standard';

    final variantSpecs = apiItem['variantSpecifications'] as List? ?? [];

    String ram = '';
    String storage = '';
    String color = '';

    for (final spec in variantSpecs) {
      if (spec['specificationName'] == 'RAM') {
        ram = spec['optionValue'];
      }
      if (spec['specificationName'] == 'Storage') {
        storage = spec['optionValue'];
      }
    }

    final ramStorageText = (ram.isNotEmpty && storage.isNotEmpty)
        ? '$ram - $storage'
        : 'Standard';

    for (final spec in variantSpecs) {
      if (spec['specificationName'] == 'Color') {
        color = spec['optionValue'];
        break; // 🔥 sirf ek color chahiye
      }
    }

    print(
      'Mapping wishlist item: ${apiItem['productName']} with variant: $ramStorageText , color : $color , variantSpecs: $variantSpecs',
    );

    return CartProductItem(
      id:
          apiItem['wishlistItemId']?.toString() ??
          '${DateTime.now().millisecondsSinceEpoch}',
      title: apiItem['productName'] ?? 'Unknown Product',
      // variantText: '$ramStorageText , Color: $color',
      ramStorageText: ramStorageText,
      color: color,
      priceText: 'PKR ${(apiItem['price'] ?? 0).toStringAsFixed(2)}',
      quantity: 1,
      stock: 5,
      imageUrl: apiItem['image'] ?? '',
      isSelected: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Handle loading and error states
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
            'My Wishlist',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_errorMessage != null && !_sessionManager.isLoggedIn) {
      return _buildLoginRequiredState();
    }

    // ✅ calculate ONLY selected items
    final selectedItems = wishlistItems.where((e) => e.isSelected).toList();
    final selectedCount = selectedItems.length;
    final isLoggedIn = _sessionManager.isLoggedIn;

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
          'My Wishlist',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: isLoggedIn
          ? _buildWishlistContent(selectedItems, selectedCount)
          : _buildLoginRequiredState(),
      bottomNavigationBar: BottomBarWidget(
        currentIndex: _selectedBottomIndex,
        onIndexChanged: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyHomePage()),
            );
          } else if (index == 1) {
            // Navigate to Profile page when Profile icon is clicked
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NotificationPage()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartPageExample()),
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
          setState(() {
            _selectedBottomIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildWishlistContent(
    List<CartProductItem> selectedItems,
    int selectedCount,
  ) {
    return Column(
      children: [
        Expanded(
          child: WishlistListWidget(
            items: wishlistItems,
            onChanged: (updatedItems) {
              setState(() {
                wishlistItems = updatedItems;
              });
            },
            onDeleteItem: (itemId) {
              final intId = int.tryParse(itemId);
              if (intId != null) {
                _deleteWishlistItem(intId);
              }
            },
            onDeleteMultiple: (itemIds) {
              final intIds = itemIds
                  .map((id) => int.tryParse(id))
                  .where((id) => id != null)
                  .cast<int>()
                  .toList();
              if (intIds.isNotEmpty) {
                _deleteMultipleWishlistItems(intIds);
              }
            },
            emptyMessage:
                "Your wishlist is empty.\nWhen you add products, they'll\nappear here.",
          ),
        ),

        // Add-all button shown when more than one selected
        if (selectedCount > 1)
          Container(
            color: AppColors.backgroundWhite,
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
            child: PrimaryBtnWidget(
              onPressed: () {
                final selectedIds = wishlistItems
                    .where((e) => e.isSelected)
                    .map((e) => int.tryParse(e.id))
                    .where((id) => id != null)
                    .cast<int>()
                    .toList();

                if (selectedIds.isNotEmpty) {
                  _deleteMultipleWishlistItems(selectedIds);
                }
              },
              buttonText: 'Add all items to cart',
            ),
          ),
      ],
    );
  }

  Widget _buildLoginRequiredState() {
    return EmptyStateWidget(
      emptyMessage:
          "Sign in to your account to view\nyour wishlist and saved items.",
      icon: Icons.favorite_border,
      buttonText: "Sign In",
      onButtonPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      },
    );
  }
}

// Local wishlist list widget (keeps behavior local to this file)
class WishlistListWidget extends StatefulWidget {
  const WishlistListWidget({
    super.key,
    this.items,
    this.onChanged,
    this.onShopNow,
    this.onDeleteItem,
    this.onDeleteMultiple,
    this.emptyMessage =
        "Your wishlist is empty.\nWhen you add products, they'll\nappear here.",
  });

  final List<CartProductItem>? items;
  final ValueChanged<List<CartProductItem>>? onChanged;
  final VoidCallback? onShopNow;
  final Function(String)? onDeleteItem;
  final Function(List<String>)? onDeleteMultiple;
  final String emptyMessage;

  @override
  State<WishlistListWidget> createState() => _WishlistListWidgetState();
}

class _WishlistListWidgetState extends State<WishlistListWidget> {
  late List<CartProductItem> _items;

  @override
  void initState() {
    super.initState();
    _items = List<CartProductItem>.of(widget.items ?? const []);
  }

  @override
  void didUpdateWidget(covariant WishlistListWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.items != oldWidget.items) {
      _items = List<CartProductItem>.of(widget.items ?? const []);
      setState(() {});
    }
  }

  void _notifyParent() =>
      widget.onChanged?.call(List<CartProductItem>.of(_items));

  void _toggleSelected(String id) {
    final idx = _items.indexWhere((e) => e.id == id);
    if (idx < 0) return;
    setState(() {
      _items[idx] = _items[idx].copyWith(isSelected: !_items[idx].isSelected);
    });
    _notifyParent();
  }

  void _removeItem(String id) {
    setState(() {
      _items.removeWhere((e) => e.id == id);
    });
    // Call the delete API callback
    widget.onDeleteItem?.call(id);
    _notifyParent();
  }

  void _clearSelected() {
    final selectedIds = _items
        .where((e) => e.isSelected)
        .map((e) => e.id)
        .toList();

    setState(() {
      _items.removeWhere((e) => selectedIds.contains(e.id));
    });

    // Call the delete multiple API callback
    widget.onDeleteMultiple?.call(selectedIds);
    _notifyParent();
  }

  @override
  Widget build(BuildContext context) {
    if (_items.isEmpty) {
      return EmptyStateWidget(
        emptyMessage:
            "Your wishlist is empty.\nWhen you add products, they'll\nappear here.",
        icon: Icons.favorite_border,
        buttonText: "Shop Now",
        onButtonPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyHomePage()),
          );
        },
      );
    }

    final anySelected = _items.any((e) => e.isSelected);
    final allSelected = _items.isNotEmpty && _items.every((e) => e.isSelected);

    void selectAll(bool selected) {
      setState(() {
        for (int i = 0; i < _items.length; i++) {
          _items[i] = _items[i].copyWith(isSelected: selected);
        }
      });
      _notifyParent();
    }

    return Column(
      children: [
        Container(
          color: AppColors.backgroundWhite,
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => selectAll(!allSelected),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 140),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    gradient: allSelected
                        ? AppColors.bgGradient
                        : null, // ✅ gradient bg
                    color: allSelected
                        ? null
                        : AppColors.backgroundWhite, // normal white
                    border: allSelected
                        ? null // gradient se border alag na karna ho to null
                        : Border.all(
                            color: AppColors.borderGreyLighter,
                            width: 2,
                          ),
                  ),
                  child: allSelected
                      ? const Icon(
                          Icons.check,
                          color: Colors
                              .white, // gradient background pe white icon achha dikhega
                          size: 16,
                        )
                      : const SizedBox.shrink(),
                ),
              ),

              const SizedBox(width: 8),
              const Text(
                'Select all items',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textBlack87,
                ),
              ),
              const Spacer(),

              Center(
                child: IconButton(
                  onPressed: anySelected
                      ? () {
                          showDialog(
                            context: context,
                            builder: (dialogContext) {
                              return DeleteConfirmationDialog(
                                title: 'Clear Selected Items', // Pass heading
                                content:
                                    'Are you sure you want to clear the selected items?', // Pass content
                                onConfirm: () {
                                  Navigator.of(dialogContext).pop();
                                  _clearSelected();
                                },
                              );
                            },
                          );
                        }
                      : null,

                  icon: anySelected
                      ? ShaderMask(
                          shaderCallback: (bounds) =>
                              AppColors.bgGradient.createShader(bounds),
                          child: const Icon(
                            Icons.delete,
                            size: 34,
                            color: Colors.white, // gradient ke liye white color
                          ),
                        )
                      : Icon(
                          Icons.delete,
                          size: 34,
                          color: AppColors.textGreyLabel,
                        ),

                  style: IconButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(10, 22, 10, 22),
            itemCount: _items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final item = _items[index];
              return _WishlistRowCard(
                item: item,
                isSelected: item.isSelected,
                onToggleSelected: () => _toggleSelected(item.id),
                onRemove: () => _removeItem(item.id),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _WishlistRowCard extends StatelessWidget {
  const _WishlistRowCard({
    required this.item,
    required this.isSelected,
    required this.onToggleSelected,
    required this.onRemove,
  });

  final CartProductItem item;
  final bool isSelected;
  final VoidCallback onToggleSelected;
  final VoidCallback onRemove;

  static const Color _lightGrey = AppColors.backgroundGreyLighter;
  static const Color _textGrey = AppColors.color9AA0A6;
  static const Color _iconGrey = AppColors.textGreyIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.secondaryBGGradientColor,
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => onToggleSelected(),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 140),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                gradient: isSelected
                    ? AppColors.bgGradient
                    : null, // ✅ gradient bg
                color: isSelected
                    ? null
                    : AppColors.backgroundWhite, // normal white
                border: isSelected
                    ? null // gradient se border alag na karna ho to null
                    : Border.all(color: AppColors.borderGreyLighter, width: 2),
              ),
              child: isSelected
                  ? const Icon(
                      Icons.check,
                      color: Colors
                          .white, // gradient background pe white icon achha dikhega
                      size: 16,
                    )
                  : const SizedBox.shrink(),
            ),
          ),

          const SizedBox(width: 8),

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 75,
              height: 75,
              color: _lightGrey,
              child: _buildImage(),
            ),
          ),

          const SizedBox(width: 8),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textBlack87,
                          ),
                        ),
                      ),
                      const SizedBox(width: 9),
                      InkWell(
                        onTap: onRemove,
                        borderRadius: BorderRadius.circular(10),
                        child: const Padding(
                          padding: EdgeInsets.all(6),
                          child: Icon(
                            Icons.delete_outline,
                            color: _iconGrey,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      if (item.ramStorageText!.isNotEmpty)
                        ShowVariantSpecsWidget(
                          variantText: item.ramStorageText!,
                        ),

                      if (item.ramStorageText!.isNotEmpty &&
                          item.color!.isNotEmpty)
                        const SizedBox(width: 6),

                      if (item.color!.isNotEmpty)
                        ShowVariantSpecsWidget(variantText: item.color!),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.priceText,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: AppColors.textBlack87,
                          ),
                        ),
                      ),
                      // Replace qty control with cart + icon
                      InkWell(
                        onTap: onRemove,
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          width: 36,
                          height: 36,
                          child: const Icon(
                            Icons.add_shopping_cart,
                            size: 20,
                            color: AppColors.textBlack,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    if (item.imageProvider != null) {
      return Image(
        image: item.imageProvider!,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.high,
      );
    }
    if (item.imageUrl != null && item.imageUrl!.isNotEmpty) {
      return Image.network(
        item.imageUrl!,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.high,
      );
    }
    return const Center(child: Icon(Icons.image_outlined, color: _iconGrey));
  }
}
