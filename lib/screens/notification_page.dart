import 'package:first/main-home.dart';
import 'package:first/screens/add_to_card_page.dart';
import 'package:first/screens/profile_page.dart';
import 'package:first/screens/wishlist_page.dart';
import 'package:first/widgets/add_to_card_prod_item_widget.dart';
import 'package:first/widgets/bottom_bar_widget.dart';
import 'package:first/widgets/notification_card_widget.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 6),
      child: Text(
        text,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _card({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String date,
    String? subtitle,
    bool showButton = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
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
              color: Colors.black,
              borderRadius: BorderRadius.circular(26),
            ),
            child: Icon(icon, color: Colors.white, size: 28),
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
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF9AA0A6),
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

                // 🔥 Button ab Column ke andar
                if (showButton) ...[
                  const SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.black, width: 1),
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
                        color: Colors.black,
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

  int _selectedBottomIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black87,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text(
          'Notification',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.more_horiz), onPressed: () {}),
        ],
      ),
      body: ListView(
        children: [
          _sectionTitle('Today'),
          _card(
            context: context,
            icon: Icons.sell_outlined,
            title: 'Your offer has been accepted!',
            subtitle:
                "Congrats! your offer has been accepted by the seller for \$170.00",
            date: '2 hrs ago',
            showButton: true,
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: WishlistCardWidget(
              item: NotificationCardItem(
                title: 'Package Shipped!',
                subtitle: 'Your package is on the way.',
                icon: Icons.local_shipping_outlined,
              ),
            ),
          ),

          _sectionTitle('Yesterday'),
          _card(
            context: context,
            icon: Icons.location_on_outlined,
            title: 'New Services Available!',
            subtitle: 'Now you can track orders in real time',
            date: '1 day ago',
            showButton: false,
          ),
          _card(
            context: context,
            icon: Icons.sell_outlined,
            title: 'Your offer has been rejected!',
            subtitle:
                "We're sorry, your offer has been rejected by the seller :(",
            date: '1 day ago',
            showButton: true,
          ),
          _card(
            context: context,
            icon: Icons.credit_card,
            title: 'Credit Card Connected!',
            subtitle: 'Credit Card has been linked!',
            date: '1 day ago',
          ),

          _sectionTitle('December 22, 2024'),
          _card(
            context: context,
            icon: Icons.check_circle_outline,
            title: 'Account Setup Successful!',
            subtitle: 'Account Setup has been completed.',
            date: '5 days ago',
          ),

          const SizedBox(height: 24),
        ],
      ),
      bottomNavigationBar: BottomBarWidget(
        isLoggedIn: false,
        currentIndex: _selectedBottomIndex,
        onIndexChanged: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyHomePage()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WishlistPage()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartPageExample()),
            );
          } else if (index == 4) {
            // Navigate to Profile page when Profile icon is clicked
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          } else {
            setState(() {
              _selectedBottomIndex = index;
            });
          }
          setState(() {
            _selectedBottomIndex = index;
          });
        },
      ),
    );
  }
}

CartProductItem NotificationCardItem({
  required String? title,
  required String subtitle,
  required IconData icon,
}) {
  return CartProductItem(
    id: 'notif_01',
    title: title ?? 'Notification',
    variantText: subtitle,
    imageUrl: '',
    priceText: "99",
    quantity: 0,
    stock: 8,
  );
}
