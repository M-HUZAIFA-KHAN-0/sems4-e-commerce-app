import 'package:first/core/app_imports.dart';
// import 'package:first/models/product_detail_model.dart';
// import 'package:first/services/api/product_service.dart';
// import 'package:first/services/user_session_manager.dart';
// import 'package:first/widgets/add_to_cart_confirmation_drawer.dart';
import 'package:first/widgets/wishlist_button.dart';

class ProductDetailPage extends StatefulWidget {
  /// Constructor can accept either productId OR product map (for backward compatibility)
  final int? productId;
  final Map<String, dynamic>? product;

  const ProductDetailPage({super.key, this.productId, this.product})
    : assert(
        productId != null || product != null,
        'Either productId or product must be provided',
      );

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late PageController _pageController;
  late ScrollController _thumbScrollController;
  final GlobalKey _specDetailsKey = GlobalKey();
  final GlobalKey _reviewsKey = GlobalKey();
  late ScrollController _scrollController;

  // API Service
  final ProductService _productService = ProductService();

  // Product Data
  ProductDetailModel? _productDetail;
  bool _isLoading = true;
  String? _errorMessage;

  // UI State
  int _currentPage = 0;
  String selectedColor = '';
  String selectedStorage = '';
  int selectedQuantity = 1;
  late int availableStock = 15;
  bool _stockLimitReached = false;
  ProductVariant? _selectedVariant;
  // Mapping of formatted storage ("RAM - Storage") to variant for quick lookup
  late final Map<String, ProductVariant> _storageToVariantMap = {};

  // Placeholder carousel (for backward compatibility with map-based products)
  final List<IconData> carouselIcons = [
    Icons.laptop,
    Icons.phone_android,
    Icons.tablet_mac,
    Icons.desktop_windows,
    Icons.watch,
    Icons.headset,
  ];

  // ************************************************************
  // *********************** Product Detail *********************
  // ************************************************************

  /// Load product details from API based on productId
  Future<void> _loadProductDetail() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      // Get productId - either from parameter or parse from map
      int? productId = widget.productId;
      if (productId == null && widget.product != null) {
        productId = widget.product!['productId'] as int?;
      }

      if (productId == null) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Invalid product ID';
        });
        return;
      }

      // Log the product view (fire and forget)
      if (UserSessionManager().isLoggedIn) {
        final userId = UserSessionManager().userId;
        _productService.logProductView(productId: productId, userId: userId);
      }

      // Fetch product detail from API
      final product = await _productService.fetchProductDetailById(productId);

      if (product == null) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Product not found';
        });
        return;
      }

      setState(() {
        _productDetail = product;
        _isLoading = false;

        // Build mapping of storage combinations to variants
        _buildStorageToVariantMap();

        // Auto-select cheapest variant and its first storage combination
        final cheapestVariant = product.getCheapestVariant();
        if (cheapestVariant != null) {
          _selectedVariant = cheapestVariant;
          availableStock = cheapestVariant.stock;
          selectedQuantity = 1;
          _stockLimitReached = availableStock < 1;

          // Select first storage combination for cheapest variant
          final storageOptions = _getStorageCombinationsForVariant(
            cheapestVariant,
          );
          if (storageOptions.isNotEmpty) {
            selectedStorage = storageOptions.first;
          }

          final availableColorsForVariant = _getColorsForVariant(
            cheapestVariant,
          );
          if (availableColorsForVariant.isNotEmpty) {
            selectedColor = availableColorsForVariant.first;
          }
        }
      });
    } catch (e) {
      print('Error loading product: $e');
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error loading product: $e';
      });
    }
  }

  /// Get specifications mapped to UI fields
  /// Maps API specifications to only those visible in UI design
  Map<String, String> _getMappedSpecifications() {
    if (_productDetail == null) return {};

    // UI SPEC FIELDS (locked design)
    const uiSpecFields = {
      'Dimensions': 'Dimensions',
      'Weight': 'Weight',
      'OS': 'Operating System',
      'CPU': 'Generation',
      'Display': 'Screen Size',
      'Storage': 'Internal Memory',
      'RAM': 'RAM',
      'GPU': 'Graphics Memory',
    };

    final mappedSpecs = <String, String>{};

    // Extract only specs that exist in both API and UI
    for (var spec in _productDetail!.specifications) {
      if (uiSpecFields.containsKey(spec.specificationName)) {
        mappedSpecs[uiSpecFields[spec.specificationName]!] = spec
            .getDisplayValue();
      }
    }

    return mappedSpecs;
  }

  /// Find variant matching the formatted storage string (RAM - Storage) using pre-built map
  ProductVariant? _findVariantByFormattedStorage(String formattedStorage) {
    return _storageToVariantMap[formattedStorage];
  }

  /// Get available variants based on selected storage and color
  /// Used for dynamic filtering of color/storage options
  List<ProductVariant> _getAvailableVariants({
    String? forStorage,
    String? forColor,
  }) {
    if (_productDetail == null) return [];

    return _productDetail!.variants.where((variant) {
      // Filter by storage if specified - match formatted storage string
      if (forStorage != null) {
        final variantStorage = _formatStorageFromVariant(variant);
        if (variantStorage != forStorage) return false;
      }

      // Filter by color if specified - check variantSpecifications
      if (forColor != null) {
        final hasColor = variant.variantSpecifications.any(
          (spec) =>
              spec['specificationName'] == 'Color' &&
              spec['optionValue'] == forColor,
        );
        if (!hasColor) return false;
      }

      return true;
    }).toList();
  }

  /// Update stock and UI when storage is selected
  void _updateVariantSelection({String? newStorage, String? newColor}) {
    if (_productDetail == null) return;

    setState(() {
      // If storage changed, find the matching variant
      if (newStorage != null) {
        final variant = _findVariantByFormattedStorage(newStorage);
        if (variant != null) {
          _selectedVariant = variant;
          selectedStorage = newStorage;
          availableStock = variant.stock;
          selectedQuantity = 1;
          _stockLimitReached = availableStock < 1;

          // Update color to first available color for this variant
          final availableColorsForVariant = _getColorsForVariant(variant);
          if (availableColorsForVariant.isNotEmpty) {
            selectedColor = availableColorsForVariant.first;
          }
        }
      }
      // If only color changed within same storage
      else if (newColor != null && newColor != selectedColor) {
        // Verify color exists in current variant
        if (_selectedVariant != null) {
          final hasColor = _selectedVariant!.variantSpecifications.any(
            (spec) =>
                spec['specificationName'] == 'Color' &&
                spec['optionValue'] == newColor,
          );
          if (hasColor) {
            selectedColor = newColor;
          }
        }
      }
    });
  }

  /// Build mapping of all storage combinations ("RAM - Storage") to variants
  void _buildStorageToVariantMap() {
    _storageToVariantMap.clear();
    if (_productDetail == null) return;

    for (var variant in _productDetail!.variants) {
      final combinations = _getStorageCombinationsForVariant(variant);
      for (var combination in combinations) {
        _storageToVariantMap[combination] = variant;
      }
    }
  }

  /// Get all RAM × Storage combinations for a variant
  /// For Variant 2 with RAM: [16GB, 8GB] and Storage: [256GB, 512GB]
  /// Returns: ["16GB - 256GB", "16GB - 512GB", "8GB - 256GB", "8GB - 512GB"]
  List<String> _getStorageCombinationsForVariant(ProductVariant variant) {
    final ramOptions = <String>{};
    final storageOptions = <String>{};

    // Extract all unique RAM and Storage options
    for (var spec in variant.variantSpecifications) {
      if (spec['specificationName'] == 'RAM') {
        final ramValue = spec['optionValue'];
        if (ramValue != null && ramValue is String) {
          ramOptions.add(ramValue);
        }
      } else if (spec['specificationName'] == 'Storage') {
        final storageValue = spec['optionValue'];
        if (storageValue != null && storageValue is String) {
          storageOptions.add(storageValue);
        }
      }
    }

    // Create Cartesian product: each RAM × each Storage
    final combinations = <String>[];
    for (var ram in ramOptions) {
      for (var storage in storageOptions) {
        combinations.add('$ram - $storage');
      }
    }

    return combinations;
  }

  /// Extract storage and RAM from variant and format as "RAM - Storage"
  String _formatStorageFromVariant(ProductVariant variant) {
    String? ram;
    String? storage;

    for (var spec in variant.variantSpecifications) {
      if (spec['specificationName'] == 'RAM') {
        ram = spec['optionValue'] as String?;
      } else if (spec['specificationName'] == 'Storage') {
        storage = spec['optionValue'] as String?;
      }
    }

    if (ram != null && storage != null) {
      return '$ram - $storage';
    }
    return variant.sku;
  }

  /// Get colors available for a specific variant
  List<String> _getColorsForVariant(ProductVariant variant) {
    final colorList = <String>[];

    for (var spec in variant.variantSpecifications) {
      if (spec['specificationName'] == 'Color') {
        final colorValue = spec['optionValue'];
        if (colorValue != null && colorValue is String) {
          colorList.add(colorValue);
        }
      }
    }

    return colorList;
  }

  /// Get all unique storage combinations (RAM × Storage) across all variants
  List<String> _getAvailableStorageOptions() {
    if (_productDetail == null) return [];

    final storageOptions = <String>[];

    for (var variant in _productDetail!.variants) {
      final combinations = _getStorageCombinationsForVariant(variant);
      storageOptions.addAll(combinations);
    }

    print('DEBUG FINAL STORAGE OPTIONS: $storageOptions');
    return storageOptions;
  }

  /// Get all unique colors from product variants
  List<String> _getAvailableColors() {
    if (_productDetail == null) return [];

    final colorSet = <String>{};

    // Extract colors from variantSpecifications
    for (var variant in _productDetail!.variants) {
      for (var spec in variant.variantSpecifications) {
        if (spec['specificationName'] == 'Color') {
          final colorValue = spec['optionValue'];
          if (colorValue != null && colorValue is String) {
            colorSet.add(colorValue);
            print('DEBUG FOUND COLOR: $colorValue'); // DEBUG
          }
        }
      }
    }

    print('DEBUG FINAL COLORS: ${colorSet.toList()}'); // DEBUG
    return colorSet.toList();
  }

  Widget _thumbnailItem(int index) {
    // Build thumbnail from product gallery images if available
    final imageUrl = _productDetail?.galleryImages.isNotEmpty == true
        ? _productDetail!.galleryImages[index %
              _productDetail!.galleryImages.length]
        : _productDetail?.coverImage;

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
            color: _currentPage == index
                ? Colors.blue
                : AppColors.backgroundGreyLight,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
          color: AppColors.backgroundGreyLighter,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: imageUrl != null
              ? Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    // Placeholder if image fails
                    return Icon(
                      Icons.laptop,
                      size: 26,
                      color: Colors.grey[400],
                    );
                  },
                )
              : Icon(
                  carouselIcons[index % carouselIcons.length],
                  size: 26,
                  color: Colors.grey[400],
                ),
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

    // Load product detail from API
    _loadProductDetail();
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
    ];

    // ***************************************************
    // ***************** Product Detail ******************
    // ***************************************************

    // Show loading indicator while fetching data
    if (_isLoading) {
      return Scaffold(
        backgroundColor: AppColors.backgroundWhite,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundWhite,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Product Details',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    // Show error message if product failed to load
    if (_errorMessage != null) {
      return Scaffold(
        backgroundColor: AppColors.backgroundWhite,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundWhite,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Product Details',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: $_errorMessage'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadProductDetail,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    // If product detail loaded successfully
    if (_productDetail == null) {
      return Scaffold(
        backgroundColor: AppColors.backgroundWhite,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundWhite,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: const Center(child: Text('Product not found')),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Product Details',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          // Wishlist button - only show if user is logged in
          if (UserSessionManager().isLoggedIn &&
              UserSessionManager().wishlistId != null &&
              _selectedVariant != null)
            WishlistButton(
              wishlistId: UserSessionManager().wishlistId!,
              variantId: _selectedVariant!.variantId,
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
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
              child: SizedBox(
                height: 240,
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
                                index * 25.0,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            children: _buildCarouselPages(),
                          ),

                          /// PAGE INDICATOR
                          Positioned(
                            bottom: 6,
                            right: 6,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                gradient: AppColors.bgGradient,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '${_currentPage + 1} / ${_getCarouselLength()}',
                                style: const TextStyle(
                                  color: AppColors.backgroundWhite,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 8),

                    /// THUMBNAILS (RIGHT)
                    SizedBox(
                      width: 50,
                      child: ListView.builder(
                        controller: _thumbScrollController,
                        physics: const BouncingScrollPhysics(),
                        itemCount: _getCarouselLength(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: _thumbnailItem(index),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// PRODUCT DETAILS SECTION
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductStatsRow(views: 12345, purchases: 245),
                  const SizedBox(height: 8),

                  /// PRODUCT NAME
                  Text(
                    _productDetail!.productName,
                    style: const TextStyle(
                      fontSize: 16,
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
                      Text(
                        '${_productDetail!.averageRating} | Reviews',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  /// PRICE SECTION (FROM CHEAPEST VARIANT)
                  _buildPriceSection(),

                  const SizedBox(height: 24),

                  /// STORAGE SECTION
                  _buildStorageSection(),

                  const SizedBox(height: 24),

                  /// COLORS SECTION
                  _buildColorsSection(),

                  const SizedBox(height: 24),

                  /// QUANTITY SECTION
                  const Text(
                    'Quantity',
                    style: TextStyle(
                      fontSize: FontSize.homePageTitle,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondaryColor1,
                    ),
                  ),

                  const SizedBox(height: 8),

                  _buildQuantitySection(),

                  const SizedBox(height: 24),

                  /// DESCRIPTION
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: FontSize.homePageTitle,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondaryColor1,
                    ),
                  ),

                  const SizedBox(height: 12),

                  ExpandableText(text: _productDetail!.description),
                  const SizedBox(height: 24),
                ],
              ),
            ),

            const SizedBox(height: 8),

            BGColorProdDisplayCard(
              heading: "Similar Products",
              prodItems: [
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

            /// SIMILAR PRODUCTS
            // Container(
            //   width: double.infinity,
            //   padding: const EdgeInsets.all(16),
            //   decoration: BoxDecoration(
            //     // color: Colors.blue[50], // light blue background

            //     borderRadius: BorderRadius.circular(2),
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       const Text(
            //         "Similar Products",
            //         style: TextStyle(fontSize: FontSize.homePageTitle, fontWeight: FontWeight.bold, color: AppColors.backgroundWhite),
            //       ),

            //       const SizedBox(height: 12),

            //       ProductDisplayWidget(
            //         cars: [
            //           {
            //             'name': 'BMW M4 Series',
            //             'price': '\$155,000',
            //             'rating': 4.5,
            //             'status': 'New',
            //             'image': Icons.directions_car,
            //             'color': Colors.grey,
            //           },
            //           {
            //             'name': 'Camaro Sports',
            //             'price': '\$170,000',
            //             'rating': 4.7,
            //             'status': 'New',
            //             'image': Icons.directions_car,
            //             'color': Colors.amber,
            //           },
            //           {
            //             'name': 'Audi Sports',
            //             'price': '\$133,000',
            //             'rating': 4.1,
            //             'status': 'Used',
            //             'image': Icons.directions_car,
            //             'color': Colors.red,
            //           },
            //           {
            //             'name': 'Audi Sports',
            //             'price': '\$133,000',
            //             'rating': 4.1,
            //             'status': 'Used',
            //             'image': Icons.directions_car,
            //             'color': Colors.red,
            //           },
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
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
                      'title': '5500 U',
                      'description': 'Processor',
                    },
                    {
                      'icon': Icons.storage,
                      'title': '512 GB',
                      'description': 'Internal Memory',
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
              padding: const EdgeInsets.symmetric(horizontal: 10),
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
                    GradientText(text: "Reviews"),
                    // const Text(
                    //   'Reviews',
                    //   style: TextStyle(
                    //     fontSize: 18,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    const SizedBox(height: 18),
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
            Container(height: 20, color: AppColors.productDetailLightGrey),
            const SizedBox(height: 24),

            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: GradientText(text: 'Shop By Brand'),
                    // child: Text(
                    //   "Shop By Brand",
                    //   style: TextStyle(
                    //     fontSize: 18,
                    //     fontWeight: FontWeight.w600,
                    //   ),
                    // ),
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
                  SizedBox(height: 22),
                ],
              ),
            ),
            Container(height: 46, color: AppColors.productDetailLightGrey),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: AppColors.backgroundWhite,
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
                      // const Icon(Icons.list_alt, color: Colors.black),
                      GradientIconWidget(icon: Icons.list_alt, size: 24),
                      const SizedBox(height: 4),
                      Text(
                        'Specs',
                        style: TextStyle(
                          color: AppColors.textBlack,
                          fontSize: 10,
                        ),
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
                      // const Icon(Icons.star_border, color: Colors.black),
                      GradientIconWidget(icon: Icons.star_border, size: 24),
                      const SizedBox(height: 4),
                      Text(
                        'Review',
                        style: TextStyle(
                          color: AppColors.textBlack,
                          fontSize: 10,
                        ),
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
                      // const Icon(Icons.compare_arrows, color: Colors.black),
                      GradientIconWidget(icon: Icons.compare_arrows, size: 24),
                      const SizedBox(height: 4),
                      Text(
                        'Compare',
                        style: TextStyle(
                          color: AppColors.textBlack,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 8),

              // Container(
              //   width: 150,
              //   height: 48,
              //   decoration: BoxDecoration(
              //     gradient: AppColors.bgGradient,
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: ElevatedButton.icon(
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => CartPageExample(),
              //         ),
              //       );
              //     },
              //     icon: const Icon(
              //       Icons.shopping_bag_outlined,
              //       color: AppColors.backgroundWhite,
              //     ),
              //     label: const Text(
              //       'Add to Cart',
              //       style: TextStyle(color: AppColors.backgroundWhite),
              //     ),
              //     // style: ElevatedButton.styleFrom(
              //     //   // backgroundColor: AppColors.primaryOrange,
              //     //   shape: RoundedRectangleBorder(
              //     //     borderRadius: BorderRadius.circular(10),
              //     //   ),
              //     // ),
              //   ),
              // ),
              Container(
                // width: 130,
                height: 46,
                // padding: const EdgeInsets.symmetric(horizontal: 1),
                decoration: BoxDecoration(
                  gradient: AppColors.bgGradient, // ✅ gradient BG
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Open confirmation drawer
                    // showModalBottomSheet(
                    //   context: context,
                    //   isScrollControlled: true,
                    //   backgroundColor: Colors.transparent,
                    //   builder: (context) => AddToCartConfirmationDrawer(
                    //     storageOptions: _getAvailableStorageOptions(),
                    //     colorOptions: _getColorsForVariant(_selectedVariant!),
                    //     selectedStorage: selectedStorage.toString(),
                    //     selectedColor: selectedColor.toString(),
                    //     selectedQuantity: selectedQuantity,
                    //     availableStock: availableStock,
                    //     selectedVariant: _selectedVariant!,
                    //     productDetail: _productDetail!,
                    //     product: widget.product ?? {},
                    //     onConfirm: (storage, color, quantity) {
                    //       // Handle the confirmed selection and navigate to cart
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => CartPageExample(),
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartPageExample(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.white, // ✅ white icon
                    size: 24,
                  ),
                  label: const Text(
                    'Add to Cart',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ), // ✅ white text
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent, // 🔥 MOST IMPORTANT
                    shadowColor: Colors.transparent, // 🔥 remove shadow
                    elevation: 0,
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

  /// Helper: Build carousel pages from product images
  List<Widget> _buildCarouselPages() {
    if (_productDetail == null) return [];

    final images = <String>[];
    if (_productDetail!.coverImage != null) {
      images.add(_productDetail!.coverImage!);
    }
    images.addAll(_productDetail!.galleryImages);

    // If no images, use placeholder carousel
    if (images.isEmpty) {
      return carouselIcons.map((icon) {
        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.glassmorphismBlack,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 140, color: Colors.grey[400]),
        );
      }).toList();
    }

    // Build carousel from actual images
    return images.map((imageUrl) {
      return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.glassmorphismBlack,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
            width: 240,
            height: 240,
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.laptop, size: 140, color: Colors.grey[400]);
            },
          ),
        ),
      );
    }).toList();
  }

  /// Helper: Get carousel length (images or placeholder icons)
  int _getCarouselLength() {
    if (_productDetail == null) return carouselIcons.length;

    final totalImages =
        ((_productDetail!.coverImage != null) ? 1 : 0) +
        _productDetail!.galleryImages.length;

    return totalImages > 0 ? totalImages : carouselIcons.length;
  }

  /// Helper: Build price section from cheapest variant
  Widget _buildPriceSection() {
    if (_productDetail == null || _selectedVariant == null) {
      return const SizedBox.shrink();
    }

    // Use the currently selected variant (which is updated when storage changes)
    final selectedVariant = _selectedVariant!;

    final finalPrice = selectedVariant.finalPrice ?? selectedVariant.price ?? 0;
    final originalPrice = selectedVariant.price ?? 0;
    final hasDiscount = finalPrice < originalPrice;
    final discountPercent = hasDiscount
        ? (((originalPrice - finalPrice) / originalPrice) * 100)
              .toStringAsFixed(0)
        : null;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Rs',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.formGrey97,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      finalPrice.toStringAsFixed(0),
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(left: 28.0),
                  child: Row(
                    children: [
                      if (hasDiscount) ...[
                        Text(
                          originalPrice.toStringAsFixed(0),
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
                            gradient: AppColors.bgGradient,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '$discountPercent% OFF',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
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
            const SizedBox(width: 12),
          ],
        ),
      ],
    );
  }

  /// Helper: Build storage section (RAM/Storage options from variants)
  /// Get all unique storage options from variantSpecifications

  Widget _buildStorageSection() {
    if (_productDetail == null || _productDetail!.variants.isEmpty) {
      return const SizedBox.shrink();
    }

    // Get unique storage options formatted as "RAM - Storage"
    final storageOptions = _getAvailableStorageOptions();

    if (storageOptions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Storage',
          style: TextStyle(
            fontSize: FontSize.homePageTitle,
            fontWeight: FontWeight.bold,
            color: AppColors.secondaryColor1,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: storageOptions.map((storage) {
            return _buildStorageOption(storage);
          }).toList(),
        ),
      ],
    );
  }

  /// Helper: Build colors section
  Widget _buildColorsSection() {
    if (_productDetail == null || _selectedVariant == null) {
      return const SizedBox.shrink();
    }

    // Get colors ONLY for the currently selected variant/storage
    final availableColors = _getColorsForVariant(_selectedVariant!);

    if (availableColors.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Colors',
          style: TextStyle(
            fontSize: FontSize.homePageTitle,
            fontWeight: FontWeight.bold,
            color: AppColors.secondaryColor1,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: availableColors
              .map((color) => _buildColorOption(color))
              .toList(),
        ),
      ],
    );
  }

  /// Helper: Build quantity selector
  Widget _buildQuantitySection() {
    return Row(
      children: [
        Container(
          height: 44,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.backgroundGreyLight),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                icon: const Icon(Icons.remove, size: 20),
                onPressed: () {
                  setState(() {
                    if (selectedQuantity > 1) {
                      selectedQuantity -= 1;
                      if (selectedQuantity < availableStock) {
                        _stockLimitReached = false;
                      }
                    }
                  });
                },
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
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
                constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                icon: const Icon(Icons.add, size: 20),
                onPressed: () {
                  setState(() {
                    if (selectedQuantity < availableStock) {
                      selectedQuantity += 1;
                      _stockLimitReached = false;
                    } else {
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
            color: _stockLimitReached ? Colors.red : Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildColorOption(String color) {
    bool isSelected = selectedColor == color;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color;
        });
        // Update variant selection which updates price and stock
        _updateVariantSelection(newColor: color);
        // Rebuild to show updated price
        setState(() {});
      },
      child: Container(
        padding: const EdgeInsets.all(2), // outer padding same for both
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: isSelected ? AppColors.bgGradient : null, // gradient border
          border: !isSelected
              ? Border.all(color: Colors.black, width: 1.5)
              : null,
        ),
        child: Container(
          padding: isSelected
              ? const EdgeInsets.symmetric(horizontal: 10, vertical: 7)
              : const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 5,
                ), // inner padding same always
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue[50] : AppColors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: ShaderMask(
            shaderCallback: (bounds) => isSelected
                ? AppColors.bgGradient.createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  )
                : LinearGradient(
                    colors: [AppColors.textBlack, AppColors.textBlack],
                  ).createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  ),
            child: Text(
              color,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStorageOption(String storage) {
    bool isSelected = selectedStorage == storage;

    return GestureDetector(
      onTap: () {
        // Update variant selection which triggers setState internally
        _updateVariantSelection(newStorage: storage);
      },
      child: Container(
        padding: const EdgeInsets.all(2), // outer padding same for both
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: isSelected ? AppColors.bgGradient : null, // gradient border
          border: !isSelected
              ? Border.all(color: Colors.black, width: 1.5)
              : null,
        ),
        child: Container(
          padding: isSelected
              ? const EdgeInsets.symmetric(horizontal: 10, vertical: 7)
              : const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 5,
                ), // inner padding same always
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue[50] : AppColors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: ShaderMask(
            shaderCallback: (bounds) => isSelected
                ? AppColors.bgGradient.createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  )
                : LinearGradient(
                    colors: [AppColors.textBlack, AppColors.textBlack],
                  ).createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  ),
            child: Text(
              storage,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ExpandableText extends StatefulWidget {
  final String text;
  final int trimLines;

  const ExpandableText({super.key, required this.text, this.trimLines = 3});

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;
  late String firstPart;
  late String secondPart;
  bool isOverflow = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _splitText());
  }

  void _splitText() {
    final textPainter = TextPainter(
      text: TextSpan(
        text: widget.text,
        style: const TextStyle(fontSize: 13, color: Colors.grey, height: 1.6),
      ),
      maxLines: widget.trimLines,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(maxWidth: MediaQuery.of(context).size.width - 32);

    if (textPainter.didExceedMaxLines) {
      isOverflow = true;

      // find approximate cutoff
      int cutoff = (widget.text.length * 0.4)
          .toInt(); // adjust 0.6 for exact length
      firstPart = widget.text.substring(0, cutoff);
      secondPart = widget.text.substring(cutoff);
    } else {
      firstPart = widget.text;
      secondPart = '';
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!isOverflow) {
      return Text(
        widget.text,
        style: const TextStyle(fontSize: 13, color: Colors.grey, height: 1.6),
      );
    }

    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 13, color: Colors.grey, height: 1.6),
        children: [
          TextSpan(text: isExpanded ? widget.text : "$firstPart..."),
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: GestureDetector(
              onTap: () => setState(() => isExpanded = !isExpanded),
              child: Text(
                isExpanded ? " Less" : " More",
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
