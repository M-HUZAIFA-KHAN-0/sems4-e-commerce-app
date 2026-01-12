import 'package:first/main-home.dart';
import 'package:first/screens/add_to_card_page.dart';
import 'package:first/screens/address_book_page.dart';
import 'package:first/screens/logout_drawer.dart';
import 'package:first/screens/notification_page.dart';
import 'package:first/screens/order_history_page.dart';
import 'package:first/screens/wishlist_page.dart';
import 'package:first/widgets/bottom_bar_widget.dart';
import 'package:flutter/material.dart';
import '../widgets/menu_section_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedBottomIndex = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Profile'),
      //   backgroundColor: Colors.white,
      //   foregroundColor: Colors.black87,
      //   elevation: 0,
      // ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header section with profile info
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [const Color(0xFF2196F3), Colors.blue.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
              child: Stack(
                children: [
                  // Settings icon in top right
                  Positioned(
                    top: -10,
                    right: -5,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(
                        Icons.settings,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                  // Profile info
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 3),
                            ),
                            child: const Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                      
                          const SizedBox(height: 10),
                      
                          const Text(
                            'Huzaifa Khan',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // My Orders section
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MenuSectionWidget(
                title: 'My orders',
                menuItems: [
                  MenuItemData(
                    icon: Icons.credit_card_outlined,
                    label: 'Pay',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const OrderHistoryPage()),
                      );
                    },
                  ),
                  MenuItemData(
                    icon: Icons.local_shipping_outlined,
                    label: 'Receive',
                    onTap: () {},
                  ),
                  MenuItemData(
                    icon: Icons.message_outlined,
                    label: 'Review',
                    onTap: () {},
                    badgeCount: 1,
                  ),
                  MenuItemData(
                    icon: Icons.undo_outlined,
                    label: 'Refund',
                    onTap: () {},
                  ),
                  MenuItemData(
                    icon: Icons.assignment_outlined,
                    label: 'Complaints',
                    onTap: () {},
                  ),
                  MenuItemData(
                    icon: Icons.verified_outlined,
                    label: 'Addons',
                    onTap: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Help section
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MenuSectionWidget(
                title: 'Help',
                menuItems: [
                  MenuItemData(
                    icon: Icons.help_outline,
                    label: 'FAQs',
                    onTap: () {},
                  ),
                  MenuItemData(
                    icon: Icons.card_giftcard_outlined,
                    label: 'Open Parcel',
                    onTap: () {},
                  ),
                  MenuItemData(
                    icon: Icons.phone_outlined,
                    label: 'Contact',
                    onTap: () {},
                  ),
                  MenuItemData(
                    icon: Icons.location_on_outlined,
                    label: 'Locations',
                    onTap: () {},
                  ),
                  MenuItemData(
                    icon: Icons.trending_down_outlined,
                    label: 'EMI',
                    onTap: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MenuSectionWidget(
                title: 'Profile',
                menuItems: [
                  MenuItemData(
                    icon: Icons.menu_book,
                    label: 'Address Book',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddressScreen()),
                      );
                    },
                  ),
                  MenuItemData(
                    icon: Icons.edit_square,
                    label: 'Edit Profile',
                    onTap: () {},
                  ),
                  MenuItemData(
                    icon: Icons.logout,
                    label: 'Logout',
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: false, // jitna content hai utni hi height
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        builder: (ctx) {
                          return LogoutDrawer(
                            onLogout: () {
                              // Yahan tum logout ka logic likh sakte ho
                              // print("User logged out");
                            },
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: BottomBarWidget(
        isLoggedIn: false,
        currentIndex: _selectedBottomIndex,
        onIndexChanged: (index) {
          if (index == 3) {
            // Navigate to Cart page when Bag icon is clicked
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartPageExample()),
            );
          } else if (index == 2) {
            // Navigate to Profile page when Profile icon is clicked
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WishlistPage()),
            );
          } else if (index == 1) {
            // Navigate to Profile page when Profile icon is clicked
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NotificationPage()),
            );
          } else if (index == 0) {
            // Navigate to Profile page when Profile icon is clicked
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyHomePage()),
            );
          } else {
            setState(() {
              _selectedBottomIndex = index;
            });
          }
        },
      ),
    );
  }
}
