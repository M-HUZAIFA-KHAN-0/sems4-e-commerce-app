import 'package:first/core/app_imports.dart';
import 'package:first/screens/logout_drawer.dart';
import 'package:first/services/api/auth_service.dart';

class CategoriesDrawerWidget extends StatelessWidget {
  final List<CategoryModel> categories;
  final Function(int categoryId)? onCategoryTap;

  const CategoriesDrawerWidget({
    super.key,
    required this.categories,
    this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    void handleLogout() {
      final authService = AuthService();
      authService.logout();

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const MyHomePage()),
        (route) => false,
      );
    }

    final List<MenuItemData> topMenuItems = [
      MenuItemData(
        label: 'My Account',
        icon: Icons.person,
        page: const ProfilePage(),
      ),
      MenuItemData(
        label: 'My Orders',
        icon: Icons.location_on,
        page: AppConstant.isloggedIn ? OrderHistoryPage() : LoginPage(),
      ),
      MenuItemData(
        label: 'Notifications',
        icon: Icons.notifications,
        page: const NotificationPage(),
      ),
      MenuItemData(
        label: 'Wishlist',
        icon: Icons.favorite,
        page: const WishlistPage(),
      ),
      MenuItemData(
        label: 'Cart',
        icon: Icons.shopping_cart,
        page: const CartPageExample(),
      ),
    ];

    final List<MenuItemData> bottomMenuItems = [
      // MenuItemData(label: 'About'),
      MenuItemData(
        label: 'Return & Refund',
        icon: Icons.repeat_rounded,
        page: AppConstant.isloggedIn ? ReturnRefundPage() : LoginPage(),
      ),
      MenuItemData(
        label: 'FAQs',
        icon: Icons.help_outline,
        page: const FAQsPage(),
      ),
      MenuItemData(
        label: 'Launch a Complaint',
        icon: Icons.assignment,
        page: const AddComplaintsFormPage(),
      ),
      MenuItemData(
        label: 'Contact',
        icon: Icons.phone_outlined,
        page: const ContactUsPage(),
      ),
      MenuItemData(
        label: AppConstant.isloggedIn ? 'Logout' : 'Login',
        icon: AppConstant.isloggedIn ? Icons.logout : Icons.login,
        page: AppConstant.isloggedIn
            ? LogoutDrawer(onLogout: handleLogout)
            : LoginPage(),
      ),
    ];

    final List<PopularListItem> popularLists = [
      PopularListItem(label: 'Best Mobiles Under 10000'),
      PopularListItem(label: 'Best Mobiles Under 15000'),
      PopularListItem(label: 'Best Mobiles Under 20000'),
      PopularListItem(label: 'Best Mobiles Under 30000'),
      PopularListItem(label: 'Best Mobiles Under 40000'),
      PopularListItem(label: 'Best Mobiles Under 50000'),
    ];

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
                color: AppColors.backgroundWhite,
                // decoration: BoxDecoration(
                // gradient: AppColors.bgGradient,
                // ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 16,
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 48),
                    Expanded(
                      child: Center(
                        child: SizedBox(
                          height: 50, // header ke hisaab se perfect
                          child: Image.asset(
                            '../../assets/branding/png-nav-logo.png', // apni image path
                            fit: BoxFit.contain, // ❗ no stretch
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      iconSize: 28,
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
                      _blueMenu(topMenuItems, context),

                      // CATEGORIES
                      _section(
                        title: 'CATEGORIES',
                        child: categories.isEmpty
                            ? const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text('No categories available'),
                              )
                            : Column(
                                children: categories
                                    .map(
                                      (c) =>
                                          CategoryModelItemWidget(category: c),
                                    )
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
                      _blueMenu(bottomMenuItems, context),
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

  Widget _blueMenu(List<MenuItemData> items, BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.bgGradient),
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
  final Widget? page;
  MenuItemData({required this.label, this.icon, this.page});
}

class CategoryItem {
  final String label;
  final IconData? icon;
  CategoryItem({required this.label, this.icon});
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
      onTap: () {
        Navigator.pop(context);
        if (item.page != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => item.page!),
          );
        } else {
          onTap();
        }
      },
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

class CategoryModelItemWidget extends StatelessWidget {
  final CategoryModel category;

  const CategoryModelItemWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        // Optional: Navigate to category products or filter
        print(
          '🏷️ Category tapped: ${category.categoryName} (ID: ${category.categoryId})',
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            const Icon(Icons.category, size: 24, color: Colors.black54),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                category.categoryName ?? 'Unknown',
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
