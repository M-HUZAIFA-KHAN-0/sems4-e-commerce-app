# API Integration Guide

## 📁 Project Structure

```
lib/
├── models/
│   ├── models.dart (barrel file)
│   └── product_model.dart (Product data model)
├── services/
│   ├── services.dart (barrel file)
│   ├── api/
│   │   ├── api_client.dart (Dio configuration & singleton)
│   │   └── product_service.dart (Product API calls)
│   └── API_USAGE_EXAMPLE.dart
└── core/
    └── app_imports.dart (includes API exports)
```

## 🔧 Configuration

### 1. Update API Base URL

Edit `lib/services/api/api_client.dart`:

```dart
baseUrl: 'https://yourapi.com', // 👈 REPLACE THIS
```

### 2. Add Authentication (if needed)

In your login/auth screen:

```dart
final apiClient = ApiClient();
apiClient.setAuthToken(token);
// All future requests will now include the token
```

## 📝 Available API Methods

### ProductService

#### 1. **Fetch All Products**
```dart
final ProductService service = ProductService();
List<ProductModel> products = await service.fetchProducts();
```

#### 2. **Fetch Single Product**
```dart
ProductModel? product = await service.fetchProductById(1);
```

#### 3. **Fetch by Category**
```dart
List<ProductModel> laptops = await service.fetchProductsByCategory('Laptops');
```

#### 4. **Search Products**
```dart
List<ProductModel> results = await service.searchProducts('iPhone');
```

## 🎯 Usage Example in Widget

```dart
class ProductListPage extends StatefulWidget {
  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final ProductService _productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductModel>>(
      future: _productService.fetchProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final products = snapshot.data ?? [];
        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return ListTile(
              title: Text(product.productName),
              subtitle: Text('Rs. ${product.price}'),
              trailing: Text('⭐ ${product.rating}'),
            );
          },
        );
      },
    );
  }
}
```

## 💡 Key Features

✅ **Singleton Pattern** - ApiClient uses singleton for single DIO instance
✅ **Error Handling** - Built-in try-catch blocks
✅ **Rating Aggregation** - Automatically fetches and calculates product ratings
✅ **Logging** - Built-in logging for debugging
✅ **Interceptors** - Ready for authentication and error handling
✅ **Type Safety** - Strongly typed models

## ⚠️ Important Notes

1. **API Base URL**: Update the base URL in `api_client.dart` to your actual API endpoint
2. **Endpoints**: Adjust the endpoint paths in `product_service.dart` to match your API
3. **Authentication**: Use `ApiClient().setAuthToken(token)` after login
4. **Error Handling**: All methods have built-in error handling with try-catch

## 🚀 Next Steps

1. Update the API base URL
2. Test each endpoint against your actual API
3. Add more services (UserService, CartService, etc.) following the same pattern
4. Implement state management (Provider/BLoC) for better data management
5. Add caching to reduce API calls

## 📞 Debugging

Enable logging to see API requests/responses:
- All logs are printed to console via `LogInterceptor`
- Check the browser/terminal console when running the app
