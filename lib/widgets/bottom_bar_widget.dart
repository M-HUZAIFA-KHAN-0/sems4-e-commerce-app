import 'package:flutter/material.dart';

class BottomBarWidget extends StatefulWidget {
  final int currentIndex;
  final Function(int) onIndexChanged;

  const BottomBarWidget({
    required this.currentIndex,
    required this.onIndexChanged,
  });

  @override
  State<BottomBarWidget> createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  final List<BottomBarItem> items = [
    BottomBarItem(icon: Icons.home_outlined, label: 'Home'),
    // BottomBarItem(icon: Icons.search_outlined, label: 'Shop'),
    BottomBarItem(icon: Icons.notifications_none, label: 'notifications'),
    BottomBarItem(icon: Icons.favorite_outline, label: 'Favourites'),
    BottomBarItem(icon: Icons.shopping_bag_outlined, label: 'Bag'),
    BottomBarItem(icon: Icons.person_outline, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: widget.onIndexChanged,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 0,
        items: items.asMap().entries.map((entry) {
          int index = entry.key;
          BottomBarItem item = entry.value;
          bool isActive = widget.currentIndex == index;

          return BottomNavigationBarItem(
            icon: Icon(
              item.icon,
              color: isActive ? Colors.black : Colors.grey,
              size: 24,
            ),
            label: item.label,
            activeIcon: Icon(item.icon, color: Colors.black, size: 24),
          );
        }).toList(),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

class BottomBarItem {
  final IconData icon;
  final String label;

  BottomBarItem({required this.icon, required this.label});
}
