// import 'dart:ui';

// import 'package:first/core/app_imports.dart';

// final session = UserSessionManager();

// class BottomBarWidget extends StatefulWidget {
//   final int currentIndex;
//   final Function(int) onIndexChanged;

//   const BottomBarWidget({
//     super.key,
//     required this.currentIndex,
//     required this.onIndexChanged,
//   });

//   @override
//   State<BottomBarWidget> createState() => _BottomBarWidgetState();
// }

// class _BottomBarWidgetState extends State<BottomBarWidget> {
//   final List<BottomBarItem> items = [
//     BottomBarItem(Icons.home_outlined, Icons.home, 'Home'),
//     BottomBarItem(
//       Icons.notifications_none,
//       Icons.notifications,
//       'Notifications',
//     ),
//     BottomBarItem(Icons.favorite_outline, Icons.favorite, 'Favourites'),
//     BottomBarItem(Icons.shopping_bag_outlined, Icons.shopping_bag, 'Bag'),
//     BottomBarItem(Icons.person_outline, Icons.person, 'Profile'),
//   ];

//   bool _showGuestBar = true;

//   /// ✅ Gradient Icon
//   Widget _gradientIcon(IconData icon) {
//     return ShaderMask(
//       shaderCallback: (bounds) => AppColors.bgGradient.createShader(bounds),
//       child: Icon(icon, size: 25, color: Colors.white),
//     );
//   }

//   void _openLogin() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (_) => const LoginPage()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Get real-time login status from session manager
//     final isLoggedInNow = session.isLoggedIn;
//     final bool shouldShowGuestBar = !isLoggedInNow && _showGuestBar;

//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         /// 🔹 SIGN IN PATI (RESTORED)
//         AnimatedSize(
//           duration: const Duration(milliseconds: 220),
//           curve: Curves.easeOut,
//           child: shouldShowGuestBar
//               ? ClipRRect(
//                   child: BackdropFilter(
//                     filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
//                     child: Container(
//                       width: double.infinity,
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 14,
//                         vertical: 6,
//                       ),
//                       decoration: BoxDecoration(
//                         color: const Color.fromARGB(255, 216, 216, 216),
//                         border: Border.all(
//                           color: AppColors.glassmorphismBorderBlack,
//                         ),
//                       ),
//                       child: Row(
//                         children: [
//                           InkWell(
//                             onTap: () => setState(() => _showGuestBar = false),
//                             borderRadius: BorderRadius.circular(999),
//                             child: const Padding(
//                               padding: EdgeInsets.all(6),
//                               child: Icon(
//                                 Icons.close,
//                                 size: 18,
//                                 color: AppColors.textBlack87,
//                               ),
//                             ),
//                           ),
//                           const Spacer(),
//                           PrimaryBtnWidget(
//                             onPressed: _openLogin,
//                             buttonText: "Sign In",
//                             height: 34,
//                             width: 88,
//                             fontSize: 12,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 )
//               : const SizedBox.shrink(),
//         ),

//         /// 🔹 BOTTOM NAV (UNCHANGED)
//         Container(
//           decoration: BoxDecoration(
//             color: AppColors.backgroundWhite,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.15),
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
//                 icon: Icon(item.outlinedIcon, color: Colors.grey),
//                 activeIcon: _gradientIcon(item.filledIcon),
//                 label: item.label,
//               );
//             }).toList(),

//             /// ✅ SAME LABEL STYLE — ONLY COLOR CHANGED
//             selectedItemColor: AppColors.bgGradient.colors.first,
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
//   final IconData outlinedIcon;
//   final IconData filledIcon;
//   final String label;

//   BottomBarItem(this.outlinedIcon, this.filledIcon, this.label);
// }



































import 'dart:ui';

import 'package:first/core/app_imports.dart';

// final session = UserSessionManager();

class BottomBarWidget extends StatefulWidget {
  final int currentIndex;
  final Function(int) onIndexChanged;

  const BottomBarWidget({
    super.key,
    required this.currentIndex,
    required this.onIndexChanged,
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
    ).then((_) {
      // 🔁 login ke baad rebuild so session reflect ho
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    /// 🔑 SINGLE SOURCE OF TRUTH
    final bool isLoggedIn = session.isLoggedIn;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        /// 🔹 SIGN IN BAR (ONLY WHEN NOT LOGGED IN)
        AnimatedSize(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          child: isLoggedIn
              ? const SizedBox.shrink() // ✅ HIDDEN when logged in
              : ClipRRect(
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
                ),
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

              return BottomNavigationBarItem(
                icon: Icon(item.outlinedIcon, color: Colors.grey),
                activeIcon: _gradientIcon(item.filledIcon),
                label: item.label,
              );
            }).toList(),
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
