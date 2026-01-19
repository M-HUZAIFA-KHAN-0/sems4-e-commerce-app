import 'package:flutter/material.dart';

class ShopCategoryCardData {
  const ShopCategoryCardData({
    required this.image,
    required this.title, // use "\n" for 2 lines exactly like SS
    this.onTap,
  });

  final ImageProvider image;
  final String title;
  final VoidCallback? onTap;
}

class ShopMoreCategoriesWidget extends StatelessWidget {
  const ShopMoreCategoriesWidget({
    super.key,
    required this.title,
    required this.items, // parent provides ALL content
    this.onTap,
  });

  final String title;
  final List<ShopCategoryCardData> items;
  final void Function(int index)? onTap;

  static const Color _panelBg = Color(0xFFF6D5FB); // light pink
  static const Color _purple = Color(0xFF8902A4);  // border + bottom bar

  @override
  Widget build(BuildContext context) {
    // Expecting 4 cards (2x2) like SS, but will still render if more/less.
    return Container(
      color: _panelBg,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            color: _panelBg,
            padding: const EdgeInsets.fromLTRB(26, 26, 26, 34),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 26,
                mainAxisSpacing: 26,
                childAspectRatio: 0.92, // matches SS card proportions
              ),
              itemBuilder: (context, index) {
                return _CategoryCard(
                  data: items[index],
                  purple: _purple,
                  onTap: onTap == null ? null : () => onTap!(index),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.data,
    required this.purple,
    this.onTap,
  });

  final ShopCategoryCardData data;
  final Color purple;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final card = Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: purple, width: 3.5),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.white,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(18),
                child: Image(
                  image: data.image,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
            Container(
              height: 40,
              width: double.infinity,
              color: purple,
              alignment: Alignment.center,
              child: Text(
                data.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  height: 1.15,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    if (onTap == null) return card;

    return GestureDetector(
      onTap: onTap,
      child: card,
    );
  }
}
