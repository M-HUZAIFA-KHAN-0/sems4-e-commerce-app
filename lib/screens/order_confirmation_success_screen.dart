import 'package:first/core/app_imports.dart';

/// Order Confirmation Success Screen
/// Displays a success message for 2 seconds before navigating to the target page
class OrderConfirmationSuccessScreen extends StatefulWidget {
  final Widget targetPage;
  final String message;
  final Duration displayDuration;

  const OrderConfirmationSuccessScreen({
    super.key,
    required this.targetPage,
    this.message = 'Your order has been placed successfully',
    this.displayDuration = const Duration(seconds: 2),
  });

  @override
  State<OrderConfirmationSuccessScreen> createState() =>
      _OrderConfirmationSuccessScreenState();
}

class _OrderConfirmationSuccessScreenState
    extends State<OrderConfirmationSuccessScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    // Setup animations
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    // Start animation
    _animationController.forward();

    // Navigate after duration
    Future.delayed(widget.displayDuration, () {
      if (mounted) {
        Navigator.of(
          context,
        ).pushReplacement(MaterialPageRoute(builder: (_) => widget.targetPage));
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: Center(
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: FadeTransition(
            opacity: _opacityAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// SUCCESS ICON
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: AppColors.bgGradient,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle_outline,
                    size: 60,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 32),

                /// SUCCESS MESSAGE
                Text(
                  widget.message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                    letterSpacing: 0.3,
                  ),
                ),

                const SizedBox(height: 12),

                /// SUBTEXT
                Text(
                  'Redirecting to order receipt...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textGreyLight,
                  ),
                ),

                const SizedBox(height: 48),

                /// LOADING INDICATOR
                SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.secondaryColor1,
                    ),
                    strokeWidth: 3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
