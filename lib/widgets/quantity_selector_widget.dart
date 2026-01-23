import 'package:first/core/app_imports.dart';

class QuantitySelectorWidget extends StatelessWidget {
  final int quantity;
  final ValueChanged<int> onQuantityChanged;
  final double iconSize;
  final double height;
  final Color borderColor;
  final TextStyle? textStyle;

  const QuantitySelectorWidget({
    super.key,
    required this.quantity,
    required this.onQuantityChanged,
    this.iconSize = 18,
    this.height = 36,
    this.borderColor = const Color(0xFFE5E5E5),
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: quantity > 1
                  ? () => onQuantityChanged(quantity - 1)
                  : null,
              child: Icon(
                Icons.remove,
                size: iconSize,
                color: quantity > 1 ? Colors.black : Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                quantity.toString(),
                style:
                    textStyle ??
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => onQuantityChanged(quantity + 1),
              child: Icon(Icons.add, size: iconSize, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
