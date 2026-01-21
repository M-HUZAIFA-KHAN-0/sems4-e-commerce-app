import 'package:first/main-home.dart';
import 'package:first/screens/add_to_card_page.dart';
import 'package:first/screens/profile_page.dart';
import 'package:first/screens/wishlist_page.dart';
import 'package:first/widgets/add_to_card_prod_item_widget.dart';
import 'package:first/widgets/bottom_bar_widget.dart';
import 'package:first/widgets/notification_card_widget.dart';
import 'package:first/widgets/section_title_widget.dart';
import 'package:first/widgets/notification_card_item_widget.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
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
          SectionTitleWidget(text: 'Today'),
          NotificationCardItemWidget(
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
          SectionTitleWidget(text: 'Yesterday'),
          NotificationCardItemWidget(
            icon: Icons.location_on_outlined,
            title: 'New Services Available!',
            subtitle: 'Now you can track orders in real time',
            date: '1 day ago',
            showButton: false,
          ),
          NotificationCardItemWidget(
            icon: Icons.sell_outlined,
            title: 'Your offer has been rejected!',
            subtitle:
                "We're sorry, your offer has been rejected by the seller :(",
            date: '1 day ago',
            showButton: true,
          ),
          NotificationCardItemWidget(
            icon: Icons.credit_card,
            title: 'Credit Card Connected!',
            subtitle: 'Credit Card has been linked!',
            date: '1 day ago',
          ),
          SectionTitleWidget(text: 'December 22, 2024'),
          NotificationCardItemWidget(
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
