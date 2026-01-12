import 'package:flutter/material.dart';

class SpecificationHighlights extends StatelessWidget {
  final List<Map<String, dynamic>> tags;

  const SpecificationHighlights({super.key, required this.tags});

  Widget _buildTag(BuildContext context, Map<String, dynamic> t) {
    final icon = t['icon'];
    final title = t['title'] ?? '';
    final desc = t['description'] ?? '';

    Widget leading;
    if (icon is IconData) {
      leading = CircleAvatar(
        radius: 22,
        backgroundColor: Colors.blue[50],
        child: Icon(icon, color: Colors.blue[600], size: 29),
      );
    } else if (icon is String) {
      leading = Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(4),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.asset(icon, fit: BoxFit.cover),
        ),
      );
    } else {
      leading = CircleAvatar(
        radius: 22,
        backgroundColor: Colors.blue[50],
        child: Icon(Icons.info_outline, color: Colors.blue[600], size: 22),
      );
    }

    return SizedBox(
      width: 160,
      child: Row(
        children: [
          leading,
          const SizedBox(width: 12),
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
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
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
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceEvenly,      // 👈 horizontal center / evenly
        runAlignment: WrapAlignment.center,        // 👈 vertical center
        spacing: 12,
        runSpacing: 12,
        children: tags.map((t) => _buildTag(context, t)).toList(),
      ),
    );
  }
}
