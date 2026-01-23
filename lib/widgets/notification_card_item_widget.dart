import 'package:first/core/app_imports.dart';

class NotificationCardItemWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String date;
  final String? subtitle;
  final bool showButton;
  final VoidCallback? onButtonPressed;

  const NotificationCardItemWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.date,
    this.subtitle,
    this.showButton = false,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        // color: AppColors.backgroundWhite,
        gradient: AppColors.secondaryBGGradientColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              // color: AppColors.textBlack,
              gradient: AppColors.bgGradient,
              borderRadius: BorderRadius.circular(26),
            ),
            child: Icon(icon, color: AppColors.backgroundWhite, size: 28),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textBlack87,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textGreyLabel,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    subtitle!,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
                if (showButton) ...[
                  const SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: onButtonPressed ?? () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: AppColors.textBlack,
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                    ),
                    child: const Text(
                      'View Details',
                      style: TextStyle(
                        color: AppColors.textBlack,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
