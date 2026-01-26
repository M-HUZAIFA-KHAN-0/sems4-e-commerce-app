// address_form.dart
import 'package:first/core/app_imports.dart';
import 'package:first/widgets/city_selector_widget.dart';

class AddressForm extends StatefulWidget {
  final Map<String, String>? existing;
  final Function(Map<String, String>, bool) onSave;

  const AddressForm({super.key, this.existing, required this.onSave});

  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _addrCtrl = TextEditingController();
  String? _selectedCity;
  bool _isDefault = false;

  @override
  void initState() {
    super.initState();
    if (widget.existing != null) {
      _nameCtrl.text = widget.existing!['label'] ?? '';
      _addrCtrl.text = widget.existing!['address'] ?? '';
      _selectedCity = widget.existing!['city'];
      _isDefault = widget.existing!['tag'] == 'Default';
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _addrCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Address Details',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _nameCtrl,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Label (e.g., Home, Office)',
          ),
        ),
        const SizedBox(height: 16),
        MultilineTextFieldWidget(
          controller: _addrCtrl,
          labelText: 'Address Details',
          maxLines: 3,
          minLines: 3,
          prefixIcon: Icons.location_on,
        ),
        const SizedBox(height: 16),
        CitySelector(
          selectedCity: _selectedCity,
          onCitySelected: (city) {
            setState(() => _selectedCity = city);
          },
          isRequired: true,
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
              value: _isDefault,
              activeColor: AppColors.formBlack,
              checkColor: AppColors.backgroundWhite,
              onChanged: (val) => setState(() => _isDefault = val!),
            ),
            const Text(
              'Make as the default address',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 18),
          child: SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                if (_nameCtrl.text.isNotEmpty &&
                    _addrCtrl.text.isNotEmpty &&
                    _selectedCity != null &&
                    _selectedCity!.isNotEmpty) {
                  final Map<String, String> newMap = {
                    'label': _nameCtrl.text,
                    'address': _addrCtrl.text,
                    'city': _selectedCity!,
                  };
                  widget.onSave(newMap, _isDefault);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.textBlack,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
              ),
              child: Text(
                widget.existing == null ? 'Add' : 'Update',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: AppColors.backgroundWhite,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
