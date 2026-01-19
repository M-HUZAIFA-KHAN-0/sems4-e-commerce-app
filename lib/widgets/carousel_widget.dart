// import 'package:flutter/material.dart';

// class CarouselWidget extends StatefulWidget {
//   const CarouselWidget({super.key});

//   @override
//   State<CarouselWidget> createState() => _CarouselWidgetState();
// }

// class _CarouselWidgetState extends State<CarouselWidget> {
//   late PageController _pageController;
//   int _currentPage = 0;
//   final int _numSlides = 3;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(initialPage: 0);
//     _startAutoScroll();
//   }

//   void _startAutoScroll() {
//     Future.delayed(const Duration(seconds: 3), () {
//       if (_pageController.hasClients && mounted) {
//         _currentPage = (_currentPage + 1) % _numSlides;
//         _pageController.animateToPage(
//           _currentPage,
//           duration: const Duration(milliseconds: 500),
//           curve: Curves.easeInOut,
//         );
//         _startAutoScroll();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 135,
//       child: PageView(
//         controller: _pageController,
//         onPageChanged: (index) {
//           setState(() {
//             _currentPage = index;
//           });
//         },
//         children: const [
//           DealCard(
//             percent: '20%',
//             title: 'Week Deals!',
//             desc: 'Get a new car discount\nonly valid this week',
//             icon: Icons.directions_car,
//           ),
//           DealCard(
//             percent: '30%',
//             title: 'Hot Offer!',
//             desc: 'Limited time SUV offers\nhurry up now',
//             icon: Icons.car_rental,
//           ),
//           DealCard(
//             percent: '15%',
//             title: 'Special Discount',
//             desc: 'Best price for new models\nthis weekend',
//             icon: Icons.electric_car,
//           ),
//         ],
//       ),
//     );
//   }
// }

// /// Individual Deal Card widget used in carousel
// class DealCard extends StatelessWidget {
//   final String percent;
//   final String title;
//   final String desc;
//   final IconData icon;

//   const DealCard({super.key,
//     required this.percent,
//     required this.title,
//     required this.desc,
//     required this.icon,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.grey[200],
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   percent,
//                   style: const TextStyle(
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   desc,
//                   maxLines: 2,
//                   style: const TextStyle(fontSize: 12, color: Colors.black54),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Container(
//               height: 100,
//               decoration: BoxDecoration(
//                 color: Colors.grey[300],
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Icon(icon, size: 60),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


























// import 'package:flutter/material.dart';

// class CarouselWidget extends StatefulWidget {
//   const CarouselWidget({super.key});

//   @override
//   State<CarouselWidget> createState() => _CarouselWidgetState();
// }

// class _CarouselWidgetState extends State<CarouselWidget> {
//   late PageController _pageController;
//   int _currentPage = 0;
//   final int _numSlides = 3;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(initialPage: 0);
//     _startAutoScroll();
//   }

//   void _startAutoScroll() {
//     Future.delayed(const Duration(seconds: 3), () {
//       if (!mounted || !_pageController.hasClients) return;
//       _currentPage = (_currentPage + 1) % _numSlides;
//       _pageController.animateToPage(
//         _currentPage,
//         duration: const Duration(milliseconds: 500),
//         curve: Curves.easeInOut,
//       );
//       _startAutoScroll();
//     });
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // ✅ fixed height to avoid bottom overflow
//     return SizedBox(
//       height: 135, 
//       child: PageView(
//         controller: _pageController,
//         onPageChanged: (index) {
//           setState(() => _currentPage = index);
//         },
//         children: const [
//           DealCard(
//             percent: '20%',
//             title: 'Week Deals!',
//             desc: 'Get a new car discount\nonly valid this week',
//             icon: Icons.directions_car,
//           ),
//           DealCard(
//             percent: '30%',
//             title: 'Hot Offer!',
//             desc: 'Limited time SUV offers\nhurry up now',
//             icon: Icons.car_rental,
//           ),
//           DealCard(
//             percent: '15%',
//             title: 'Special Discount',
//             desc: 'Best price for new models\nthis weekend',
//             icon: Icons.electric_car,
//           ),
//         ],
//       ),
//     );
//   }
// }

// /// Individual Deal Card widget
// class DealCard extends StatelessWidget {
//   final String percent;
//   final String title;
//   final String desc;
//   final IconData icon;

//   const DealCard({
//     super.key,
//     required this.percent,
//     required this.title,
//     required this.desc,
//     required this.icon,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(8), // ✅ reduce padding slightly
//       decoration: BoxDecoration(
//         color: Colors.grey[200],
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           /// LEFT TEXT
//           Expanded(
//             flex: 3,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center, // ✅ center vertically
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 FittedBox(
//                   fit: BoxFit.scaleDown, // ✅ text scales to fit
//                   child: Text(
//                     percent,
//                     style: const TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Flexible(
//                   child: Text(
//                     title,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Flexible(
//                   child: Text(
//                     desc,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(fontSize: 10, color: Colors.black54),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(width: 6),

//           /// RIGHT ICON
//           Expanded(
//             flex: 2,
//             child: Center(
//               child: AspectRatio(
//                 aspectRatio: 1,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.grey[300],
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Icon(icon, size: 40), // ✅ smaller icon fits well
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }










































import 'package:flutter/material.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({super.key});

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  late PageController _pageController;
  int _currentPage = 0;
  final int _numSlides = 3;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _startAutoScroll();
  }

  void _startAutoScroll() {
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted || !_pageController.hasClients) return;
      _currentPage = (_currentPage + 1) % _numSlides;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      _startAutoScroll();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 135, // ✅ fixed height to prevent overflow
      child: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _currentPage = index);
        },
        children: const [
          DealCard(
            percent: '20%',
            title: 'Week Deals!',
            desc: 'Get a new car discount\nonly valid this week',
            imgUrl: 'https://picsum.photos/200?3',
          ),
          DealCard(
            percent: '30%',
            title: 'Hot Offer!',
            desc: 'Limited time SUV offers\nhurry up now',
            imgUrl: 'https://picsum.photos/200?3',
          ),
          DealCard(
            percent: '15%',
            title: 'Special Discount',
            desc: 'Best price for new models\nthis weekend',
            imgUrl: 'https://picsum.photos/200?3',
          ),
        ],
      ),
    );
  }
}

/// Individual Deal Card widget with image on right
class DealCard extends StatelessWidget {
  final String percent;
  final String title;
  final String desc;
  final String imgUrl;

  const DealCard({
    super.key,
    required this.percent,
    required this.title,
    required this.desc,
    required this.imgUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 6),
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          /// LEFT TEXT
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // vertically center
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    percent,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                Flexible(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                Flexible(
                  child: Text(
                    desc,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 10, color: Colors.black54, height: 1.1),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 6),

          /// RIGHT IMAGE
          Expanded(
            flex: 2,
            child: AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imgUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.image_not_supported,
                        size: 40,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
