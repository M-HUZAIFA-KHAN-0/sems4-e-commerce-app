import 'package:first/core/app_imports.dart';

class SpecificationHighlights extends StatelessWidget {
  final List<Map<String, dynamic>> tags;

  const SpecificationHighlights({super.key, required this.tags});

  Widget _buildTag(BuildContext context, Map<String, dynamic> t) {
    final icon = t['icon'];
    final title = t['title'] ?? '';
    final desc = t['description'] ?? '';

    // ✅ Simplified: hamesha gradient background + white icon
    Widget leading = Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        gradient: AppColors.bgGradient,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: icon is IconData
            ? Icon(icon, color: AppColors.backgroundWhite, size: 30)
            : icon is String
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(icon, fit: BoxFit.cover),
                  )
                : const Icon(Icons.info_outline, color: AppColors.backgroundWhite, size: 26),
      ),
    );

    return SizedBox(
      width: 160,
      child: Row(
        children: [
          leading,
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  desc.toString(),
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textGreyDark.withOpacity(0.6),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        // color: AppColors.backgroundGrey,
        // gradient: AppColors.secondaryBGGradientColor,
        gradient: AppColors.bgLightGradientColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceEvenly,
        runAlignment: WrapAlignment.center,
        spacing: 12,
        runSpacing: 12,
        children: tags.map((t) => _buildTag(context, t)).toList(),
      ),
    );
  }
}
