import 'package:first/core/app_imports.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  int _selectedBottomIndex = 1;
  final UserSessionManager _sessionManager = UserSessionManager();

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = _sessionManager.isLoggedIn;

    return Scaffold(
      backgroundColor: AppColors.backgroundGreyLightest,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        foregroundColor: AppColors.textBlack87,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text(
          'Notification',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: isLoggedIn
          ? _buildNotificationContent()
          : _buildLoginRequiredState(),
      bottomNavigationBar: BottomBarWidget(
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

  Widget _buildNotificationContent() {
    return ListView(
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
    );
  }

  Widget _buildLoginRequiredState() {
    return EmptyStateWidget(
      emptyMessage:
          "Sign in to your account to view\nnotifications and stay updated.",
      icon: Icons.notifications_none,
      buttonText: "Sign In",
      onButtonPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      },
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
    // variantText: subtitle,
    ramStorageText: '',
    color: '',
    imageUrl: '',
    priceText: "99",
    quantity: 0,
    stock: 8,
  );
}
