import 'package:first/core/app_imports.dart';

class BGColorProdDisplayCard extends StatelessWidget {
  final List<Map<String, dynamic>> prodItems;
  final String? heading;

  const BGColorProdDisplayCard({
    super.key,
    required this.prodItems,
    this.heading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(12, 24, 12, 24),
      decoration: BoxDecoration(
        // gradient: AppColors.bgGradient, // Use your AppColors.bgGradient
        gradient: AppColors.bgSecondaryGradient,
        borderRadius: BorderRadius.circular(2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading with gradient text
          if (heading != null && heading!.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  heading!,
                  style: const TextStyle(
                    fontSize: FontSize.homePageTitle,
                    fontWeight: FontWeight.bold,
                    color: AppColors.bgGradientHeading,
                  ),
                ),
              ],
            ),

          const SizedBox(height: 18),

          // Product display
          ProductDisplayWidget(prodItems: prodItems, glassEffect: true),
        ],
      ),
    );
  }
}
