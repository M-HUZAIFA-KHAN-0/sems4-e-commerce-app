// // address_form.dart
// import 'package:first/core/app_imports.dart';
// // import 'package:first/services/api/address_service.dart';
// // import 'package:first/models/create_address_model.dart';
// import 'package:first/widgets/city_selector_widget.dart';

// class AddressForm extends StatefulWidget {
//   final Map<String, String>? existing;
//   final VoidCallback onSuccess; // Changed to simple callback on success

//   const AddressForm({super.key, this.existing, required this.onSuccess});

//   @override
//   _AddressFormState createState() => _AddressFormState();
// }

// class _AddressFormState extends State<AddressForm> {
//   final TextEditingController _nameCtrl = TextEditingController();
//   final TextEditingController _addrCtrl = TextEditingController();
//   // final TextEditingController _postalCodeCtrl =
//   //     TextEditingController(); // Added Postal Code
//   String? _selectedCity;
//   bool _isDefault = false;
//   bool _isLoading = false;
//   final AddressService _addressService = AddressService();

//   @override
//   void initState() {
//     super.initState();
//     if (widget.existing != null) {
//       _nameCtrl.text = widget.existing!['label'] ?? '';
//       _addrCtrl.text = widget.existing!['address'] ?? '';
//       // Note: Existing logic might need update if you fetch postal code in edit mode
//       _selectedCity = widget.existing!['city'];
//       _isDefault = widget.existing!['tag'] == 'Default';
//     }
//   }

//   @override
//   void dispose() {
//     _nameCtrl.dispose();
//     _addrCtrl.dispose();
//     super.dispose();
//   }

//   Future<void> _validateAndSubmit() async {
//     // 1. Validation: Check if all fields are filled
//     if (_nameCtrl.text.trim().isEmpty ||
//         _addrCtrl.text.trim().isEmpty ||
//         _selectedCity == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text(
//             'Please fill all fields including City and Postal Code',
//           ),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }

//     setState(() => _isLoading = true);

//     try {
//       // 2. Prepare Model
//       final newAddress = CreateAddressModel(
//         userId: UserSessionManager().userId!,
//         cityId: int.parse(_selectedCity!), // CitySelector returns ID as String
//         addressLine1: _addrCtrl.text.trim(),
//         label: _nameCtrl.text.trim(),
//         isDefault: _isDefault,
//       );

//       // 3. Hit API
//       final success = await _addressService.createAddress(newAddress);

//       if (success && mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Address added successfully!'),
//             backgroundColor: Colors.green,
//           ),
//         );
//         widget.onSuccess(); // Notify parent to refresh/close
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Failed to add address: $e'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     } finally {
//       if (mounted) {
//         setState(() => _isLoading = false);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         const Text(
//           'Address Details',
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 16),
//         TextField(
//           controller: _nameCtrl,
//           decoration: const InputDecoration(
//             border: OutlineInputBorder(),
//             labelText: 'Label (e.g., Home, Office)',
//           ),
//         ),
//         const SizedBox(height: 16),
//         CitySelector(
//           selectedCity: _selectedCity,
//           onCitySelected: (city) {
//             setState(() => _selectedCity = city);
//           },
//           isRequired: true,
//         ),
//         const SizedBox(height: 16),

//         const SizedBox(height: 16),
//         MultilineTextFieldWidget(
//           controller: _addrCtrl,
//           labelText: 'Address Details',
//           maxLines: 3,
//           minLines: 3,
//           prefixIcon: Icons.location_on,
//         ),
//         const SizedBox(height: 16),
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Checkbox(
//               value: _isDefault,
//               activeColor: AppColors.formBlack,
//               checkColor: AppColors.backgroundWhite,
//               onChanged: (val) => setState(() => _isDefault = val!),
//             ),
//             const Text(
//               'Make as the default address',
//               style: TextStyle(fontSize: 16),
//             ),
//           ],
//         ),
//         const SizedBox(height: 16),
//         Padding(
//           padding: const EdgeInsets.fromLTRB(0, 0, 0, 18),
//           child: SizedBox(
//             width: double.infinity,
//             height: 48,
//             child: ElevatedButton(
//               onPressed: _isLoading ? null : _validateAndSubmit,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.textBlack,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(26),
//                 ),
//               ),
//               child: Text(
//                 _isLoading
//                     ? 'Saving...'
//                     : (widget.existing == null
//                           ? 'Add Address'
//                           : 'Update Address'),
//                 style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w800,
//                   color: AppColors.backgroundWhite,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }






































import 'package:first/core/app_imports.dart';
import 'package:first/widgets/city_selector_widget.dart';

class AddressForm extends StatefulWidget {
  final Map<String, dynamic>? existing;
  final VoidCallback onSuccess;

  const AddressForm({
    super.key,
    this.existing,
    required this.onSuccess,
  });

  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _addrCtrl = TextEditingController();

  String? _selectedCity;
  bool _isDefault = false;
  bool _isLoading = false;

  final AddressService _addressService = AddressService();

  @override
  void initState() {
    super.initState();

    if (widget.existing != null) {
      _nameCtrl.text = widget.existing!['addressLine2'] ?? '';
      _addrCtrl.text = widget.existing!['addressLine1'] ?? '';
      _selectedCity = widget.existing!['cityId']?.toString();
      _isDefault = widget.existing!['isDefault'] == true;
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _addrCtrl.dispose();
    super.dispose();
  }

  Future<void> _validateAndSubmit() async {
    if (_nameCtrl.text.trim().isEmpty ||
        _addrCtrl.text.trim().isEmpty ||
        _selectedCity == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final model = CreateAddressModel(
        userId: UserSessionManager().userId!,
        cityId: int.parse(_selectedCity!),
        addressLine1: _addrCtrl.text.trim(),
        label: _nameCtrl.text.trim(),
        isDefault: _isDefault,
      );

      bool success;

      // 🔁 ADD vs UPDATE
      if (widget.existing == null) {
        // ➕ CREATE
        success = await _addressService.createAddress(model);
      } else {
        // ✏️ UPDATE
        final addressId = widget.existing!['addressId'];
        success = await _addressService.updateAddress(addressId, model);
      }

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.existing == null
                  ? 'Address added successfully'
                  : 'Address updated successfully',
            ),
            backgroundColor: Colors.green,
          ),
        );

        widget.onSuccess(); // close drawer + refresh list
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Operation failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
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
            labelText: 'Label (Home, Office)',
          ),
        ),

        const SizedBox(height: 16),

        CitySelector(
          selectedCity: _selectedCity,
          onCitySelected: (cityId) {
            setState(() => _selectedCity = cityId);
          },
          isRequired: true,
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

        Row(
          children: [
            Checkbox(
              value: _isDefault,
              onChanged: (val) => setState(() => _isDefault = val!),
            ),
            const Text('Make as default address'),
          ],
        ),

        const SizedBox(height: 20),

        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: _isLoading ? null : _validateAndSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.textBlack,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26),
              ),
            ),
            child: Text(
              _isLoading
                  ? 'Saving...'
                  : widget.existing == null
                      ? 'Add Address'
                      : 'Update Address',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: AppColors.backgroundWhite,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
