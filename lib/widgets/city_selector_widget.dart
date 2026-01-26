import 'package:first/core/app_imports.dart';
import 'package:first/core/city_constants.dart';

class CitySelector extends StatefulWidget {
  final String? selectedCity;
  final Function(String) onCitySelected;
  final bool isRequired;

  const CitySelector({
    super.key,
    this.selectedCity,
    required this.onCitySelected,
    this.isRequired = true,
  });

  @override
  State<CitySelector> createState() => _CitySelectorState();
}

class _CitySelectorState extends State<CitySelector> {
  late String? _selectedCity;

  @override
  void initState() {
    super.initState();
    _selectedCity = widget.selectedCity;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedCity,
      hint: const Text(
        'Select City',
        style: TextStyle(fontSize: 14, color: AppColors.textGreyLabel),
      ),
      isExpanded: true,
      elevation: 4,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        filled: true,
        fillColor: AppColors.backgroundWhite,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.textBlack, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
      ),
      items: CityConstants.cities.map((city) {
        return DropdownMenuItem<String>(
          value: city,
          child: Text(
            city,
            style: const TextStyle(fontSize: 14, color: AppColors.textBlack),
          ),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          setState(() => _selectedCity = value);
          widget.onCitySelected(value);
        }
      },
      validator: (value) {
        if (widget.isRequired && (value == null || value.isEmpty)) {
          return 'Please select a city';
        }
        return null;
      },
    );
  }
}
