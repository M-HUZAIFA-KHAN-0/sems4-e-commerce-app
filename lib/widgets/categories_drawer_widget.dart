import 'package:first/core/app_imports.dart';

class CategoriesDrawer extends StatefulWidget {
  const CategoriesDrawer({super.key});

  @override
  State<CategoriesDrawer> createState() => _CategoriesDrawerState();
}

class _CategoriesDrawerState extends State<CategoriesDrawer> {
  final List<MenuItemData> topMenuItems = [
    MenuItemData(label: 'My Account', icon: Icons.person),
    MenuItemData(label: 'Track my Order', icon: Icons.location_on),
    MenuItemData(label: 'Launch a Complaint', icon: Icons.assignment),
    MenuItemData(label: 'Notifications', icon: Icons.notifications),
    MenuItemData(label: 'Logout', icon: Icons.logout),
  ];

  final List<MenuItemData> bottomMenuItems = [
    MenuItemData(label: 'About'),
    MenuItemData(label: 'FAQs'),
    MenuItemData(label: 'Contact'),
    MenuItemData(label: 'Privacy Policy'),
  ];

  final List<CategoryItem> categories = [
    CategoryItem(label: 'Mobiles', icon: Icons.phone_android),
    CategoryItem(label: 'Smart Watches', icon: Icons.watch),
    CategoryItem(label: 'Wireless Earbuds', icon: Icons.headset),
    CategoryItem(label: 'Air Purifiers', icon: Icons.air),
    CategoryItem(label: 'Personal Cares', icon: Icons.health_and_safety),
    CategoryItem(label: 'Mobile Accessories', icon: Icons.cable),
    CategoryItem(label: 'Bluetooth Speakers', icon: Icons.speaker),
    CategoryItem(label: 'Power Banks', icon: Icons.power_input),
    CategoryItem(label: 'Tablets', icon: Icons.tablet),
    CategoryItem(label: 'Laptops', icon: Icons.laptop),
  ];

  final List<PopularListItem> popularLists = [
    PopularListItem(label: 'Best Mobiles Under 10000'),
    PopularListItem(label: 'Best Mobiles Under 15000'),
    PopularListItem(label: 'Best Mobiles Under 20000'),
    PopularListItem(label: 'Best Mobiles Under 30000'),
    PopularListItem(label: 'Best Mobiles Under 40000'),
    PopularListItem(label: 'Best Mobiles Under 50000'),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.transparent,
      elevation: 0,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(1),
          bottomLeft: Radius.circular(1),
        ),
        child: Container(
          color: AppColors.backgroundWhite,
          child: Column(
            children: [
              // HEADER
              Container(
                color: AppColors.primaryBlue,
                padding: const EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 16,
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 48),
                    const Expanded(
                      child: Text(
                        'Priceøye',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.backgroundWhite,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: AppColors.backgroundWhite,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),

              // BODY
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      // TOP MENU
                      _blueMenu(topMenuItems),

                      // CATEGORIES
                      _section(
                        title: 'CATEGORIES',
                        child: Column(
                          children: categories
                              .map((c) => CategoryItemWidget(category: c))
                              .toList(),
                        ),
                      ),

                      const Divider(),

                      // POPULAR LISTS
                      _section(
                        title: 'POPULAR LISTS',
                        child: Column(
                          children: popularLists
                              .map((p) => PopularListItemWidget(item: p))
                              .toList(),
                        ),
                      ),

                      const Divider(),

                      // BOTTOM MENU
                      _blueMenu(bottomMenuItems),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _blueMenu(List<MenuItemData> items) {
    return Container(
      color: AppColors.primaryBlue,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      child: Column(
        children: items
            .map(
              (item) => MenuItemWidget(
                item: item,
                onTap: () => Navigator.pop(context),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _section({required String title, required Widget child}) {
    return Padding(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textGreyLight,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

/* ================= DATA ================= */

class MenuItemData {
  final String label;
  final IconData? icon;
  MenuItemData({required this.label, this.icon});
}

class CategoryItem {
  final String label;
  final IconData icon;
  CategoryItem({required this.label, required this.icon});
}

class PopularListItem {
  final String label;
  PopularListItem({required this.label});
}

/* ================= WIDGETS ================= */

class MenuItemWidget extends StatelessWidget {
  final MenuItemData item;
  final VoidCallback onTap;

  const MenuItemWidget({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            if (item.icon != null)
              Icon(item.icon, size: 24, color: AppColors.backgroundWhite),
            if (item.icon != null) const SizedBox(width: 16),
            Text(
              item.label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.backgroundWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryItemWidget extends StatelessWidget {
  final CategoryItem category;

  const CategoryItemWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(category.icon, size: 24, color: Colors.black54),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                category.label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textBlack87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PopularListItemWidget extends StatelessWidget {
  final PopularListItem item;

  const PopularListItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () => Navigator.pop(context),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE0E0E0)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  item.label,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textGreyMedium,
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right,
                size: 20,
                color: AppColors.textGreyLightest,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
