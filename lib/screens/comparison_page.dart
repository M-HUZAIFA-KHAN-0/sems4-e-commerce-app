import 'package:first/core/app_imports.dart';

class ComparisonPage extends StatefulWidget {
  final Map<String, dynamic>? currentProduct;
  const ComparisonPage({super.key, this.currentProduct});

  @override
  State<ComparisonPage> createState() => _ComparisonPageState();
}

class _ComparisonPageState extends State<ComparisonPage> {
  // sample products for demo
  final List<Map<String, dynamic>> allProducts = [
    {
      'id': 'mac13',
      'title': 'Apple MacBook Air 13 M1\nMGN63 (8GB-256GB)',
      'price': 'Rs 203,499',
      'discount': '21% OFF',
      'imageUrl': 'https://via.placeholder.com/200x200?text=MacBook',
      'specs': {
        'Screen Size': '13.3-inches',
        'Screen Resolution': 'N/A',
        'Weight': '2.8 pounds',
        'Operating System': 'macOS',
        'Generation': 'M1',
        'Processor Type': 'Apple M1 Chip',
        'Processor Speed':
            '8-core CPU with 4 performance cores and 4 efficiency cores 7-core GPU 16-core Neural Engine',
        'Internal Memory': '256 GB SSD',
        'RAM': '8 GB',
        'Graphics Memory': 'N/A',
        'Backlit Keyboard':
            'Backlit Magic Keyboard with 78 (U.S.) or 79 (ISO) keys including 12 function keys and 4 arrow keys in an inverted-T arrangement Ambient light sensor Force Touch trackpad for precise cursor control and pressure-sensing capabilities; enables Force clicks.',
      },
    },
    {
      'id': 'lenovo15',
      'title': 'LENOVO LOQ 15 CI7-\n14650HX',
      'price': 'Rs 401,999',
      'discount': '10% OFF',
      'imageUrl': 'https://via.placeholder.com/200x200?text=Lenovo',
      'specs': {
        'Screen Size': '15.6',
        'Screen Resolution': 'N/A',
        'Weight': '2.3 kg / 5.07 lbs',
        'Operating System': 'Windows 11 Home 64',
        'Generation': 'N/A',
        'Processor Type':
            'AMD Ryzen™ 7 250 Processor (3.30 GHz up to 5.10 GHz)',
        'Processor Speed':
            'Processor (3.30 GHz, up to 5.10 GHz Max Boost, 8 Cores, 16 Threads, 16 MB Cache)',
        'Internal Memory': '512 GB SSD M.2 2242 PCIe Gen4 QLC',
        'RAM': '16 GB DDR5-5600MT/s (SODIMM)',
        'Graphics Memory':
            'NVIDIA® GeForce RTX™ 5060 Laptop GPU (8GB GDDR7, 128-bit, 115W incl. 15W Boost, Up to 572 AI TOPS, 3328 CUDA Cores)',
        'Backlit Keyboard': 'White Backlit, Eclipse Black - English (US)',
      },
    },
  ];

  late Map<String, dynamic>? product1;
  Map<String, dynamic>? product2;

  // Convert ProductDetail product to comparison format
  Map<String, dynamic> _convertProductForComparison(
    Map<String, dynamic> product,
  ) {
    return {
      'id': product['id'] ?? 'unknown',
      'title': product['name'] ?? product['title'] ?? 'Product',
      'price': product['price'] ?? 'Rs 0',
      'discount': product['discount'],
      'imageUrl': 'https://via.placeholder.com/200x200?text=Product',
      'specs': {
        'Screen Size': 'N/A',
        'Screen Resolution': 'N/A',
        'Weight': 'N/A',
        'Operating System': 'N/A',
        'Generation': 'N/A',
        'Processor Type': 'N/A',
        'Processor Speed': 'N/A',
        'Internal Memory': 'N/A',
        'RAM': 'N/A',
        'Graphics Memory': 'N/A',
        'Backlit Keyboard': 'N/A',
      },
    };
  }

  @override
  void initState() {
    super.initState();
    // Pre-fill first slot with the product from Product Detail page
    if (widget.currentProduct != null) {
      product1 = _convertProductForComparison(widget.currentProduct!);
    }
  }

  void _selectProduct(int slot, Map<String, dynamic> product) {
    setState(() {
      if (slot == 0) {
        product1 = product;
      } else {
        product2 = product;
      }
    });
  }

  void _clearProduct(int slot) {
    setState(() {
      if (slot == 0) {
        product1 = null;
      } else {
        product2 = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        foregroundColor: AppColors.textBlack87,
        elevation: 0,
        title: const Text(
          'Comparisons',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // top product selection slots
            Container(
              color: AppColors.backgroundGrey,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Row(
                children: [
                  ComparisonProductSlotWidget(
                    product: product1,
                    allProducts: allProducts,
                    onSelect: () => _selectProduct(0, product1!),
                    onClear: () => _clearProduct(0),
                    onProductPicked: (p) => _selectProduct(0, p),
                  ),
                  const SizedBox(width: 12),
                  ComparisonProductSlotWidget(
                    product: product2,
                    allProducts: allProducts,
                    onSelect: () => _selectProduct(1, product2!),
                    onClear: () => _clearProduct(1),
                    onProductPicked: (p) => _selectProduct(1, p),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // specs comparison table
            ComparisonSpecsWidget(product1: product1, product2: product2),
          ],
        ),
      ),
    );
  }
}
