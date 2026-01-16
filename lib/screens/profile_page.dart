import 'package:first/main-home.dart';
import 'package:first/screens/add_to_card_page.dart';
import 'package:first/screens/address_book_page.dart';
import 'package:first/screens/contact_page.dart';
import 'package:first/screens/edit_profile_page.dart';
import 'package:first/screens/faqs_page.dart';
import 'package:first/screens/logout_drawer.dart';
import 'package:first/screens/notification_page.dart';
import 'package:first/screens/order_history_page.dart';
import 'package:first/screens/recent_view_more_page.dart';
import 'package:first/screens/wishlist_page.dart';
import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

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
                    top: -20,
                    right: -12,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // border: Border.all(color: Colors.white, width: 2),
                      ),

                      child: IconButton(
                        icon: const Icon(
                          Icons.settings,
                          color: Colors.white,
                          size: 28,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EditProfilePage(
                                initialData: {
                                  'firstName': 'John',
                                  'lastName': 'Doe',
                                  'email': 'john@example.com',
                                  'phone': '+923001234567',
                                },
                              ),
                            ),
                          );
                        },
                      ),
                      // child: const Icon(
                      //   Icons.settings,
                      //   color: Colors.white,
                      //   size: 28,
                      // ),
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
                    label: 'To Pay',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const OrderHistoryPage(initialTabIndex: 1),
                        ),
                      );
                    },
                  ),
                  MenuItemData(
                    icon: Icons.business_center_outlined,
                    label: 'To Ship',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const OrderHistoryPage(initialTabIndex: 2),
                        ),
                      );
                    },
                  ),
                  MenuItemData(
                    icon: Icons.local_shipping_outlined,
                    label: 'To Receive',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const OrderHistoryPage(initialTabIndex: 3),
                        ),
                      );
                    },
                  ),
                  MenuItemData(
                    icon: Icons.message_outlined,
                    label: 'To Review',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const OrderHistoryPage(initialTabIndex: 4),
                        ),
                      );
                    },
                    badgeCount: 1,
                  ),
                  MenuItemData(
                    // icon: Icons.undo_outlined,
                    icon: Icons.cancel_presentation_outlined,
                    label: 'Cancellations',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const OrderHistoryPage(initialTabIndex: 5),
                        ),
                      );
                    },
                  ),
                  MenuItemData(
                    icon: Icons.assignment_return_outlined,
                    // icon: Icons.assignment_outlined,
                    label: 'Returns',
                    onTap: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            UnpaidOrderCarouselWidget(
              orders: [
                UnpaidOrder(
                  id: '1',
                  productImage: 'image_url',
                  orderBadgeText: 'SPECIAL OFFER...',
                  onPayNowPressed: () {
                    // Handle payment navigation
                  },
                ),
                UnpaidOrder(
                  id: '1',
                  productImage: 'image_url',
                  orderBadgeText: 'SPECIAL OFFER...',
                  onPayNowPressed: () {
                    // Handle payment navigation
                  },
                ),
                // ... more orders if needed
              ],
            ),

            const SizedBox(height: 12),

            RecentlyViewedCarouselWidget(
              onViewMorePressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RecentViewMorePage(),
                  ),
                );
              },
              products: [
                RecentlyViewedProduct(
                  id: '1',
                  title: 'Insert 5G network card',
                  image: 'image_url',
                  currentPrice: 1678,
                  originalPrice: 1800,
                  discountPercent: 7,
                ),

                RecentlyViewedProduct(
                  id: '2',
                  title: 'Insert 5G network card',
                  image: 'image_url',
                  currentPrice: 1678,
                  originalPrice: 1800,
                  discountPercent: 7,
                ),
                RecentlyViewedProduct(
                  id: '2',
                  title: 'Insert 5G network card',
                  image: 'image_url',
                  currentPrice: 1678,
                  originalPrice: 1800,
                  discountPercent: 7,
                ),
                RecentlyViewedProduct(
                  id: '2',
                  title: 'Insert 5G network card',
                  image: 'image_url',
                  currentPrice: 1678,
                  originalPrice: 1800,
                  discountPercent: 7,
                ),
                RecentlyViewedProduct(
                  id: '2',
                  title: 'Insert 5G network card',
                  image: 'image_url',
                  currentPrice: 1678,
                  originalPrice: 1800,
                  discountPercent: 7,
                ),
                RecentlyViewedProduct(
                  id: '2',
                  title: 'Insert 5G network card',
                  image: 'image_url',
                  currentPrice: 1678,
                  originalPrice: 1800,
                  discountPercent: 7,
                ),
                RecentlyViewedProduct(
                  id: '2',
                  title: 'Insert 5G network card',
                  image: 'image_url',
                  currentPrice: 1678,
                  originalPrice: 1800,
                ),
                RecentlyViewedProduct(
                  id: '2',
                  title: 'Insert 5G network card',
                  image: 'image_url',
                  currentPrice: 1678,
                  originalPrice: 1800,
                ),
                RecentlyViewedProduct(
                  id: '2',
                  title: 'Insert 5G network card',
                  image: 'image_url',
                  currentPrice: 1678,
                  originalPrice: 1800,
                ),
                // ... more products
              ],
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FAQsPage(),
                        ),
                      );
                    },
                  ),
                  // MenuItemData(
                  //   icon: Icons.help_center,
                  //   label: 'Help Center',
                  //   onTap: () {},
                  // ),
                  MenuItemData(
                    icon: Icons.edit_document,
                    // icon: Icons.assignment_outlined,
                    label: 'Complaints',
                    onTap: () {},
                  ),
                  MenuItemData(
                    icon: Icons.phone_outlined,
                    label: 'Contact',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ContactUsPage(),
                        ),
                      );
                    },
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
                        MaterialPageRoute(
                          builder: (context) => AddressScreen(),
                        ),
                      );
                    },
                  ),
                  MenuItemData(
                    icon: Icons.edit_square,
                    label: 'Edit Profile',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditProfilePage(
                            initialData: {
                              'firstName': 'John',
                              'lastName': 'Doe',
                              'email': 'john@example.com',
                              'phone': '+923001234567',
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  MenuItemData(
                    icon: Icons.logout,
                    label: 'Logout',
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled:
                            false, // jitna content hai utni hi height
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
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
