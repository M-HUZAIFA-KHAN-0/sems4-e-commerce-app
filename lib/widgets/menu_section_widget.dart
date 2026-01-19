import 'package:flutter/material.dart';

class MenuItemData {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final int badgeCount;

  MenuItemData({
    required this.icon,
    required this.label,
    required this.onTap,
    this.badgeCount = 0,
  });
}

class MenuSectionWidget extends StatelessWidget {
  const MenuSectionWidget({
    super.key,
    required this.title,
    required this.menuItems,
  });

  final String title;
  final List<MenuItemData> menuItems;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.fromLTRB(15, 17, 15, 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 0,
            crossAxisSpacing: 1,
            children: [for (final item in menuItems) _buildMenuItem(item)],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(MenuItemData item) {
    return GestureDetector(
      onTap: item.onTap,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // border: Border.all(color: Colors.black87, width: 2),
                ),
                child: Icon(item.icon, color: Colors.black87, size: 38),
              ),
              if (item.badgeCount > 0)
                Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF2196F3),
                  ),
                  child: Center(
                    child: Text(
                      '${item.badgeCount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          // const SizedBox(height: 2),
          Text(
            item.label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
