import 'package:first/core/app_imports.dart';

class StepCircle extends StatelessWidget {
  final bool active;
  final bool done;
  final String label;
  final int stepNumber;

  const StepCircle({
    super.key,
    required this.active,
    required this.label,
    this.done = false,
    this.stepNumber = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 32, // radius 16 * 2
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: active ? AppColors.bgGradient : null,
            color: active ? null : Colors.grey.shade300,
          ),
          alignment: Alignment.center,
          child: done
              ? const Icon(
                  Icons.check,
                  color: AppColors.backgroundWhite,
                  size: 18,
                )
              : Text(
                  '$stepNumber',
                  style: TextStyle(
                    color: active
                        ? AppColors.backgroundWhite
                        : AppColors.textBlack,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 10)),
      ],
    );
  }
}

class StepLine extends StatelessWidget {
  final bool active;
  const StepLine({ super.key, required this.active});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 2.5,
        margin: const EdgeInsets.only(bottom: 18),
        decoration: BoxDecoration(
          gradient: active ? AppColors.bgGradient : null,
          color: active ? null : Colors.grey.shade300,
        ),
      ),
    );
  }
}
