import 'package:first/core/app_imports.dart';

class CategoriesDisplayWidget extends StatelessWidget {
  const CategoriesDisplayWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
        spacing: 6,
        runSpacing: 10,
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
    // 👇 Image URLs map (icons ki jagah)
    final images = {
      'Mercedes': 'https://picsum.photos/200?1',
      'Tesla': 'https://picsum.photos/200?2',
      'BMW': 'https://picsum.photos/200?3',
      'Toyota': 'https://picsum.photos/200?4',
      'Volvo': 'https://picsum.photos/200?5',
      'Bugatti': 'https://picsum.photos/200?6',
      'Honda': 'https://picsum.photos/200?7',
      'More': 'https://picsum.photos/200?8',
    };

    return SizedBox(
      width: 65,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CategoryViewPage(),
                ),
              );
            },
            child: SizedBox(
              width: 54,
              height: 54,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8), // 👈 same radius
                child: Image.network(
                  images[brand] ?? 'https://picsum.photos/200',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            brand,
            style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

