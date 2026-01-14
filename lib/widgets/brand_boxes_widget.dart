import 'package:flutter/material.dart';

class BrandBoxesWidget extends StatelessWidget {
  const BrandBoxesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Brand list
    final List<String> brands = [
      'Mercedes',
      'Tesla',
      'BMW',
      'Toyota',
      'Volvo',
      'Bugatti',
      'Honda',
      'More',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Wrap(
        spacing: 6, // horizontal gap between items
        runSpacing: 10, // vertical gap between rows
        children: brands.map((brand) => BrandIcon(brand: brand)).toList(),
      ),
    );
  }
}

/// Individual Brand Icon widget
class BrandIcon extends StatelessWidget {
  final String brand;

  const BrandIcon({required this.brand, super.key});

  @override
  Widget build(BuildContext context) {
    final icons = {
      'Mercedes': Icons.star,
      'Tesla': Icons.flash_on,
      'BMW': Icons.settings,
      'Toyota': Icons.directions_car,
      'Volvo': Icons.build,
      'Bugatti': Icons.speed,
      'Honda': Icons.nature,
      'More': Icons.more_horiz,
    };

    return SizedBox(
      width: 60, // fixed width for each box
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icons[brand] ?? Icons.directions_car,
              color: Colors.black54,
              size: 30,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            brand,
            style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
