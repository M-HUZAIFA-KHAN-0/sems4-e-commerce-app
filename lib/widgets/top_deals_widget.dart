import 'package:first/core/app_imports.dart';

class TopDealsWidget extends StatefulWidget {
  /// Tabs / filters / navigation items
  /// Dynamic is liye taake null ya galat data aaye to crash na ho
  final List<dynamic> items;

  /// Default selected item (optional & safe)
  final String? initialSelected;

  /// Optional callback (parent se aayega)
  /// Parent na bheje to koi issue nahi
  final Function(String value)? onItemTap;

  final String title;

  const TopDealsWidget({
    super.key,
    required this.items,
    this.initialSelected,
    this.onItemTap,
    required this.title,
  });

  @override
  State<TopDealsWidget> createState() => _TopDealsWidgetState();
}

class _TopDealsWidgetState extends State<TopDealsWidget> {
  /// Always initialized — no late, no crash
  String selectedItem = '';

  @override
  void initState() {
    super.initState();

    final List<String> safeItems = widget.items.whereType<String>().toList();

    if (safeItems.isEmpty) return;

    if (widget.initialSelected != null &&
        safeItems.contains(widget.initialSelected)) {
      selectedItem = widget.initialSelected!;
    } else {
      selectedItem = safeItems.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> safeItems = widget.items.whereType<String>().toList();

    // Agar items hi nahi hain
    if (safeItems.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: safeItems.map((item) {
              final bool isSelected = selectedItem == item;

              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: DealFilterChip(
                  label: item,
                  isSelected: isSelected,
                  onTap: () {
                    setState(() {
                      selectedItem = item;
                    });

                    // Parent ka function (agar ho)
                    widget.onItemTap?.call(item);
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

/// Single chip UI (DESIGN SAME – untouched)
class DealFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const DealFilterChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : AppColors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? Colors.black : Colors.grey),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColors.backgroundWhite : AppColors.textBlack,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
