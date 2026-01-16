// import 'package:flutter/material.dart';

// class CategoriesDrawer extends StatefulWidget {
//   const CategoriesDrawer({super.key});

//   @override
//   State<CategoriesDrawer> createState() => _CategoriesDrawerState();
// }

// class _CategoriesDrawerState extends State<CategoriesDrawer> {
//   final List<MenuItemData> menuItems = [
//     MenuItemData(label: 'My Account', icon: Icons.person),
//     MenuItemData(label: 'Track my Order', icon: Icons.location_on),
//     MenuItemData(label: 'Launch a Complaint', icon: Icons.assignment),
//     MenuItemData(label: 'Notifications', icon: Icons.notifications),
//     MenuItemData(label: 'Logout', icon: Icons.logout),
//   ];

//   final List<CategoryItem> categories = [
//     CategoryItem(label: 'Mobiles', icon: Icons.phone_android),
//     CategoryItem(label: 'Smart Watches', icon: Icons.watch),
//     CategoryItem(label: 'Wireless Earbuds', icon: Icons.headset),
//     CategoryItem(label: 'Air Purifiers', icon: Icons.air),
//     CategoryItem(label: 'Personal Cares', icon: Icons.health_and_safety),
//     CategoryItem(label: 'Mobiles Accessories', icon: Icons.cable),
//     CategoryItem(label: 'Bluetooth Speakers', icon: Icons.speaker),
//     CategoryItem(label: 'Power Banks', icon: Icons.power_input),
//     CategoryItem(label: 'Tablets', icon: Icons.tablet),
//     CategoryItem(label: 'Laptops', icon: Icons.laptop),
//   ];

//   final List<PopularListItem> popularLists = [
//     PopularListItem(label: 'Best Mobiles Under 10000'),
//     PopularListItem(label: 'Best Mobiles Under 15000'),
//     PopularListItem(label: 'Best Mobiles Under 20000'),
//     PopularListItem(label: 'Best Mobiles Under 30000'),
//     PopularListItem(label: 'Best Mobiles Under 40000'),
//     PopularListItem(label: 'Best Mobiles Under 50000'),
//   ];

//   // final List<MainNavItem> mainNavItems = [
//   //   MainNavItem(label: 'About'),
//   //   MainNavItem(label: 'FAQs'),
//   //   MainNavItem(label: 'Careers'),
//   //   MainNavItem(label: 'Contact'),
//   //   MainNavItem(label: 'Privacy Policy'),
//   //   MainNavItem(label: 'Press & Blog'),
//   //   MainNavItem(label: 'Installments Plan'),
//   // ];

//   final List<MenuItemData> MainNavItemWidget = [
//     MenuItemData(label: 'My Account', icon: Icons.person),
//     MenuItemData(label: 'Track my Order', icon: Icons.location_on),
//     MenuItemData(label: 'Launch a Complaint', icon: Icons.assignment),
//     MenuItemData(label: 'Notifications', icon: Icons.notifications),
//     MenuItemData(label: 'Logout', icon: Icons.logout),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: Theme.of(context).copyWith(
//         drawerTheme: const DrawerThemeData(
//           elevation: 0,
//         ),
//       ),
//       child: Drawer(
//         child: Container(
//           color: Colors.white,
//           child: Column(
//             children: [
//               // Header with Close Button
//               Container(
//                 color: const Color(0xFF2196F3),
//                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const SizedBox(width: 48),
//                     Expanded(
//                       child: Text(
//                         'Priceøye',
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.close, color: Colors.white),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                   ],
//                 ),
//               ),
//             // Main Content
//             Expanded(
//               child: SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 child: Column(
//                   children: [
//                     // Menu Items Section (My Account, Track, etc.)
//                     Container(
//                       color: const Color(0xFF2196F3),
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 12,
//                       ),
//                       child: Column(
//                         children: List.generate(
//                           menuItems.length,
//                           (index) => MenuItem(
//                             item: menuItems[index],
//                             onTap: () {
//                               Navigator.pop(context);
//                               // Handle menu item tap
//                             },
//                           ),
//                         ),
//                       ),
//                     ),
//                     // Categories Section
//                     Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'CATEGORIES',
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w600,
//                               color: Color(0xFF999999),
//                               letterSpacing: 1.2,
//                             ),
//                           ),
//                           const SizedBox(height: 16),
//                           ...List.generate(
//                             categories.length,
//                             (index) => CategoryExpandableItem(
//                               category: categories[index],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const Divider(thickness: 1, color: Color(0xFFEEEEEE)),
//                     // Popular Lists Section
//                     Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'POPULAR LISTS',
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w600,
//                               color: Color(0xFF999999),
//                               letterSpacing: 1.2,
//                             ),
//                           ),
//                           const SizedBox(height: 16),
//                           ...List.generate(
//                             popularLists.length,
//                             (index) => PopularListItemWidget(
//                               item: popularLists[index],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const Divider(thickness: 1, color: Color(0xFFEEEEEE)),
//                     // Main Navigation Section
//                     // Padding(
//                     //   padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
//                     //   child: Column(
//                     //     crossAxisAlignment: CrossAxisAlignment.start,
//                     //     children: [
//                     //       const Padding(
//                     //         padding: EdgeInsets.only(left: 16),
//                     //         child: Text(
//                     //           'MAIN NAVIGATION',
//                     //           style: TextStyle(
//                     //             fontSize: 12,
//                     //             fontWeight: FontWeight.w600,
//                     //             color: Color(0xFF999999),
//                     //             letterSpacing: 1.2,
//                     //           ),
//                     //         ),
//                     //       ),
//                     //       const SizedBox(height: 16),
//                     //       ...List.generate(
//                     //         mainNavItems.length,
//                     //         (index) =>
//                     //             MainNavItemWidget(item: mainNavItems[index]),
//                     //       ),
//                     //     ],
//                     //   ),
//                     // ),

//                     Container(
//                       color: const Color(0xFF2196F3),
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 12,
//                       ),
//                       child: Column(
//                         children: List.generate(
//                           menuItems.length,
//                           (index) => MainNavItemWidget(
//                             item: menuItems[index],
//                             onTap: () {
//                               Navigator.pop(context);
//                               // Handle menu item tap
//                             },
//                           ),
//                         ),
//                         // children: List.generate(
//                         //     mainNavItems.length,
//                         //     (index) =>
//                         //         MainNavItemWidget(item: mainNavItems[index]),
//                         //   ),
//                       ),

//                       // child: Column(
//                       //   children: [

//                       //      Text(
//                       //         'MAIN NAVIGATION',
//                       //         style: TextStyle(
//                       //           fontSize: 12,
//                       //           fontWeight: FontWeight.w600,
//                       //           color: Color(0xFF999999),
//                       //           letterSpacing: 1.2,
//                       //         ),
//                       //       ),

//                       //     // const SizedBox(height: 16),
//                       //     // ...List.generate(
//                       //     //   mainNavItems.length,
//                       //     //   (index) =>
//                       //     //       MainNavItemWidget(item: mainNavItems[index]),
//                       //     // ),
//                       //   ],
//                       // ),

//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//     );
//   }
// }

// // Data classes
// class MenuItemData {
//   final String label;
//   final IconData icon;

//   MenuItemData({required this.label, required this.icon});
// }

// class CategoryItem {
//   final String label;
//   final IconData icon;

//   CategoryItem({required this.label, required this.icon});
// }

// class PopularListItem {
//   final String label;

//   PopularListItem({required this.label});
// }

// class MainNavItem {
//   final String label;

//   MainNavItem({required this.label});
// }

// // Menu Item Widget
// class MenuItem extends StatelessWidget {
//   final MenuItemData item;
//   final VoidCallback onTap;

//   const MenuItem({super.key, required this.item, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 14),
//         child: Row(
//           children: [
//             Icon(item.icon, size: 24, color: Colors.white),
//             const SizedBox(width: 16),
//             Text(
//               item.label,
//               style: const TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Category Expandable Item Widget
// class CategoryExpandableItem extends StatefulWidget {
//   final CategoryItem category;

//   const CategoryExpandableItem({super.key, required this.category});

//   @override
//   State<CategoryExpandableItem> createState() => _CategoryExpandableItemState();
// }

// class _CategoryExpandableItemState extends State<CategoryExpandableItem>
//     with SingleTickerProviderStateMixin {
//   bool _isExpanded = false;
//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 250),
//       vsync: this,
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         InkWell(
//           onTap: () {
//             setState(() {
//               _isExpanded = !_isExpanded;
//               if (_isExpanded) {
//                 _controller.forward();
//               } else {
//                 _controller.reverse();
//               }
//             });
//           },
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 12),
//             child: Row(
//               children: [
//                 Icon(widget.category.icon, size: 24, color: Colors.black54),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Text(
//                     widget.category.label,
//                     style: const TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ),
//                 AnimatedRotation(
//                   turns: _isExpanded ? 0.5 : 0.0,
//                   duration: const Duration(milliseconds: 250),
//                   child: const Icon(
//                     Icons.expand_more,
//                     color: Color(0xFFCCCCCC),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         // Expandable Content
//         ClipRect(
//           child: AnimatedAlign(
//             duration: const Duration(milliseconds: 250),
//             curve: Curves.easeInOut,
//             alignment: _isExpanded ? Alignment.topCenter : Alignment.topCenter,
//             heightFactor: _isExpanded ? 1.0 : 0.0,
//             child: Padding(
//               padding: const EdgeInsets.only(left: 20, bottom: 8),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildSubcategory('All ${widget.category.label}'),
//                   _buildSubcategory('Popular ${widget.category.label}'),
//                   _buildSubcategory('New ${widget.category.label}'),
//                   _buildSubcategory('Top Rated ${widget.category.label}'),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSubcategory(String label) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8),
//       child: Text(
//         label,
//         style: const TextStyle(fontSize: 13, color: Color(0xFF666666)),
//       ),
//     );
//   }
// }

// // Popular List Item Widget
// class PopularListItemWidget extends StatelessWidget {
//   final PopularListItem item;

//   const PopularListItemWidget({super.key, required this.item});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: GestureDetector(
//         onTap: () {
//           Navigator.pop(context);
//         },
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//           decoration: BoxDecoration(
//             border: Border.all(color: const Color(0xFFE0E0E0)),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Text(
//                   item.label,
//                   style: const TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w500,
//                     color: Color(0xFF666666),
//                   ),
//                 ),
//               ),
//               const Icon(
//                 Icons.chevron_right,
//                 size: 20,
//                 color: Color(0xFFCCCCCC),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Main Navigation Item Widget

// class MainNavItemWidget extends StatelessWidget {
//   final MenuItemData item;
//   final VoidCallback onTap;

//   const MainNavItemWidget({super.key, required this.item, required this.onTap});
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 14),
//         child: Row(
//           children: [
//             Icon(item.icon, size: 24, color: Colors.white),
//             const SizedBox(width: 16),
//             Text(
//               item.label,
//               style: const TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // class MainNavItemWidget extends StatelessWidget {
// //   final MainNavItem item;

// //   const MainNavItemWidget({super.key, required this.item});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: const EdgeInsets.only(bottom: 14, left: 0),
// //       child: GestureDetector(
// //         onTap: () {
// //           Navigator.pop(context);
// //         },
// //         child: Text(
// //           item.label,
// //           style: const TextStyle(
// //             fontSize: 14,
// //             fontWeight: FontWeight.w500,
// //             color: Color(0xFF666666),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';

// /// Slow Drawer Animation Configuration
// class SlowDrawerConfig {
//   static const Duration animationDuration = Duration(milliseconds: 600);
//   static const Curve animationCurve = Curves.easeInOut;
// }

// class CategoriesDrawer extends StatefulWidget {
//   const CategoriesDrawer({super.key});

//   @override
//   State<CategoriesDrawer> createState() => _CategoriesDrawerState();
// }

// class _CategoriesDrawerState extends State<CategoriesDrawer> {
//   final List<MenuItemData> topMenuItems = [
//     MenuItemData(label: 'My Account', icon: Icons.person),
//     MenuItemData(label: 'Track my Order', icon: Icons.location_on),
//     MenuItemData(label: 'Launch a Complaint', icon: Icons.assignment),
//     MenuItemData(label: 'Notifications', icon: Icons.notifications),
//     MenuItemData(label: 'Logout', icon: Icons.logout),
//   ];

//   final List<CategoryItem> categories = [
//     CategoryItem(label: 'Mobiles', icon: Icons.phone_android),
//     CategoryItem(label: 'Smart Watches', icon: Icons.watch),
//     CategoryItem(label: 'Wireless Earbuds', icon: Icons.headset),
//     CategoryItem(label: 'Air Purifiers', icon: Icons.air),
//     CategoryItem(label: 'Personal Cares', icon: Icons.health_and_safety),
//     CategoryItem(label: 'Mobiles Accessories', icon: Icons.cable),
//     CategoryItem(label: 'Bluetooth Speakers', icon: Icons.speaker),
//     CategoryItem(label: 'Power Banks', icon: Icons.power_input),
//     CategoryItem(label: 'Tablets', icon: Icons.tablet),
//     CategoryItem(label: 'Laptops', icon: Icons.laptop),
//   ];

//   final List<PopularListItem> popularLists = [
//     PopularListItem(label: 'Best Mobiles Under 10000'),
//     PopularListItem(label: 'Best Mobiles Under 15000'),
//     PopularListItem(label: 'Best Mobiles Under 20000'),
//     PopularListItem(label: 'Best Mobiles Under 30000'),
//     PopularListItem(label: 'Best Mobiles Under 40000'),
//     PopularListItem(label: 'Best Mobiles Under 50000'),
//   ];

//   final List<MenuItemData> bottomMenuItems = [
//     MenuItemData(label: 'About'),
//     MenuItemData(label: 'FAQs'),
//     MenuItemData(label: 'Contact'),
//     MenuItemData(label: 'Privacy Policy'),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: Theme.of(context).copyWith(
//         drawerTheme: DrawerThemeData(
//           elevation: 0,
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//               topRight: Radius.circular(1),
//               bottomRight: Radius.circular(1),
//             ),
//           ),
//         ),
//       ),
//       child: Drawer(
//         child: Container(
//           color: Colors.white,
//           child: Column(
//             children: [
//               // Header
//               Container(
//                 color: const Color(0xFF2196F3),
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 16,
//                 ),
//                 child: Row(
//                   children: [
//                     const SizedBox(width: 48),
//                     const Expanded(
//                       child: Text(
//                         'Priceøye',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.close, color: Colors.white),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                   ],
//                 ),
//               ),

//               // Body
//               Expanded(
//                 child: SingleChildScrollView(
//                   physics: const BouncingScrollPhysics(),
//                   child: Column(
//                     children: [
//                       // Top Menu
//                       Container(
//                         color: const Color(0xFF2196F3),
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 16,
//                           vertical: 12,
//                         ),
//                         child: Column(
//                           children: List.generate(
//                             topMenuItems.length,
//                             (i) => MenuItemWidget(
//                               item: topMenuItems[i],
//                               onTap: () => Navigator.pop(context),
//                             ),
//                           ),
//                         ),
//                       ),

//                       // Categories
//                       Padding(
//                         padding: const EdgeInsets.all(16),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               'CATEGORIES',
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w600,
//                                 color: Color(0xFF999999),
//                                 letterSpacing: 1.2,
//                               ),
//                             ),
//                             const SizedBox(height: 16),
//                             ...List.generate(
//                               categories.length,
//                               (i) => CategoryExpandableItem(
//                                 category: categories[i],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),

//                       const Divider(thickness: 1, color: Color(0xFFEEEEEE)),

//                       // Popular Lists
//                       Padding(
//                         padding: const EdgeInsets.all(16),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               'POPULAR LISTS',
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w600,
//                                 color: Color(0xFF999999),
//                                 letterSpacing: 1.2,
//                               ),
//                             ),
//                             const SizedBox(height: 16),
//                             ...List.generate(
//                               popularLists.length,
//                               (i) =>
//                                   PopularListItemWidget(item: popularLists[i]),
//                             ),
//                           ],
//                         ),
//                       ),

//                       const Divider(thickness: 1, color: Color(0xFFEEEEEE)),

//                       // Bottom Menu (Main Navigation)
//                       Container(
//                         color: const Color(0xFF2196F3),
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 16,
//                           vertical: 12,
//                         ),
//                         child: Column(
//                           children: List.generate(
//                             bottomMenuItems.length,
//                             (i) => MenuItemWidget(
//                               item: bottomMenuItems[i],
//                               onTap: () => Navigator.pop(context),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// /// Custom drawer wrapper to control animation timing
// class SlowDrawerAnimation extends StatelessWidget {
//   final Widget child;

//   const SlowDrawerAnimation({super.key, required this.child});

//   @override
//   Widget build(BuildContext context) {
//     return child;
//   }
// }

// /* ===================== DATA CLASSES ===================== */
// class MenuItemData {
//   final String label;
//   final IconData? icon;
//   MenuItemData({required this.label, this.icon});
// }

// class CategoryItem {
//   final String label;
//   final IconData icon;
//   CategoryItem({required this.label, required this.icon});
// }

// class PopularListItem {
//   final String label;
//   PopularListItem({required this.label});
// }

// /* ===================== WIDGETS ===================== */

// // Menu Item Widget (Used for Top & Bottom Menus)
// class MenuItemWidget extends StatelessWidget {
//   final MenuItemData item;
//   final VoidCallback onTap;

//   const MenuItemWidget({super.key, required this.item, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 14),
//         child: Row(
//           children: [
//             if (item.icon != null)
//               Icon(item.icon, size: 24, color: Colors.white),
//             const SizedBox(width: 16),
//             Text(
//               item.label,
//               style: const TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Category Item Widget (Simple - No Dropdown)
// class CategoryExpandableItem extends StatelessWidget {
//   final CategoryItem category;

//   const CategoryExpandableItem({super.key, required this.category});

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Navigator.pop(context);
//       },
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 12),
//         child: Row(
//           children: [
//             Icon(category.icon, size: 24, color: Colors.black54),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Text(
//                 category.label,
//                 style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.black87,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Popular List Item Widget
// class PopularListItemWidget extends StatelessWidget {
//   final PopularListItem item;

//   const PopularListItemWidget({super.key, required this.item});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: GestureDetector(
//         onTap: () => Navigator.pop(context),
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//           decoration: BoxDecoration(
//             border: Border.all(color: const Color(0xFFE0E0E0)),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Text(
//                   item.label,
//                   style: const TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w500,
//                     color: Color(0xFF666666),
//                   ),
//                 ),
//               ),
//               const Icon(
//                 Icons.chevron_right,
//                 size: 20,
//                 color: Color(0xFFCCCCCC),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

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
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(1),
          bottomLeft: Radius.circular(1),
        ),
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              // HEADER
              Container(
                color: const Color(0xFF2196F3),
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
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
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
      color: const Color(0xFF2196F3),
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
              color: Color(0xFF999999),
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
              Icon(item.icon, size: 24, color: Colors.white),
            if (item.icon != null) const SizedBox(width: 16),
            Text(
              item.label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,
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
                  color: Colors.black87,
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
                    color: Color(0xFF666666),
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right,
                size: 20,
                color: Color(0xFFCCCCCC),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
