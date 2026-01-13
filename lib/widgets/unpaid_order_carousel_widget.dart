import 'package:flutter/material.dart';
import 'dart:async';

/// Model for Unpaid Order
class UnpaidOrder {
  final String id;
  final String productImage;
  final String productTitle;
  final String orderBadgeText;
  final VoidCallback onPayNowPressed;

  UnpaidOrder({
    required this.id,
    required this.productImage,
    required this.productTitle,
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
  int _remainingSeconds = 600; // 10 minutes = 600 seconds

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
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_pageController.hasClients && mounted) {
        _currentPage = (_currentPage + 1) % widget.orders.length;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 600),
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
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
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
            height: 140,
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
          if (widget.orders.length > 1)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.orders.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 8 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: _currentPage == index
                          ? const Color(0xFFFF4757)
                          : Colors.grey[300],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(UnpaidOrder order) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Product Image
          Container(
            width: 100,
            height: 116,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[200],
              image: DecorationImage(
                image: NetworkImage(order.productImage),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                // Badge for "SPECIAL OFFER..."
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(8),
                        // bottom: Radius.circular(8),
                      ),
                    ),
                    child: Text(
                      order.orderBadgeText,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
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
                    color: Colors.black87,
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
                            color: Colors.black87,
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
          // Pay Now Button
          GestureDetector(
            onTap: order.onPayNowPressed,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFFF4757), width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Pay Now',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFFF4757),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
