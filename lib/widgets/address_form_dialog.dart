import 'package:first/screens/address_drawer_form.dart';
import 'package:first/widgets/widgets.dart';
import 'package:flutter/material.dart';

/// Reusable Address Form Dialog
/// Handles both Add and Update operations for addresses
class AddressFormDialog extends StatelessWidget {
  final Map<String, String>? editingAddr;
  final int? index;
  final List<Map<String, String>> addresses;
  final VoidCallback onSave;

  const AddressFormDialog({
    super.key,
    this.editingAddr,
    this.index,
    required this.addresses,
    required this.onSave,
  });

  void _handleDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return DeleteConfirmationDialog(
          title: 'Delete Address',
          content: 'Are you sure you want to delete this address?',
          onConfirm: () {
            if (index != null) {
              addresses.removeAt(index!);
            }
            Navigator.pop(context); // Close dialog
            Navigator.pop(context); // Close bottom sheet
            onSave();
          },
        );
      },
    );
  }

  void _handleSave(
    BuildContext context,
    Map<String, String> newMap,
    bool isDefault,
  ) {
    if (isDefault) {
      for (var addr in addresses) {
        addr['tag'] = '';
      }
      newMap['tag'] = 'Default';
    } else {
      newMap['tag'] = '';
    }

    if (index != null) {
      addresses[index!] = newMap;
    } else {
      addresses.add(newMap);
    }

    onSave();
    Navigator.pop(context);
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
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: ListView(
            controller: scrollController,
            children: [
              // Header
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
                    if (editingAddr != null) ...[
                      Center(
                        child: IconButton(
                          onPressed: () => _handleDelete(context),
                          icon: const Icon(
                            Icons.delete,
                            size: 34,
                            color: Colors.black,
                          ),
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              // Form
              Padding(
                padding: const EdgeInsets.all(16),
                child: AddressForm(
                  existing: editingAddr,
                  onSave: (newMap, isDefault) {
                    _handleSave(context, newMap, isDefault);
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
