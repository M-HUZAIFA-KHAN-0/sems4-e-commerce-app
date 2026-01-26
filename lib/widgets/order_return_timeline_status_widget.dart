import 'package:first/core/app_imports.dart';

class OrderReturnTimelineStatusWidget extends StatelessWidget {
  final String status; // pending | approved | returned | refunded

  const OrderReturnTimelineStatusWidget({
    super.key,
    required this.status,
  });

  int get _activeIndex {
    switch (status.toLowerCase()) {
      case 'approved':
        return 0;
      case 'returned':
        return 1;
      case 'refunded':
        return 2;
      case 'pending':
      default:
        return -1;
    }
  }

  bool _isActive(int index) => index <= _activeIndex;
  bool _isLineActive(int index) => index < _activeIndex;

  Color _textColor(int index) {
    return _isActive(index)
        ? AppColors.color666666
        : AppColors.textGreyDark;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _step(
          index: 0,
          title: 'Approved',
          icon: Icons.check,
        ),

        _line(0),

        _step(
          index: 1,
          title: 'Returned',
          icon: Icons.restart_alt_rounded,
        ),

        _line(1),

        _step(
          index: 2,
          title: 'Refunded',
          icon: Icons.account_balance_wallet_outlined,
        ),
      ],
    );
  }

  Widget _step({
    required int index,
    required String title,
    required IconData icon,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              gradient: _isActive(index) ? AppColors.bgGradient : null,
              color: _isActive(index) ? null : AppColors.textGreyMedium,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: AppColors.backgroundWhite,
              size: 18,
            ),
          ),
          const SizedBox(height: 4),
          _isActive(index)
          ? GradientText(
              text: title,
              fontSize: 10,
            )
          : Text(
              title,
              style: TextStyle(
                fontSize: 10,
                color: _textColor(index),
              ),
            ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  Widget _line(int index) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 2,
            width: 50,
            decoration: BoxDecoration(
              gradient: _isLineActive(index) ? AppColors.bgGradient : null,
              color: _isLineActive(index)
                  ? null
                  : AppColors.textGreyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
