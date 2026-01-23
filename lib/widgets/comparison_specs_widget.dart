import 'package:first/core/app_imports.dart';

class ComparisonSpecsWidget extends StatelessWidget {
  final Map<String, dynamic>? product1;
  final Map<String, dynamic>? product2;

  const ComparisonSpecsWidget({super.key, this.product1, this.product2});

  List<String> _getAllSpecKeys() {
    final keys = <String>{};
    if (product1 != null) {
      final specs = product1!['specs'] as Map<String, dynamic>?;
      if (specs != null) keys.addAll(specs.keys.cast<String>());
    }
    if (product2 != null) {
      final specs = product2!['specs'] as Map<String, dynamic>?;
      if (specs != null) keys.addAll(specs.keys.cast<String>());
    }
    return keys.toList();
  }

  // Group specs into sections with color mapping
  Map<String, List<String>> _groupSpecsBySection(List<String> allKeys) {
    const generalFeatures = [
      'Screen Size',
      'Weight',
      'Operating System',
      'Generation',
    ];
    const displayFeatures = ['Screen Size', 'Screen Resolution'];
    const memoryFeatures = ['Internal Memory', 'RAM', 'Graphics Memory'];
    const performanceFeatures = ['Processor Type', 'Processor Speed'];
    const otherFeatures = ['Backlit Keyboard'];

    final groups = <String, List<String>>{};

    // General Features
    final general = allKeys.where((k) => generalFeatures.contains(k)).toList();
    if (general.isNotEmpty) {
      groups['General Features'] = general;
    }

    // Display
    final display = allKeys.where((k) => displayFeatures.contains(k)).toList();
    if (display.isNotEmpty) {
      groups['Display'] = display;
    }

    // Memory
    final memory = allKeys.where((k) => memoryFeatures.contains(k)).toList();
    if (memory.isNotEmpty) {
      groups['Memory'] = memory;
    }

    // Performance
    final performance = allKeys
        .where((k) => performanceFeatures.contains(k))
        .toList();
    if (performance.isNotEmpty) {
      groups['Performance'] = performance;
    }

    // Other
    final other = allKeys.where((k) => otherFeatures.contains(k)).toList();
    if (other.isNotEmpty) {
      groups['Other'] = other;
    }

    return groups;
  }

  Color _getSectionColor(String section) {
    switch (section) {
      case 'Memory':
        return AppColors.primaryGreen;
      case 'Performance':
        return AppColors.primaryPurple;
      case 'Display':
        return AppColors.primaryCyan;
      case 'Other':
        return AppColors.primaryOrangeAlt;
      case 'General Features':
      default:
        return AppColors.primaryBlueDark;
    }
  }

  @override
  Widget build(BuildContext context) {
    final allKeys = _getAllSpecKeys();
    if (allKeys.isEmpty) {
      return Container(
        color: Colors.grey[50],
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: const Center(
          child: Text(
            'Select products to compare specs',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ),
      );
    }

    final groups = _groupSpecsBySection(allKeys);

    return Container(
      color: Colors.grey[50],
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final section in groups.entries) ...[
            // Section title (colored)
            Padding(
              padding: const EdgeInsets.only(bottom: 16, top: 12),
              child: Text(
                section.key,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: _getSectionColor(section.key),
                ),
              ),
            ),
            // Spec rows - new layout with centered spec name and left/right values
            for (final specKey in section.value) ...[
              Container(
                color: AppColors.backgroundWhite,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                margin: const EdgeInsets.only(bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Spec name (centered heading)
                    Text(
                      specKey,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: AppColors.textBlack87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Left and right values
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product 1 value (left)
                        Expanded(
                          child: Text(
                            product1 == null
                                ? '-'
                                : ((product1!['specs']
                                              as Map<
                                                String,
                                                dynamic
                                              >?)?[specKey] ??
                                          '-')
                                      .toString(),
                            textAlign: TextAlign.center,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textBlack87,
                              height: 1.5,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Product 2 value (right)
                        Expanded(
                          child: Text(
                            product2 == null
                                ? '-'
                                : ((product2!['specs']
                                              as Map<
                                                String,
                                                dynamic
                                              >?)?[specKey] ??
                                          '-')
                                      .toString(),
                            textAlign: TextAlign.center,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textBlack87,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}
