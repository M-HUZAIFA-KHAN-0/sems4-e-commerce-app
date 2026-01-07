import 'dart:async';
import 'package:first/main-home.dart';
import 'package:flutter/material.dart';

class CartProductItem {
  const CartProductItem({
    required this.id,
    required this.title,
    required this.variantText,
    required this.priceText,
    required this.quantity,
    required this.stock,
    this.imageProvider,
    this.imageUrl,
    this.isSelected = true,
  });

  final String id;
  final String title;
  final String variantText;
  final String priceText;

  /// Initial quantity from parent
  final int quantity;

  /// Max quantity allowed from parent
  final int stock;

  /// Provide either imageProvider or imageUrl
  final ImageProvider? imageProvider;
  final String? imageUrl;

  /// Used by "Clear selected items"
  final bool isSelected;

  CartProductItem copyWith({
    String? id,
    String? title,
    String? variantText,
    String? priceText,
    int? quantity,
    int? stock,
    ImageProvider? imageProvider,
    String? imageUrl,
    bool? isSelected,
  }) {
    return CartProductItem(
      id: id ?? this.id,
      title: title ?? this.title,
      variantText: variantText ?? this.variantText,
      priceText: priceText ?? this.priceText,
      quantity: quantity ?? this.quantity,
      stock: stock ?? this.stock,
      imageProvider: imageProvider ?? this.imageProvider,
      imageUrl: imageUrl ?? this.imageUrl,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

/// Reusable cart widget
/// - Accepts items from parent (multiple product cards)
/// - If no items, shows centered empty message
/// - Handles internal state: selection, qty changes, item removal, clear selected
/// - Notifies parent on every change via onChanged
class CartListWidget extends StatefulWidget {
  const CartListWidget({
    super.key,
    this.items,
    this.onChanged,
    this.onShopNow,
    // this.emptyMessage = "Your cart is empty",
    this.emptyMessage = "Your bag is empty.\nWhen you add products, they'll\nappear here."
  });

  final List<CartProductItem>? items;
  final ValueChanged<List<CartProductItem>>? onChanged;
  final VoidCallback? onShopNow;
  final String emptyMessage;

  @override
  State<CartListWidget> createState() => _CartListWidgetState();
}

class _CartListWidgetState extends State<CartListWidget> {
  late List<CartProductItem> _items;

  // Per-item "stock not available" message
  final Map<String, String?> _stockMsgById = {};
  final Map<String, Timer?> _timers = {};

  static const Color _green = Color(0xFF55C59A);
  static const Color _lightGrey = Color(0xFFF3F4F6);
  static const Color _textGrey = Color(0xFF9AA0A6);
  static const Color _iconGrey = Color(0xFFBDBDBD);

  @override
  void initState() {
    super.initState();
    _items = List<CartProductItem>.of(widget.items ?? const []);
  }

  @override
  void didUpdateWidget(covariant CartListWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Sync if parent sends a new list instance
    if (widget.items != oldWidget.items) {
      _items = List<CartProductItem>.of(widget.items ?? const []);
      _stockMsgById.clear();
      for (final t in _timers.values) {
        t?.cancel();
      }
      _timers.clear();
      setState(() {});
    }
  }

  @override
  void dispose() {
    for (final t in _timers.values) {
      t?.cancel();
    }
    super.dispose();
  }

  void _notifyParent() => widget.onChanged?.call(List<CartProductItem>.of(_items));

  void _showStockMsg(String id, String msg) {
    _timers[id]?.cancel();
    _timers.remove(id);

    setState(() => _stockMsgById[id] = msg);

    _timers[id] = Timer(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() => _stockMsgById[id] = null);
    });
  }

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
      _stockMsgById.remove(id);
      _timers[id]?.cancel();
      _timers.remove(id);
    });
    _notifyParent();
  }

  void _clearSelected() {
    final selectedIds = _items.where((e) => e.isSelected).map((e) => e.id).toSet();

    setState(() {
      _items.removeWhere((e) => selectedIds.contains(e.id));
      for (final id in selectedIds) {
        _stockMsgById.remove(id);
        _timers[id]?.cancel();
        _timers.remove(id);
      }
    });
    _notifyParent();
  }

  void _minus(String id) {
    final idx = _items.indexWhere((e) => e.id == id);
    if (idx < 0) return;
    final item = _items[idx];

    if (item.quantity <= 1) return;

    setState(() {
      _items[idx] = item.copyWith(quantity: item.quantity - 1);
      _stockMsgById[id] = null;
    });
    _notifyParent();
  }

  void _plus(String id) {
    final idx = _items.indexWhere((e) => e.id == id);
    if (idx < 0) return;
    final item = _items[idx];

    final maxQty = item.stock < 1 ? 1 : item.stock;
    if (item.quantity >= maxQty) {
      _showStockMsg(id, "Stock not available");
      return;
    }

    setState(() {
      _items[idx] = item.copyWith(quantity: item.quantity + 1);
      _stockMsgById[id] = null;
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
        // Icon
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFF111111), width: 1.2),
          ),
          child: const Center(
            child: Icon(
              Icons.shopping_bag_outlined,
              size: 20,
              color: Color(0xFF111111),
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Message (same "structure" as your Text return)
        Text(
          widget.emptyMessage, // e.g. "Your bag is empty.\nWhen you add products, they'll\nappear here."
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            height: 1.35,
            color: Color(0xFF111111),
            fontWeight: FontWeight.w500,
          ),
        ),

        // ✅ fixed gap between content and button
        const SizedBox(height: 25),

        // Button
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            // onPressed: widget.onShopNow,
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyHomePage()),
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
              "Shop Now",
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

    return Column(
      children: [
        // Clear selected items
        Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: anySelected ? _clearSelected : null,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
              child: Text(
                "Clear selected items",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: anySelected ? Colors.black87 : _textGrey,
                ),
              ),
            ),
          ),
        ),

        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(10, 22, 10, 22),
            itemCount: _items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final item = _items[index];
              return _CartRowCard(
                item: item,
                isSelected: item.isSelected,
                stockMessage: _stockMsgById[item.id],
                onToggleSelected: () => _toggleSelected(item.id),
                onDelete: () => _removeItem(item.id),
                onMinus: () => _minus(item.id),
                onPlus: () => _plus(item.id),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _CartRowCard extends StatelessWidget {
  const _CartRowCard({
    required this.item,
    required this.isSelected,
    required this.stockMessage,
    required this.onToggleSelected,
    required this.onDelete,
    required this.onMinus,
    required this.onPlus,
  });

  final CartProductItem item;
  final bool isSelected;
  final String? stockMessage;

  final VoidCallback onToggleSelected;
  final VoidCallback onDelete;
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  static const Color _green = Color(0xFF55C59A);
  static const Color _lightGrey = Color(0xFFF3F4F6);
  static const Color _textGrey = Color(0xFF9AA0A6);
  static const Color _iconGrey = Color(0xFFBDBDBD);
  static const Color _borderGrey = Color(0xFFE7E9EE);

  @override
  Widget build(BuildContext context) {
    final maxQty = item.stock < 1 ? 1 : item.stock;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Select checkbox
          GestureDetector(
            onTap: onToggleSelected,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 140),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isSelected ? _green : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: isSelected ? _green : _borderGrey, width: 2),
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : const SizedBox.shrink(),
            ),
          ),

          const SizedBox(width: 8),

          // Product image
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

          // Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title row + BIN at end (as requested)
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
                        onTap: onDelete,
                        borderRadius: BorderRadius.circular(10),
                        child: const Padding(
                          padding: EdgeInsets.all(6),
                          child: Icon(Icons.delete_outline, color: _iconGrey, size: 24),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 0),

                  Text(
                    "Variant: ${item.variantText}",
                    style: const TextStyle(
                      fontSize: 12,
                      color: _textGrey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Row(
                    children: [
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: item.priceText,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black87,
                                ),
                              ),
                              const TextSpan(
                                text: " × ",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                ),
                              ),
                              TextSpan(
                                text: "${item.quantity}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromARGB(221, 134, 134, 134),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      _QtyControl(
                        quantity: item.quantity,
                        min: 1,
                        max: maxQty,
                        onMinus: item.quantity > 1 ? onMinus : null,
                        onPlus: onPlus, // still clickable: shows message when > stock
                      ),
                    ],
                  ),

                  AnimatedSize(
                    duration: const Duration(milliseconds: 180),
                    child: (stockMessage == null || stockMessage!.isEmpty)
                        ? const SizedBox.shrink()
                        : Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Text(
                              stockMessage!,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFD32F2F),
                              ),
                            ),
                          ),
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
      return Image(image: item.imageProvider!, fit: BoxFit.cover, filterQuality: FilterQuality.high);
    }
    if (item.imageUrl != null && item.imageUrl!.isNotEmpty) {
      return Image.network(item.imageUrl!, fit: BoxFit.cover, filterQuality: FilterQuality.high);
    }
    return const Center(child: Icon(Icons.image_outlined, color: _iconGrey));
  }
}

class _QtyControl extends StatelessWidget {
  const _QtyControl({
    required this.quantity,
    required this.min,
    required this.max,
    required this.onMinus,
    required this.onPlus,
  });

  final int quantity;
  final int min;
  final int max;
  final VoidCallback? onMinus;
  final VoidCallback onPlus;

  static const Color _borderGrey = Color(0xFFE7E9EE);
  static const Color _iconGrey = Color(0xFFBDBDBD);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _CircleIconButton(icon: Icons.remove, onTap: onMinus),
        const SizedBox(width: 8),
        Text(
          "$quantity",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.black87),
        ),
        const SizedBox(width: 8),
        _CircleIconButton(icon: Icons.add, onTap: onPlus),
      ],
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  static const Color _borderGrey = Color(0xFFE7E9EE);
  static const Color _iconGrey = Color(0xFFBDBDBD);

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: _borderGrey, width: 1.6),
        ),
        child: Icon(icon, size: 20, color: enabled ? _iconGrey : _borderGrey),
      ),
    );
  }
}
