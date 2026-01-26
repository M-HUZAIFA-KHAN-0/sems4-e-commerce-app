// import 'package:first/screens/onboarding_screen.dart';
// import 'package:flutter/material.dart';
// import 'main-home.dart';
import 'package:first/core/app_imports.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Car Deals',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: const _SlowDrawerPageTransitionsBuilder(),
            TargetPlatform.iOS: const _SlowDrawerPageTransitionsBuilder(),
          },
        ),
      ),
      // home: const MyHomePage(),
      // home: const OnboardingScreen(),
      home: const CheckoutPage(),
    //   home: const ProductDetailPage( product: {
    //   'name': 'Camaro Sports',
    //   'price': '\$170,000',
    //   'rating': 4.7,
    //   'status': 'New',
    //   'image': Icons.directions_car,
    //   // 'color': Colors.amber[100],
    // },
    //   ),
    );
  }
}

/// Custom Page Transitions Builder for slower drawer animations
class _SlowDrawerPageTransitionsBuilder extends PageTransitionsBuilder {
  const _SlowDrawerPageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // Default fade transition with slower animation
    return FadeTransition(opacity: animation, child: child);
  }
}
