import 'package:flutter/material.dart';

class TopDealsWidget extends StatefulWidget {
  const TopDealsWidget({super.key});

  @override
  State<TopDealsWidget> createState() => _TopDealsWidgetState();
}

class _TopDealsWidgetState extends State<TopDealsWidget> {
  String selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'top Brands',    
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // Text('See All', style: TextStyle(color: Colors.blue, fontSize: 12)),
          ],
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              FilterChip(
                label: 'All',
                isSelected: selectedFilter == 'All',
                onTap: () {
                  setState(() {
                    selectedFilter = 'All';
                  });
                },
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: 'Mercedes',
                isSelected: selectedFilter == 'Mercedes',
                onTap: () {
                  setState(() {
                    selectedFilter = 'Mercedes';
                  });
                },
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: 'Tesla',
                isSelected: selectedFilter == 'Tesla',
                onTap: () {
                  setState(() {
                    selectedFilter = 'Tesla';
                  });
                },
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: 'BMW',
                isSelected: selectedFilter == 'BMW',
                onTap: () {
                  setState(() {
                    selectedFilter = 'BMW';
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Individual Filter Chip widget
class FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterChip({super.key, 
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
          color: isSelected ? Colors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? Colors.black : Colors.grey),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
