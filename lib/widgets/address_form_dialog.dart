// import 'package:first/screens/address_drawer_form.dart';
// import 'package:first/core/app_imports.dart';

// /// Reusable Address Form Dialog
// /// Handles both Add and Update operations for addresses
// class AddressFormDialog extends StatelessWidget {
//   final Map<String, String>? editingAddr;
//   final int? index;
//   final List<Map<String, String>> addresses;
//   final VoidCallback onSave;

//   const AddressFormDialog({
//     super.key,
//     this.editingAddr,
//     this.index,
//     required this.addresses,
//     required this.onSave,
//   });

//   void _handleDelete(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (dialogContext) {
//         return DeleteConfirmationDialog(
//           title: 'Delete Address',
//           content: 'Are you sure you want to delete this address?',
//           onConfirm: () {
//             if (index != null) {
//               addresses.removeAt(index!);
//             }
//             Navigator.pop(context); // Close dialog
//             Navigator.pop(context); // Close bottom sheet
//             onSave();
//           },
//         );
//       },
//     );
//   }

//   void _handleSave(
//     BuildContext context,
//     Map<String, String> newMap,
//     bool isDefault,
//   ) {
//     if (isDefault) {
//       for (var addr in addresses) {
//         addr['tag'] = '';
//       }
//       newMap['tag'] = 'Default';
//     } else {
//       newMap['tag'] = '';
//     }

//     if (index != null) {
//       addresses[index!] = newMap;
//     } else {
//       addresses.add(newMap);
//     }

//     onSave();
//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DraggableScrollableSheet(
//       expand: false,
//       initialChildSize: 0.7,
//       minChildSize: 0.4,
//       maxChildSize: 1.0,
//       builder: (context, scrollController) {
//         return Container(
//           decoration: const BoxDecoration(
//             color: AppColors.backgroundWhite,
//             borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//           ),
//           child: ListView(
//             controller: scrollController,
//             children: [
//               // Header
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 8,
//                 ),
//                 child: Row(
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.arrow_back),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                     Expanded(
//                       child: Text(
//                         editingAddr == null
//                             ? 'Add New Address'
//                             : 'Edit Address',
//                         style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     if (editingAddr != null) ...[
//                       Center(
//                         child: IconButton(
//                           onPressed: () => _handleDelete(context),
//                           icon: const Icon(
//                             Icons.delete,
//                             size: 34,
//                             color: AppColors.textBlack,
//                           ),
//                           style: IconButton.styleFrom(
//                             backgroundColor: AppColors.backgroundWhite,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ],
//                 ),
//               ),
//               // Form
//               Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: AddressForm(
//                   existing: editingAddr,
//                   onSuccess: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:first/core/app_imports.dart';
import 'package:first/screens/address_drawer_form.dart';

/// Reusable Address Form Dialog
/// Handles Add, Update & Delete via API
class AddressFormDialog extends StatelessWidget {
  final Map<String, dynamic>? editingAddr;
  final Function(String?) onSave;

  const AddressFormDialog({super.key, this.editingAddr, required this.onSave});

  /// DELETE ADDRESS (API)
  Future<void> _handleDelete(BuildContext context) async {
    final addressId = editingAddr?['addressId'];
    if (addressId == null) return;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return DeleteConfirmationDialog(
          title: 'Delete Address',
          content: 'Are you sure you want to delete this address?',
          onConfirm: () async {
            Navigator.pop(dialogContext);

            try {
              final service = AddressService();
              final success = await service.deleteAddress(addressId);

              if (!context.mounted) return;

              if (success) {
                Navigator.pop(context); // close drawer
                onSave('✅ Address deleted successfully');
              } else {
                onSave('❌ Failed to delete address');
              }
            } catch (e) {
              onSave('❌ Delete failed: $e');
              print('❌ Delete failed: $e');
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      minChildSize: 0.4,
      maxChildSize: 1.0,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.backgroundWhite,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: ListView(
            controller: scrollController,
            children: [
              // HEADER
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Text(
                        editingAddr == null
                            ? 'Add New Address'
                            : 'Edit Address',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (editingAddr != null)
                      IconButton(
                        onPressed: () => _handleDelete(context),
                        icon: const Icon(
                          Icons.delete,
                          size: 28,
                          color: AppColors.textBlack,
                        ),
                      ),
                  ],
                ),
              ),

              // FORM
              Padding(
                padding: const EdgeInsets.all(16),
                child: AddressForm(
                  existing: editingAddr,
                  onSuccess: () {
                    Navigator.pop(context); // close drawer
                    onSave(null); // refresh addresses from API
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
