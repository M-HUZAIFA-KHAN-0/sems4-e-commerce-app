// address_item.dart
import 'package:flutter/material.dart';

class AddressItem extends StatelessWidget {
  final String label;
  final String tag;
  final String address;
  final String? phoneNumber;
  final IconData icon;
  final VoidCallback? onEdit;

  const AddressItem({
    super.key,
    required this.label,
    this.tag = '',
    required this.address,
    this.phoneNumber,
    this.icon = Icons.location_on,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 28,
        backgroundColor: Colors.grey[200],
        child: Icon(icon, color: Colors.black, size: 34),
      ),
      title: Row(
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          if (tag.isNotEmpty) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(tag, style: const TextStyle(fontSize: 10)),
            ),
          ],
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (phoneNumber != null && phoneNumber!.isNotEmpty) ...[
            Text(
              phoneNumber!,
              style: const TextStyle(
                color: Color.fromARGB(255, 109, 109, 109),
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
          ],
          Text(
            address,
            style: const TextStyle(
              color: Color.fromARGB(255, 109, 109, 109),
              fontSize: 13,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      trailing: IconButton(
        icon: const Icon(Icons.chevron_right),
        onPressed: onEdit,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
}
