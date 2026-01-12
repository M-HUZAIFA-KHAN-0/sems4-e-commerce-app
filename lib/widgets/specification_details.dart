import 'package:flutter/material.dart';

class SpecificationDetails extends StatelessWidget {
  final List<Map<String, dynamic>> sections;

  const SpecificationDetails({super.key, required this.sections});

  Widget _buildRow(Map<String, String> row) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              row['key'] ?? '',
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              row['value'] ?? '',
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: sections.map((section) {
        final rows = List<Map<String, String>>.from(section['rows'] ?? []);
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                section['title'] ?? '',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Divider(height: 1),
              ...rows.map((r) => _buildRow(r)),
            ],
          ),
        );
      }).toList(),
    );
  }
}
