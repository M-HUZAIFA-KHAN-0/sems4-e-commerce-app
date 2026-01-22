import 'package:first/core/app_imports.dart';

class CheckboxWithLabelWidget extends StatefulWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final TextStyle? labelStyle;
  final Color? activeColor;
  final double? labelFontSize;

  const CheckboxWithLabelWidget({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.labelStyle,
    this.activeColor,
    this.labelFontSize,
  });

  @override
  State<CheckboxWithLabelWidget> createState() =>
      _CheckboxWithLabelWidgetState();
}

class _CheckboxWithLabelWidgetState extends State<CheckboxWithLabelWidget> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: _value,
          onChanged: (newValue) {
            if (newValue != null) {
              setState(() {
                _value = newValue;
              });
              widget.onChanged(newValue);
            }
          },
          activeColor: widget.activeColor,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _value = !_value;
              });
              widget.onChanged(!_value);
            },
            child: Text(
              widget.label,
              style:
                  widget.labelStyle ??
                  TextStyle(
                    fontSize: widget.labelFontSize ?? 14,
                    color: AppColors.textBlack87,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
