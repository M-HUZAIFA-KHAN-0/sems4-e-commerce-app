import 'package:first/screens/add_to_card_page.dart';
import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import 'comparison_page.dart';

class ProductDetailPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late PageController _pageController;
  late ScrollController _thumbScrollController;
  final GlobalKey _specDetailsKey = GlobalKey();
  final GlobalKey _reviewsKey = GlobalKey();
  late ScrollController _scrollController;

  int _currentPage = 0;
  String selectedColor = 'Gold';
  String selectedStorage = '512GB - 8GB RAM';
  int selectedQuantity = 1;
  late int availableStock = 15;
  bool _stockLimitReached = false;

  final List<IconData> carouselIcons = [
    Icons.laptop, // 👈 STATIC FIRST (featured)
    Icons.phone_android, // 👈 dynamic
    Icons.tablet_mac,
    Icons.desktop_windows,
    Icons.watch,
    Icons.headset,
  ];

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
    _scrollController = ScrollController();
    // Initialize stock from product map (single source). Default to 5 if not provided.
    availableStock = (widget.product['stock'] is int)
        ? widget.product['stock'] as int
        : 5;
    if (availableStock < 1) {
      _stockLimitReached = true;
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _thumbScrollController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brandImages = <ImageProvider>[
      const AssetImage("../assets/brands/lenovo.png"),
      const AssetImage("../assets/brands/dell.png"),
      const AssetImage("../assets/brands/hp.png"),
      // const AssetImage("assets/brands/apple.png"),
      // const AssetImage("assets/brands/acer.png"),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Product Details',
          style: TextStyle(color: Colors.black),
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
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// PRODUCT IMAGE + THUMBNAILS ROW
            Padding(
              // padding: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
              child: SizedBox(
                height: 250, // total height same as carousel
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

            // const SizedBox(height: 16),

            /// PRODUCT DETAILS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductStatsRow(views: 12345, purchases: 245),
                  const SizedBox(height: 8),

                  /// PRODUCT NAME
                  const Text(
                    'HP Laptop EQ2180AU 15.6 Inches\nAMD Ryzen 5 (8GB RAM - 512GBSSD)',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 8),

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

                  const SizedBox(height: 10),

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

                  /// STORAGE SECTION
                  const Text(
                    'Storage',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

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

                  /// COLORS SECTION
                  const Text(
                    'Colors',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

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

                  // --- Quantity selector ---
                  const Text(
                    'Quantity',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      Container(
                        height: 44,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(
                                minWidth: 28,
                                minHeight: 28,
                              ),
                              icon: const Icon(Icons.remove, size: 20),
                              onPressed: () {
                                setState(() {
                                  if (selectedQuantity > 1) {
                                    selectedQuantity -= 1;
                                    // If we dropped below stock limit, clear the flag
                                    if (selectedQuantity < availableStock) {
                                      _stockLimitReached = false;
                                    }
                                  }
                                });
                              },
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Text(
                                selectedQuantity.toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(
                                minWidth: 28,
                                minHeight: 28,
                              ),
                              icon: const Icon(Icons.add, size: 20),
                              onPressed: () {
                                setState(() {
                                  if (selectedQuantity < availableStock) {
                                    selectedQuantity += 1;
                                    _stockLimitReached = false;
                                  } else {
                                    // reached limit, show message
                                    _stockLimitReached = true;
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 12),
                      Text(
                        _stockLimitReached ? 'Stock not available' : '',
                        style: TextStyle(
                          color: _stockLimitReached
                              ? Colors.red
                              : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  /// DESCRIPTION
                  const Text(
                    'Description',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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

            const SizedBox(height: 28),

            Padding(
              key: _specDetailsKey,
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
              // key: _specDetailsKey,
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

            // Container(
            //   child: Column(
            //     children: [
            //       ShopMoreCategoriesWidget(
            //         title: "Shop More Categories",
            //         items: const [
            //           ShopCategoryCardData(
            //             image: AssetImage("../assets/brands/dell.png"),
            //             title: "Wireless\nEarbuds",
            //           ),
            //           ShopCategoryCardData(
            //             image: AssetImage("../assets/brands/dell.png"),
            //             title: "Smart\nWatches",
            //           ),
            //           ShopCategoryCardData(
            //             image: AssetImage("../assets/brands/dell.png"),
            //             title: "Bluetooth\nSpeakers",
            //           ),
            //           ShopCategoryCardData(
            //             image: AssetImage("../assets/brands/dell.png"),
            //             title: "Tablets",
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),

            CategoryViewCard(),

            const SizedBox(height: 24),

            // Container(
            //   child: Column(
            //     children: [
            //       ProductReview(
            //         name: "John Doe",
            //         rating: 5,
            //         verified: true,
            //         date: "June 10, 2023",
            //         text:
            //             "Amazing laptop with great performance. Highly recommend for professionals and students alike!",
            //         images: [
            //           "assets/review1.jpg",
            //           "assets/review2.jpg",
            //           "assets/review3.jpg",
            //           "assets/review3.jpg",
            //           "assets/review3.jpg",
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            // Reviews section
            Container(
              child: Padding(
                key: _reviewsKey,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Reviews',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ProductReview(
                      name: 'Sharjeel Atiq',
                      rating: 5,
                      date: '04 Jun 2025',
                      text:
                          'been 7 days using the product. It was indeed brand new and I am 100% satisfied with this huge purchase.',
                      images: [
                        "../assets/brands/dell.png",
                        "../assets/brands/dell.png",
                        "../assets/brands/dell.png",
                        "../assets/brands/dell.png",
                        "../assets/brands/dell.png",
                      ],
                    ),
                    const SizedBox(height: 16),
                    ProductReview(
                      name: 'Hammad Mian',
                      rating: 5,
                      date: '14 Oct 2025',
                      text: 'Good',
                      images: [
                        "../assets/brands/dell.png",
                        "../assets/brands/dell.png",
                      ],
                    ),
                  ],
                ),
              ),
            ),

            //           const SizedBox(height: 24, child: DecoratedBox(
            //   decoration: BoxDecoration(color: Color.fromARGB(255, 180, 180, 180)),
            // ),),
            Container(
              height: 20,
              color: const Color.fromARGB(255, 233, 233, 233),
            ),
            const SizedBox(height: 24),

            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      "Shop By Brand",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  BrandImageSlider(
                    images: brandImages,
                    height: 165,
                    itemWidth:
                        195, // keeps the “next tile partially visible” feel
                    borderRadius: 20,
                    horizontalPadding: 24,
                    itemSpacing: 18,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
        child: SafeArea(
          top: false,
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () async {
                    // Scroll to specification details
                    if (_specDetailsKey.currentContext != null) {
                      await Scrollable.ensureVisible(
                        _specDetailsKey.currentContext!,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.list_alt, color: Colors.black),
                      const SizedBox(height: 6),
                      Text(
                        'Specs',
                        style: TextStyle(color: Colors.grey[800], fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: InkWell(
                  onTap: () async {
                    if (_reviewsKey.currentContext != null) {
                      await Scrollable.ensureVisible(
                        _reviewsKey.currentContext!,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star_border, color: Colors.black),
                      const SizedBox(height: 6),
                      Text(
                        'Review',
                        style: TextStyle(color: Colors.grey[800], fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ComparisonPage(currentProduct: widget.product),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.compare_arrows, color: Colors.black),
                      const SizedBox(height: 6),
                      Text(
                        'Compare',
                        style: TextStyle(color: Colors.grey[800], fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 8),

              SizedBox(
                width: 150,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartPageExample(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Add to Cart',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF7941D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
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
            width: 45,
            height: 45,

            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? Colors.blue : Colors.grey[300]!,
                width: isSelected ? 3 : 1,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Container(
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: colorValue,
                borderRadius: BorderRadius.circular(50),
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
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[50] : Colors.transparent,
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey[300]!,
            width: isSelected ? 2 : 2,
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
