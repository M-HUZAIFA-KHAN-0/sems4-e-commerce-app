// address_item.dart
import 'package:first/core/app_imports.dart';

class AddressItem extends StatelessWidget {
  final String label;
  final String tag;
  final String address;
  final IconData icon;
  final VoidCallback? onEdit;

  const AddressItem({
    super.key,
    required this.label,
    this.tag = '',
    required this.address,
    this.icon = Icons.location_on,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 28,
        backgroundColor: Colors.grey[200],
        child: Icon(icon, color: AppColors.textBlack, size: 34),
      ),
      title: Row(
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          if (tag.isNotEmpty) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.backgroundGreyLight,
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
