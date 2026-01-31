import 'package:first/core/app_imports.dart';
// import 'package:first/models/cart_product_model.dart';

/// Cart list widget - displays cart items

class CartListWidget extends StatefulWidget {
  const CartListWidget({super.key, this.items, this.onChanged, this.onShopNow});

  final List<CartProductItem>? items;
  final ValueChanged<List<CartProductItem>>? onChanged;
  final VoidCallback? onShopNow;

  @override
  State<CartListWidget> createState() => _CartListWidgetState();
}

class _CartListWidgetState extends State<CartListWidget> {
  late List<CartProductItem> _items;

  // Per-item "stock not available" message
  final Map<String, String?> _stockMsgById = {};
  final Map<String, Timer?> _timers = {};

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

  void _notifyParent() =>
      widget.onChanged?.call(List<CartProductItem>.of(_items));

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
    final selectedIds = _items
        .where((e) => e.isSelected)
        .map((e) => e.id)
        .toSet();

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
      return EmptyStateWidget(
        emptyMessage:
            "Your bag is empty.\nWhen you add products, they'll\nappear here.",
        icon: Icons.shopping_bag_outlined,
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
        // Select all + Clear selected items
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

  static const Color _lightGrey = Color(0xFFF3F4F6);
  static const Color _textGrey = Color(0xFF9AA0A6);
  static const Color _iconGrey = Color(0xFFBDBDBD);

  @override
  Widget build(BuildContext context) {
    final maxQty = item.stock < 1 ? 1 : item.stock;

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
            onTap: onToggleSelected,
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
                            color: AppColors.textBlack87,
                          ),
                        ),
                      ),
                      const SizedBox(width: 9),
                      InkWell(
                        onTap: onDelete,
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

                  const SizedBox(height: 0),

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
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.textBlack87,
                                ),
                              ),
                              const TextSpan(
                                text: " × ",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textBlack87,
                                ),
                              ),
                              TextSpan(
                                text: "${item.quantity}",
                                style: const TextStyle(
                                  fontSize: 14,
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
                        onPlus:
                            onPlus, // still clickable: shows message when > stock
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

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _CircleIconButton(icon: Icons.remove, onTap: onMinus),
        const SizedBox(width: 4),
        Text(
          "$quantity",
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: AppColors.textBlack87,
          ),
        ),
        const SizedBox(width: 4),
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

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          // color: AppColors.backgroundWhite,
          gradient: AppColors.bgGradient,
          border: Border.all(color: _borderGrey, width: 1.6),
        ),
        child: Icon(icon, size: 18, color: AppColors.backgroundWhite),
      ),
    );
  }
}
