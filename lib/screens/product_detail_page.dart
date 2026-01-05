import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class ProductDetailPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailPage({required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late PageController _pageController;
  late ScrollController _thumbScrollController;

  int _currentPage = 0;
  String selectedColor = 'Gold';
  String selectedStorage = '512GB - 8GB RAM';

  final List<IconData> carouselIcons = [
    Icons.laptop, // 👈 STATIC FIRST (featured)
    Icons.phone_android, // 👈 dynamic
    Icons.tablet_mac,
    Icons.desktop_windows,
    Icons.watch,
    Icons.headset,
  ];

  // Widget _thumbnailItem(int index) {
  //   return GestureDetector(
  //     onTap: () {
  //       _pageController.animateToPage(
  //         index,
  //         duration: const Duration(milliseconds: 300),
  //         curve: Curves.easeInOut,
  //       );
  //     },
  //     child: Container(
  //       width: 60,
  //       height: 60,
  //       decoration: BoxDecoration(
  //         border: Border.all(
  //           color: _currentPage == index ? Colors.blue : Colors.grey[300]!,
  //           width: 2,
  //         ),
  //         borderRadius: BorderRadius.circular(8),
  //         color: Colors.grey[100],
  //       ),
  //       child: Icon(Icons.laptop, size: 36, color: Colors.grey[400]),
  //     ),
  //   );
  // }

  Widget _thumbnailItem(int index) {
    return GestureDetector(
      onTap: () {
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(
            color: _currentPage == index ? Colors.blue : Colors.grey[300]!,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[100],
        ),
        child: Icon(
          carouselIcons[index], // 🔥 SAME SOURCE
          size: 26,
          color: Colors.grey[400],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _thumbScrollController = ScrollController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _thumbScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// PRODUCT IMAGE + THUMBNAILS ROW
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 300, // total height same as carousel
                child: Row(
                  children: [
                    /// MAIN CAROUSEL (LEFT)
                    Expanded(
                      child: Stack(
                        children: [
                          PageView(
                            controller: _pageController,
                            onPageChanged: (index) {
                              setState(() {
                                _currentPage = index;
                              });

                              _thumbScrollController.animateTo(
                                index * 25.0, // 60 height + 10 gap
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },

                            children: carouselIcons.map((icon) {
                              return Container(
                                color: Colors.grey[100],
                                child: Icon(
                                  icon,
                                  size: 140,
                                  color: Colors.grey[400],
                                ),
                              );
                            }).toList(),
                          ),

                          /// PAGE INDICATOR
                          Positioned(
                            bottom: 12,
                            right: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[600],
                                borderRadius: BorderRadius.circular(20),
                              ),

                              child: Text(
                                '${_currentPage + 1} / ${carouselIcons.length}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 12),

                    /// THUMBNAILS (RIGHT)
                    SizedBox(
                      width: 50, // thumbnail column width
                      child: ListView.builder(
                        controller: _thumbScrollController,

                        physics: const BouncingScrollPhysics(),
                        itemCount: carouselIcons.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: _thumbnailItem(index),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// PRODUCT DETAILS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// PRODUCT NAME
                  const Text(
                    'HP Laptop EQ2180AU 15.6 Inches\nAMD Ryzen 5 (8GB RAM - 512GBSSD)',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// RATING & REVIEW
                  Row(
                    children: [
                      Row(
                        children: [
                          ...List.generate(
                            5,
                            (index) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        '5.0 | 1 Review',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  /// PRICE SECTION
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// LEFT: Rs
                          // const Text(
                          //   'Rs',
                          //   style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 97, 97, 97)),
                          // ),
                          const SizedBox(width: 8),

                          /// CENTER: Old price + discount
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // -------- First Row: Rs + Final Price --------
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    'Rs',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 97, 97, 97),
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    '194,999',
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 4),

                              // -------- Second Row: Old Price + Discount Badge --------
                              Padding(
                                padding: const EdgeInsets.only(left: 28.0),
                                child: Row(
                                  children: [
                                    Text(
                                      '219,999',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[400],
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.blue[50],
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: const Text(
                                        '11% OFF',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(width: 12),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  /// COLORS SECTION
                  const Text(
                    'Colors',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildColorOption('Gold'),
                        const SizedBox(width: 12),
                        _buildColorOption('Silver'),
                        const SizedBox(width: 12),
                        _buildColorOption('Black'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// STORAGE SECTION
                  const Text(
                    'Storage',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 12),

                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _buildStorageOption('512GB - 8GB RAM'),
                      _buildStorageOption('256GB - 8GB RAM'),
                      _buildStorageOption('512GB - 16GB RAM'),
                    ],
                  ),

                  const SizedBox(height: 24),

                  /// DESCRIPTION
                  const Text(
                    'Description',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'HP 15 (EQ2180AU) is a compact, powerful, and reliable laptop designed to meet the needs of professionals. '
                    'With its AMD Ryzen 5 processor, 8GB RAM, and 512GB SSD, it offers exceptional performance for everyday computing tasks.',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[700],
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // --- Specification Highlights (tag-based data) ---
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 0),
            //   child: SpecificationHighlights(
            //     tags: [
            //       {
            //         'icon': Icons.laptop,
            //         'title': '15.6',
            //         'description': 'Display',
            //       },
            //       {
            //         'icon': Icons.memory,
            //         'title': '512 GB',
            //         'description': 'Internal Memory',
            //       },
            //       {
            //         'icon': Icons.computer,
            //         'title': '5500 U',
            //         'description': 'Processor',
            //       },
            //       {
            //         'icon': Icons.developer_board,
            //         'title': 'AMD',
            //         'description': 'Generation',
            //       },
            //     ],
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: SizedBox(
                width: double.infinity, // 👈 100% screen width
                child: SpecificationHighlights(
                  tags: [
                    {
                      'icon': Icons.laptop,
                      'title': '15.6',
                      'description': 'Display',
                    },
                    {
                      'icon': Icons.memory,
                      'title': '512 GB',
                      'description': 'Internal Memory',
                    },
                    {
                      'icon': Icons.computer,
                      'title': '5500 U',
                      'description': 'Processor',
                    },
                    {
                      'icon': Icons.developer_board,
                      'title': 'AMD',
                      'description': 'Generation',
                    },
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // --- Specification Details (tag-based sections + rows) ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SpecificationDetails(
                sections: [
                  {
                    'title': 'General Features',
                    'rows': [
                      {'key': 'Dimensions', 'value': 'N/A'},
                      {'key': 'Weight', 'value': '1.69 kg'},
                      {
                        'key': 'Operating System',
                        'value': 'Genuine Windows 11 Home',
                      },
                      {'key': 'Generation', 'value': 'AMD'},
                    ],
                  },
                  {
                    'title': 'Display',
                    'rows': [
                      {'key': 'Screen Size', 'value': '15.6'},
                      {'key': 'Screen Resolution', 'value': '1920x1080'},
                      {'key': 'Touch Screen', 'value': 'No'},
                      {'key': 'Backlit Keyboard', 'value': 'N/A'},
                    ],
                  },
                  {
                    'title': 'Memory',
                    'rows': [
                      {'key': 'Internal Memory', 'value': '512 GB'},
                      {'key': 'RAM', 'value': '8 GB'},
                      {
                        'key': 'Graphics Memory',
                        'value': 'AMD Radeon™ Graphics',
                      },
                    ],
                  },
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// SIMILAR PRODUCTS
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50], // light blue background
                borderRadius: BorderRadius.circular(2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Similar Products",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 12),

                  ProductDisplayWidget(
                    cars: [
                      {
                        'name': 'BMW M4 Series',
                        'price': '\$155,000',
                        'rating': 4.5,
                        'status': 'New',
                        'image': Icons.directions_car,
                        'color': Colors.grey,
                      },
                      {
                        'name': 'Camaro Sports',
                        'price': '\$170,000',
                        'rating': 4.7,
                        'status': 'New',
                        'image': Icons.directions_car,
                        'color': Colors.amber,
                      },
                      {
                        'name': 'Audi Sports',
                        'price': '\$133,000',
                        'rating': 4.1,
                        'status': 'Used',
                        'image': Icons.directions_car,
                        'color': Colors.red,
                      },
                      {
                        'name': 'Audi Sports',
                        'price': '\$133,000',
                        'rating': 4.1,
                        'status': 'Used',
                        'image': Icons.directions_car,
                        'color': Colors.red,
                      },
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 56,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Add to Cart',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildColorOption(String color) {
    bool isSelected = selectedColor == color;
    Color colorValue;

    switch (color) {
      case 'Gold':
        colorValue = const Color(0xFFD4AF37);
        break;
      case 'Silver':
        colorValue = const Color(0xFFC0C0C0);
        break;
      case 'Black':
        colorValue = Colors.black;
        break;
      default:
        colorValue = Colors.grey;
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color;
        });
      },
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? Colors.blue : Colors.grey[300]!,
                width: isSelected ? 3 : 1,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: colorValue,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            color,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildStorageOption(String storage) {
    bool isSelected = selectedStorage == storage;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedStorage = storage;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[50] : Colors.transparent,
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          storage,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            color: isSelected ? Colors.blue : Colors.black,
          ),
        ),
      ),
    );
  }
}
