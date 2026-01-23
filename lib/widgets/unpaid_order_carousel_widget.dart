import 'package:first/core/app_imports.dart';

/// Model for Unpaid Order
class UnpaidOrder {
  final String id;
  final String productImage;
  final String orderBadgeText;
  final VoidCallback onPayNowPressed;

  UnpaidOrder({
    required this.id,
    required this.productImage,
    required this.orderBadgeText,
    required this.onPayNowPressed,
  });
}

/// Unpaid Order Card Widget with Carousel and Timer
class UnpaidOrderCarouselWidget extends StatefulWidget {
  final List<UnpaidOrder> orders;

  const UnpaidOrderCarouselWidget({super.key, required this.orders});

  @override
  State<UnpaidOrderCarouselWidget> createState() =>
      _UnpaidOrderCarouselWidgetState();
}

class _UnpaidOrderCarouselWidgetState extends State<UnpaidOrderCarouselWidget> {
  late PageController _pageController;
  late Timer _autoScrollTimer;
  late Timer _countdownTimer;
  int _currentPage = 0;
  int _remainingSeconds = 600;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 1.0);
    if (widget.orders.length > 1) {
      _startAutoScroll();
    }
    _startCountdownTimer();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients && mounted) {
        _currentPage = (_currentPage + 1) % widget.orders.length;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        // Reset timer for new order
        _remainingSeconds = 600;
      }
    });
  }

  void _startCountdownTimer() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_remainingSeconds > 0) {
            _remainingSeconds--;
          } else {
            _countdownTimer.cancel();
          }
        });
      }
    });
  }

  String _formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int secs = seconds % 60;
    return '${hours.toString().padLeft(2, '0')} : ${minutes.toString().padLeft(2, '0')} : ${secs.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _pageController.dispose();
    if (widget.orders.length > 1) {
      _autoScrollTimer.cancel();
    }
    _countdownTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.orders.isEmpty) {
      return const SizedBox();
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.backgroundWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Carousel or Single Card
          SizedBox(
            height: 70,
            child: widget.orders.length == 1
                ? _buildOrderCard(widget.orders[0])
                : PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                        _remainingSeconds = 600; // Reset timer on page change
                      });
                    },
                    itemCount: widget.orders.length,
                    itemBuilder: (context, index) {
                      return _buildOrderCard(widget.orders[index]);
                    },
                  ),
          ),
          // Carousel Indicators (only show if multiple orders)
          // if (widget.orders.length > 1)
          //   Padding(
          //     padding: const EdgeInsets.only(bottom: 12),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: List.generate(
          //         widget.orders.length,
          //         (index) => Container(
          //           margin: const EdgeInsets.symmetric(horizontal: 4),
          //           width: _currentPage == index ? 8 : 6,
          //           height: 6,
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(3),
          //             color: _currentPage == index
          //                 ? const Color(0xFFFF4757)
          //                 : AppColors.backgroundGreyLight,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(UnpaidOrder order) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          // Product Image
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[200],
              image: DecorationImage(
                image: NetworkImage(order.productImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 14),
          // Order Details
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Unpaid Order',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textBlack87,
                  ),
                ),
                const SizedBox(height: 4),
                Flexible(
                  child: Row(
                    children: [
                      const Text(
                        'Expire in ',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          _formatTime(_remainingSeconds),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textBlack87,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: order.onPayNowPressed,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: AppColors.textBlack,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26),
              ),
            ),
            child: Text(
              'Pay Now',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: AppColors.backgroundWhite,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
