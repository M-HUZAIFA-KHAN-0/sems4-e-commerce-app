import 'package:first/main-home.dart';
import 'package:first/screens/add_to_card_page.dart';
import 'package:first/screens/notification_page.dart';
import 'package:first/screens/profile_page.dart';
import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  int _selectedBottomIndex = 2; // Set to 2 for wishlist page

  // Parent controls initial data + stock values
  List<CartProductItem> wishlistItems = [
    CartProductItem(
      id: "1",
      title: "Air pods max by Apple",
      variantText: "Grey",
      priceText: "\$ 1999,99",
      quantity: 1,
      stock: 2,
      imageUrl: "https://picsum.photos/200?1",
      isSelected: true,
    ),
    CartProductItem(
      id: "2",
      title: "Monitor LG 22”inc 4K 120Fps",
      variantText: "120 Fps",
      priceText: "\$ 299,99",
      quantity: 1,
      stock: 5,
      imageUrl: "https://picsum.photos/200?2",
      isSelected: true,
    ),
    CartProductItem(
      id: "3",
      title: "Earphones for monitor",
      variantText: "Combo",
      priceText: "\$ 199,99",
      quantity: 1,
      stock: 1,
      imageUrl: "https://picsum.photos/200?3",
      isSelected: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // ✅ calculate ONLY selected items
    final selectedItems = wishlistItems.where((e) => e.isSelected).toList();
    final selectedCount = selectedItems.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        title: const Text("Wishlist"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: WishlistListWidget(
              items: wishlistItems,
              onChanged: (updatedItems) {
                setState(() {
                  wishlistItems = updatedItems;
                });
              },
              emptyMessage:
                  "Your wishlist is empty.\nWhen you add products, they'll\nappear here.",
            ),
          ),

          // Add-all button shown when more than one selected
          if (selectedCount > 1)
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),

              child: PrimaryBtnWidget(
                onPressed: () {
                  final selectedIds = wishlistItems
                      .where((e) => e.isSelected)
                      .map((e) => e.id)
                      .toSet();
                  setState(() {
                    wishlistItems.removeWhere(
                      (e) => selectedIds.contains(e.id),
                    );
                  });
                },
                buttonText: 'Add all items to cart',
              ),

              // child: SizedBox(
              //   width: double.infinity,
              //   height: 48,
              //   child: ElevatedButton(
              //     onPressed: () {
              //       final selectedIds = wishlistItems
              //           .where((e) => e.isSelected)
              //           .map((e) => e.id)
              //           .toSet();
              //       setState(() {
              //         wishlistItems.removeWhere(
              //           (e) => selectedIds.contains(e.id),
              //         );
              //       });
              //     },
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: Colors.black,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(26),
              //       ),
              //     ),
              //     child: const Text(
              //       'Add all items to cart',
              //       style: TextStyle(
              //         fontSize: 14,
              //         fontWeight: FontWeight.w800,
              //         color: Colors.white,
              //       ),
              //     ),
              //   ),
              // ),
            ),
        ],
      ),
      bottomNavigationBar: BottomBarWidget(
        isLoggedIn: false,
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
}

// Local wishlist list widget (keeps behavior local to this file)
class WishlistListWidget extends StatefulWidget {
  const WishlistListWidget({
    super.key,
    this.items,
    this.onChanged,
    this.onShopNow,
    this.emptyMessage =
        "Your wishlist is empty.\nWhen you add products, they'll\nappear here.",
  });

  final List<CartProductItem>? items;
  final ValueChanged<List<CartProductItem>>? onChanged;
  final VoidCallback? onShopNow;
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
    _notifyParent();
  }

  void _clearSelected() {
    final selectedIds = _items
        .where((e) => e.isSelected)
        .map((e) => e.id)
        .toSet();
    setState(() {
      _items.removeWhere((e) => selectedIds.contains(e.id));
    });
    _notifyParent();
  }

  @override
  Widget build(BuildContext context) {
    if (_items.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF111111),
                    width: 1.2,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.favorite_border,
                    size: 20,
                    color: Color(0xFF111111),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.emptyMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.35,
                  color: Color(0xFF111111),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyHomePage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Text(
                    'Shop Now',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
          color: Colors.white,
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
                    color: allSelected ? Colors.black : Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: allSelected
                          ? Colors.black
                          : const Color(0xFFE7E9EE),
                      width: 2,
                    ),
                  ),
                  child: allSelected
                      ? const Icon(Icons.check, color: Colors.white, size: 16)
                      : const SizedBox.shrink(),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Select all items',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),

              // InkWell(
              //   onTap: anySelected
              //       ? () {
              //           showDialog(
              //             context: context,
              //             builder: (dialogContext) {
              //               return DeleteConfirmationDialog(
              //                 title: 'Clear Selected Items',
              //                 content:
              //                     'Are you sure you want to clear the selected items?', // Pass content
              //                 onConfirm: () {
              //                   _clearSelected();
              //                 },
              //               );
              //             },
              //           );
              //         }
              //       : null,
              //   borderRadius: BorderRadius.circular(8),
              //   child: Container(
              //     padding: const EdgeInsets.symmetric(
              //       horizontal: 9,
              //       vertical: 4,
              //     ),
              //     decoration: BoxDecoration(
              //       color: const Color.fromARGB(255, 221, 221, 221),
              //       borderRadius: BorderRadius.circular(8),
              //     ),
              //     child: Text(
              //       'Clear selected items',
              //       style: TextStyle(
              //         fontSize: 12,
              //         fontWeight: FontWeight.w600,
              //         color: anySelected
              //             ? const Color.fromARGB(221, 238, 0, 0)
              //             : const Color(0xFF9AA0A6),
              //       ),
              //     ),
              //   ),
              // ),
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
                                  _clearSelected();
                                },
                              );
                            },
                          );
                        }
                      : null,
                  icon: Icon(
                    Icons.delete,
                    size: 34,
                    color: anySelected
                        ? const Color.fromARGB(255, 0, 0, 0)
                        : const Color(0xFF9AA0A6),
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

  static const Color _lightGrey = Color(0xFFF3F4F6);
  static const Color _textGrey = Color(0xFF9AA0A6);
  static const Color _iconGrey = Color(0xFFBDBDBD);
  static const Color _borderGrey = Color(0xFFE7E9EE);
  static const Color _green = Color(0xFF55C59A);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onToggleSelected,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 140),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color.fromARGB(255, 0, 0, 0)
                    : Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: isSelected
                      ? const Color.fromARGB(255, 0, 0, 0)
                      : _borderGrey,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
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
                            color: Colors.black87,
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
                  const SizedBox(height: 2),
                  Text(
                    'Variant: ${item.variantText}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: _textGrey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.priceText,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      // Replace qty control with cart + icon
                      InkWell(
                        onTap: onRemove,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: 36,
                          height: 36,
                          // decoration: BoxDecoration(
                          //   color: Colors.white,
                          //   borderRadius: BorderRadius.circular(8),
                          //   border: Border.all(color: _borderGrey, width: 1.2),
                          // ),
                          child: const Icon(
                            Icons.add_shopping_cart,
                            size: 20,
                            color: Colors.black,
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
    if (item.imageProvider != null)
      return Image(
        image: item.imageProvider!,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.high,
      );
    if (item.imageUrl != null && item.imageUrl!.isNotEmpty)
      return Image.network(
        item.imageUrl!,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.high,
      );
    return const Center(child: Icon(Icons.image_outlined, color: _iconGrey));
  }
}
