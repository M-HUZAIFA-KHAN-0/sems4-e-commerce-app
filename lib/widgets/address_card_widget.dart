import 'package:first/core/app_imports.dart';

class AddressCardWidget extends StatelessWidget {
  final String? label;
  final String address;
  final String? tag;
  final Color? backgroundColor;
  final Color borderColor;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const AddressCardWidget({
    super.key,
    this.label,
    required this.address,
    this.tag,
    this.backgroundColor,
    this.borderColor = AppColors.borderGreyLight,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(12),
          color: backgroundColor ?? AppColors.backgroundGrey,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (label != null)
                    Text(
                      label!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  if (label != null) const SizedBox(height: 4),
                  Text(
                    address,
                    style: const TextStyle(fontSize: 13),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (tag != null && tag!.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.statusBlueLight,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        tag!,
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.primaryBlue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (onEdit != null || onDelete != null) ...[
              const SizedBox(width: 8),
              Column(
                children: [
                  if (onEdit != null)
                    GestureDetector(
                      onTap: onEdit,
                      child: const Icon(Icons.edit, size: 18),
                    ),
                  if (onDelete != null)
                    GestureDetector(
                      onTap: onDelete,
                      child: const Icon(
                        Icons.delete,
                        size: 18,
                        color: AppColors.accentRed,
                      ),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
