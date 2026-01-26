/// Example Usage of ProductService
/// 
/// This file demonstrates how to use the ProductService to fetch products from the API
/// 
/// 1. BASIC SETUP
/// ==============
/// // In your widget:
/// final ProductService productService = ProductService();
/// 
/// // Fetch all products
/// List<ProductModel> products = await productService.fetchProducts();
/// 
/// 
/// 2. USAGE IN A WIDGET
/// ====================
/// class ProductListPage extends StatefulWidget {
///   @override
///   State<ProductListPage> createState() => _ProductListPageState();
/// }
/// 
/// class _ProductListPageState extends State<ProductListPage> {
///   final ProductService _productService = ProductService();
///   late Future<List<ProductModel>> _productsFuture;
/// 
///   @override
///   void initState() {
///     super.initState();
///     _productsFuture = _productService.fetchProducts();
///   }
/// 
///   @override
///   Widget build(BuildContext context) {
///     return FutureBuilder<List<ProductModel>>(
///       future: _productsFuture,
///       builder: (context, snapshot) {
///         if (snapshot.connectionState == ConnectionState.waiting) {
///           return const Center(child: CircularProgressIndicator());
///         }
/// 
///         if (snapshot.hasError) {
///           return Center(child: Text('Error: ${snapshot.error}'));
///         }
/// 
///         final products = snapshot.data ?? [];
///         return ListView.builder(
///           itemCount: products.length,
///           itemBuilder: (context, index) {
///             final product = products[index];
///             return ListTile(
///               title: Text(product.productName),
///               subtitle: Text('Rs. ${product.price}'),
///             );
///           },
///         );
///       },
///     );
///   }
/// }
/// 
/// 
/// 3. DIFFERENT API CALLS
/// ======================
/// 
/// // Fetch single product
/// ProductModel? product = await productService.fetchProductById(1);
/// 
/// // Fetch by category
/// List<ProductModel> laptops = await productService.fetchProductsByCategory('Laptops');
/// 
/// // Search products
/// List<ProductModel> results = await productService.searchProducts('iPhone');
/// 
/// 
/// 4. AUTHORIZATION (if needed)
/// =============================
/// final apiClient = ApiClient();
/// apiClient.setAuthToken('your_token_here');
/// // Now all subsequent requests will include this token
///
