import 'package:first/core/app_imports.dart';

class ProductStatsRow extends StatelessWidget {
  final int views;
  final int purchases;

  const ProductStatsRow({
    super.key,
    required this.views,
    required this.purchases,
  });

  String _formatCount(int n) {
    if (n >= 1000000) return "${(n / 1000000).toStringAsFixed(1)}M";
    if (n >= 1000) return "${(n / 1000).toStringAsFixed(1)}k";
    return n.toString();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
      fontSize: 11,
      color: AppColors.formGrey87,
      height: 1.2,
    );

    final iconColor = const Color.fromARGB(255, 77, 77, 77);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(Icons.remove_red_eye_outlined, size: 16, color: iconColor),
        const SizedBox(width: 4),
        Text("${_formatCount(views)} Views", style: textStyle),

        const SizedBox(width: 10),
        Text('|', style: TextStyle(fontSize: 16, color: AppColors.formGrey34)),
        const SizedBox(width: 10),

        Icon(Icons.shopping_bag_outlined, size: 16, color: iconColor),
        const SizedBox(width: 4),
        Text("${_formatCount(purchases)} Purchased", style: textStyle),
      ],
    );
  }
}
