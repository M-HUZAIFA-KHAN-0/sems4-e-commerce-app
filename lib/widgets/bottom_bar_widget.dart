// import 'package:first/core/app_imports.dart';

// class BottomBarWidget extends StatefulWidget {
//   final int currentIndex;
//   final Function(int) onIndexChanged;

//   /// ✅ Login state comes from parent (default logged out)
//   final bool isLoggedIn;

//   /// Optional: allow parent to be notified when login state changes
//   final ValueChanged<bool>? onLoginChanged;

//   const BottomBarWidget({
//     super.key,
//     required this.currentIndex,
//     required this.onIndexChanged,
//     this.isLoggedIn = false,
//     this.onLoginChanged,
//   });

//   @override
//   State<BottomBarWidget> createState() => _BottomBarWidgetState();
// }

// class _BottomBarWidgetState extends State<BottomBarWidget> {
//   final List<BottomBarItem> items = [
//     BottomBarItem(icon: Icons.home_outlined, label: 'Home'),
//     BottomBarItem(icon: Icons.notifications_none, label: 'notifications'),
//     BottomBarItem(icon: Icons.favorite_outline, label: 'Favourites'),
//     BottomBarItem(icon: Icons.shopping_bag_outlined, label: 'Bag'),
//     BottomBarItem(icon: Icons.person_outline, label: 'Profile'),
//   ];

//   bool _showGuestBar = true; // ✅ default visible when logged out

//   @override
//   void didUpdateWidget(covariant BottomBarWidget oldWidget) {
//     super.didUpdateWidget(oldWidget);

//     // If user becomes logged in, bar must disappear
//     if (!oldWidget.isLoggedIn && widget.isLoggedIn) {
//       setState(() => _showGuestBar = false);
//     }
//   }

//   void _openLogin() async {
//     // Navigate to Login Page
//     await Navigator.push(
//       context,
//       MaterialPageRoute(builder: (_) => const LoginPage()),
//     );

//     // Optional: if you want to mark as logged in after returning
//     // (You can remove this if your auth is handled elsewhere)
//     // widget.onLoginChanged?.call(true);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final bool shouldShowGuestBar = !widget.isLoggedIn && _showGuestBar;

//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         // ✅ Guest sign-in bar above bottom nav
//         AnimatedSize(
//           duration: const Duration(milliseconds: 220),
//           curve: Curves.easeOut,
//           child: shouldShowGuestBar
//               ? Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 14,
//                     vertical: 10,
//                   ),
//                   color: const Color(0xFFE5E7EB), // gray background
//                   child: Row(
//                     children: [
//                       // Cross icon
//                       InkWell(
//                         onTap: () => setState(() => _showGuestBar = false),
//                         borderRadius: BorderRadius.circular(999),
//                         child: const Padding(
//                           padding: EdgeInsets.all(6),
//                           child: Icon(
//                             Icons.close,
//                             size: 18,
//                             color: AppColors.textBlack87,
//                           ),
//                         ),
//                       ),

//                       const Spacer(),

//                       // Sign In button
//                       SizedBox(
//                         height: 34,
//                         child: ElevatedButton(
//                           onPressed: _openLogin,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: AppColors.textBlack,
//                             elevation: 0,
//                             padding: const EdgeInsets.symmetric(horizontal: 18),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(18),
//                             ),
//                           ),
//                           child: const Text(
//                             "Sign In",
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w700,
//                               color: AppColors.backgroundWhite,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               : const SizedBox.shrink(),
//         ),

//         // ✅ Existing bottom nav (unchanged)
//         Container(
//           decoration: BoxDecoration(
//             color: AppColors.backgroundWhite,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.15),
//                 spreadRadius: 1,
//                 blurRadius: 8,
//                 offset: const Offset(0, -2),
//               ),
//             ],
//           ),
//           child: BottomNavigationBar(
//             currentIndex: widget.currentIndex,
//             onTap: widget.onIndexChanged,
//             type: BottomNavigationBarType.fixed,
//             backgroundColor: AppColors.backgroundWhite,
//             elevation: 0,
//             items: items.asMap().entries.map((entry) {
//               final index = entry.key;
//               final item = entry.value;
//               final isActive = widget.currentIndex == index;

//               return BottomNavigationBarItem(
//                 icon: Icon(
//                   item.icon,
//                   color: isActive ? Colors.black : Colors.grey,
//                   size: 24,
//                 ),
//                 label: item.label,
//                 activeIcon: Icon(
//                   item.icon,
//                   color: AppColors.textBlack,
//                   size: 24,
//                 ),
//               );
//             }).toList(),
//             selectedItemColor: AppColors.textBlack,
//             unselectedItemColor: Colors.grey,
//             selectedLabelStyle: const TextStyle(
//               fontSize: 11,
//               fontWeight: FontWeight.w600,
//             ),
//             unselectedLabelStyle: const TextStyle(
//               fontSize: 10,
//               fontWeight: FontWeight.w400,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class BottomBarItem {
//   final IconData icon;
//   final String label;

//   BottomBarItem({required this.icon, required this.label});
// }

// import 'package:first/core/app_imports.dart';

// class BottomBarWidget extends StatefulWidget {
//   final int currentIndex;
//   final Function(int) onIndexChanged;
//   final bool isLoggedIn;

//   const BottomBarWidget({
//     super.key,
//     required this.currentIndex,
//     required this.onIndexChanged,
//     this.isLoggedIn = false,
//   });

//   @override
//   State<BottomBarWidget> createState() => _BottomBarWidgetState();
// }

// class _BottomBarWidgetState extends State<BottomBarWidget> {
//   final List<BottomBarItem> items = [
//     BottomBarItem(Icons.home_outlined, Icons.home, 'Home'),
//     BottomBarItem(Icons.notifications_none, Icons.notifications, 'Notifications'),
//     BottomBarItem(Icons.favorite_outline, Icons.favorite, 'Favourites'),
//     BottomBarItem(Icons.shopping_bag_outlined, Icons.shopping_bag, 'Bag'),
//     BottomBarItem(Icons.person_outline, Icons.person, 'Profile'),
//   ];

//   /// Gradient Icon
//   Widget _gradientIcon(IconData icon) {
//     return ShaderMask(
//       shaderCallback: (bounds) =>
//           AppColors.bgGradient.createShader(bounds),
//       child: Icon(icon, size: 25, color: Colors.white),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.backgroundWhite,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.15),
//             blurRadius: 8,
//             offset: const Offset(0, -2),
//           ),
//         ],
//       ),
//       child: BottomNavigationBar(
//         currentIndex: widget.currentIndex,
//         onTap: widget.onIndexChanged,
//         type: BottomNavigationBarType.fixed,
//         backgroundColor: AppColors.backgroundWhite,
//         elevation: 0,
//         items: items.asMap().entries.map((entry) {
//           final index = entry.key;
//           final item = entry.value;
//           final isActive = widget.currentIndex == index;

//           return BottomNavigationBarItem(
//             icon: Icon(
//               item.outlinedIcon,
//               color: Colors.grey,
//             ),
//             activeIcon: _gradientIcon(item.filledIcon),
//             label: item.label,
//           );
//         }).toList(),

//         /// 👇 text color stays CLEAN (no layout damage)
//         selectedItemColor: AppColors.bgGradient.colors.first,
//         unselectedItemColor: Colors.grey,

//         selectedLabelStyle: const TextStyle(
//           fontSize: 11,
//           fontWeight: FontWeight.w600,
//         ),
//         unselectedLabelStyle: const TextStyle(
//           fontSize: 10,
//           fontWeight: FontWeight.w400,
//         ),
//       ),
//     );
//   }
// }

// class BottomBarItem {
//   final IconData outlinedIcon;
//   final IconData filledIcon;
//   final String label;

//   BottomBarItem(this.outlinedIcon, this.filledIcon, this.label);
// }

import 'dart:ui';

import 'package:first/core/app_imports.dart';

class BottomBarWidget extends StatefulWidget {
  final int currentIndex;
  final Function(int) onIndexChanged;
  final bool isLoggedIn;

  const BottomBarWidget({
    super.key,
    required this.currentIndex,
    required this.onIndexChanged,
    this.isLoggedIn = false,
  });

  @override
  State<BottomBarWidget> createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  final List<BottomBarItem> items = [
    BottomBarItem(Icons.home_outlined, Icons.home, 'Home'),
    BottomBarItem(
      Icons.notifications_none,
      Icons.notifications,
      'Notifications',
    ),
    BottomBarItem(Icons.favorite_outline, Icons.favorite, 'Favourites'),
    BottomBarItem(Icons.shopping_bag_outlined, Icons.shopping_bag, 'Bag'),
    BottomBarItem(Icons.person_outline, Icons.person, 'Profile'),
  ];

  bool _showGuestBar = true;

  /// ✅ Gradient Icon
  Widget _gradientIcon(IconData icon) {
    return ShaderMask(
      shaderCallback: (bounds) => AppColors.bgGradient.createShader(bounds),
      child: Icon(icon, size: 25, color: Colors.white),
    );
  }

  void _openLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool shouldShowGuestBar = !widget.isLoggedIn && _showGuestBar;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        /// 🔹 SIGN IN PATI (RESTORED)
        AnimatedSize(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          child: shouldShowGuestBar
    ? ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 216, 216, 216),
              border: Border.all(
                color: AppColors.glassmorphismBorderBlack,
              ),
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: () => setState(() => _showGuestBar = false),
                  borderRadius: BorderRadius.circular(999),
                  child: const Padding(
                    padding: EdgeInsets.all(6),
                    child: Icon(
                      Icons.close,
                      size: 18,
                      color: AppColors.textBlack87,
                    ),
                  ),
                ),
                const Spacer(),
                PrimaryBtnWidget(
                  onPressed: _openLogin,
                  buttonText: "Sign In",
                  height: 34,
                  width: 88,
                  fontSize: 12,
                ),
              ],
            ),
          ),
        ),
      )
    : const SizedBox.shrink(),
        ),

        /// 🔹 BOTTOM NAV (UNCHANGED)
        Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundWhite,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: widget.currentIndex,
            onTap: widget.onIndexChanged,
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.backgroundWhite,
            elevation: 0,
            items: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isActive = widget.currentIndex == index;

              return BottomNavigationBarItem(
                icon: Icon(item.outlinedIcon, color: Colors.grey),
                activeIcon: _gradientIcon(item.filledIcon),
                label: item.label,
              );
            }).toList(),

            /// ✅ SAME LABEL STYLE — ONLY COLOR CHANGED
            selectedItemColor: AppColors.bgGradient.colors.first,
            unselectedItemColor: Colors.grey,

            selectedLabelStyle: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}

class BottomBarItem {
  final IconData outlinedIcon;
  final IconData filledIcon;
  final String label;

  BottomBarItem(this.outlinedIcon, this.filledIcon, this.label);
}
