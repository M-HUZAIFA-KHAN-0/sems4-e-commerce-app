import 'package:first/screens/order_payment_page.dart';
import 'package:first/core/app_imports.dart';

class OrderAddressConfirmPage extends StatefulWidget {
  const OrderAddressConfirmPage({super.key});

  @override
  State<OrderAddressConfirmPage> createState() =>
      _OrderAddressConfirmPageState();
}

class _OrderAddressConfirmPageState extends State<OrderAddressConfirmPage> {
  List<Map<String, String>> addresses = [
    {
      'label': 'Home',
      'tag': 'Default',
      'address': 'R-196 sector 11c2 North Karachi',
    },
    {
      'label': 'Office',
      'tag': '',
      'address': 'House 24 Block B Gulshan-e-Iqbal',
    },
    {
      'label': 'Apartment',
      'tag': '',
      'address': 'Flat 12 PECHS Block 6 Karachi',
    },
  ];

  void _showAddressForm({Map<String, String>? editingAddr, int? index}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (context) {
        return AddressFormDialog(
          editingAddr: editingAddr,
          index: index,
          addresses: addresses,
          onSave: () => setState(() {}),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGreyLight, // ✅ PAGE GRAY BG
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios, color: Colors.black87),
        ),
        title: const Text(
          'Order Address Confirmation',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    _buildProgressIndicator(),
                    const SizedBox(height: 16),
                    const _DeliveryAddressSelector(),
                    const _ContactInfoSection(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: PrimaryBtnWidget(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OrderPaymentPage(),
                    ),
                  );
                },
                buttonText: "Next",
                width: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: const [
          StepCircle(active: true, label: "DELIVERY", done: true),
          StepLine(active: true),
          StepCircle(active: true, label: "ADDRESS", stepNumber: 2),
          StepLine(active: false),
          StepCircle(active: false, label: "PAYMENT", stepNumber: 3),
        ],
      ),
    );
  }
}

/// ---------------- CONTACT INFO (EDITABLE) ----------------
class _ContactInfoSection extends StatefulWidget {
  const _ContactInfoSection();

  @override
  State<_ContactInfoSection> createState() => _ContactInfoSectionState();
}

class _ContactInfoSectionState extends State<_ContactInfoSection> {
  bool isEditing = false;

  final nameController = TextEditingController(text: "Huzaifa Khan");
  final phoneController = TextEditingController(text: "03154699890");

  @override
  Widget build(BuildContext context) {
    return CardContainerWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleIconRowWidget(
            title: "Contact Information",
            icon: isEditing ? Icons.save : Icons.edit,
            onTap: () => setState(() => isEditing = !isEditing),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: nameController,
            enabled: isEditing,
            decoration: const InputDecoration(
              labelText: "Full Name",
              isDense: true,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: phoneController,
            enabled: isEditing,
            decoration: const InputDecoration(
              labelText: "Mobile Number",
              isDense: true,
            ),
            keyboardType: TextInputType.phone,
          ),
        ],
      ),
    );
  }
}

/// ---------------- DELIVERY ADDRESS (SELECTOR) ----------------
class _DeliveryAddressSelector extends StatefulWidget {
  const _DeliveryAddressSelector();

  @override
  State<_DeliveryAddressSelector> createState() =>
      _DeliveryAddressSelectorState();
}

class _DeliveryAddressSelectorState extends State<_DeliveryAddressSelector> {
  String? selectedAddress;

  @override
  Widget build(BuildContext context) {
    // Get addresses from parent state
    final parentState = context
        .findAncestorStateOfType<_OrderAddressConfirmPageState>();
    final addresses = parentState?.addresses ?? [];

    return CardContainerWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleIconRowWidget(
            title: "Delivery Information",
            icon: Icons.add,
            onTap: () {
              parentState?._showAddressForm();
            },
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: selectedAddress,
            hint: const Text("Select delivery address"),
            isExpanded: true,

            // 👇 Dropdown items (label + address)
            items: addresses.map((e) {
              return DropdownMenuItem<String>(
                value: e['label'],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      e['label'] ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      e['address'] ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              );
            }).toList(),

            // 👇 Selected item (ONLY address)
            selectedItemBuilder: (context) {
              return addresses.map((e) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    e['address'] ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13),
                  ),
                );
              }).toList();
            },

            onChanged: (value) {
              setState(() => selectedAddress = value);
            },

            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
        ],
      ),
    );
  }
}

/// End of file
