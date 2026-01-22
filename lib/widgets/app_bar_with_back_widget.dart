import 'package:first/core/app_imports.dart';

class AppBarWithBackWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final VoidCallback? onBackPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final TextStyle? titleStyle;

  const AppBarWithBackWidget({
    super.key,
    this.title,
    this.actions,
    this.onBackPressed,
    this.backgroundColor = AppColors.backgroundWhite,
    this.foregroundColor = AppColors.textBlack87,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      foregroundColor: foregroundColor,
      leading: GestureDetector(
        onTap: onBackPressed ?? () => Navigator.of(context).maybePop(),
        child: const Icon(Icons.arrow_back_ios, size: 20),
      ),
      title: title != null
          ? Text(
              title!,
              style: titleStyle ?? const TextStyle(fontWeight: FontWeight.w800),
            )
          : null,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
