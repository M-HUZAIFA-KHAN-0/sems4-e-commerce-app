import 'package:first/screens/order_payment_page.dart';
import 'package:first/core/app_imports.dart';
import 'package:first/models/address_model.dart';

class OrderAddressConfirmPage extends StatefulWidget {
  final int orderId;
  final double itemsTotalAmount;
  final double shippingPrice;

  const OrderAddressConfirmPage({
    required this.orderId,
    required this.itemsTotalAmount,
    required this.shippingPrice,
    super.key,
  });

  @override
  State<OrderAddressConfirmPage> createState() =>
      _OrderAddressConfirmPageState();
}

class _OrderAddressConfirmPageState extends State<OrderAddressConfirmPage> {
  final AddressService _addressService = AddressService();
  final OrderAddressService _orderAddressService = OrderAddressService();
  final UserSessionManager _sessionManager = UserSessionManager();

  // Global keys to access nested widget state
  final _deliveryAddressSelectorKey =
      GlobalKey<_DeliveryAddressSelectorState>();
  final _contactInfoSectionKey = GlobalKey<_ContactInfoSectionState>();

  List<AddressModel> _addresses = [];
  bool _isLoading = true;
  bool _isSavingOrderAddress = false;

  @override
  void initState() {
    super.initState();
    _loadAddresses();
  }

  /// Load addresses from API
  Future<void> _loadAddresses() async {
    try {
      final userId = _sessionManager.userId;
      if (userId == null || userId <= 0) {
        setState(() => _isLoading = false);
        return;
      }

      print('🔄 [OrderAddressConfirm] Loading addresses for userId: $userId');
      final addresses = await _addressService.getAddressesByUserId(userId);

      if (!mounted) return;

      setState(() {
        _addresses = addresses;
        _isLoading = false;
      });
      print('✅ [OrderAddressConfirm] Loaded ${addresses.length} addresses');
    } catch (e) {
      print('❌ [OrderAddressConfirm] Error loading addresses: $e');
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showAddressForm({AddressModel? editingAddr}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (context) {
        return AddressFormDialog(
          editingAddr: editingAddr?.toDisplayMap(),
          onSave: (String? message) {
            if (message != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: message.startsWith('✅')
                      ? Colors.green
                      : Colors.red,
                ),
              );
            }
            // Reload addresses
            _loadAddresses();
          },
        );
      },
    );
  }

  /// ✅ CREATE ORDER ADDRESS AND NAVIGATE
  Future<void> _onNextPressed() async {
    // Get data from nested widgets
    final selectedAddressId = _deliveryAddressSelectorKey.currentState
        ?.getSelectedAddressId();
    final fullName = _contactInfoSectionKey.currentState?.getFullName() ?? '';
    final phone = _contactInfoSectionKey.currentState?.getPhone() ?? '';

    // Validation
    if (selectedAddressId == null || selectedAddressId.isEmpty) {
      _showError('Please select a delivery address');
      return;
    }

    if (fullName.isEmpty) {
      _showError('Please enter recipient name');
      return;
    }

    if (phone.isEmpty) {
      _showError('Please enter phone number');
      return;
    }

    setState(() => _isSavingOrderAddress = true);

    try {
      print('🔄 [OrderAddressConfirm] Creating order address...');
      final addressId = int.tryParse(selectedAddressId) ?? 0;

      final result = await _orderAddressService.createOrderAddress(
        orderId: widget.orderId,
        addressId: addressId,
        recipientName: fullName,
        phone: phone,
      );

      if (!mounted) return;

      if (result != null && result['success'] == true) {
        print('✅ [OrderAddressConfirm] Order address created successfully!');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Address saved successfully'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 1),
          ),
        );

        // Navigate to Payment Page after a short delay
        await Future.delayed(const Duration(milliseconds: 500));
        if (!mounted) return;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderPaymentPage(
              orderId: widget.orderId,
              itemsTotalAmount: widget.itemsTotalAmount,
              shippingPrice: widget.shippingPrice,
            ),
          ),
        );
      } else {
        _showError(result?['message'] ?? 'Failed to save order address');
      }
    } catch (e) {
      print('❌ [OrderAddressConfirm] Error: $e');
      _showError('Error: $e');
    } finally {
      if (mounted) {
        setState(() => _isSavingOrderAddress = false);
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGreyLight,
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
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          _buildProgressIndicator(),
                          const SizedBox(height: 16),
                          _DeliveryAddressSelector(
                            key: _deliveryAddressSelectorKey,
                            addresses: _addresses,
                            onAddAddress: () => _showAddressForm(),
                            onUpdateAddresses: _loadAddresses,
                          ),
                          _ContactInfoSection(key: _contactInfoSectionKey),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: _isSavingOrderAddress
                        ? ElevatedButton(
                            onPressed: null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.bgPrimaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            child: const SizedBox(
                              height: 50,
                              child: Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(
                                    Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : PrimaryBtnWidget(
                            onPressed: _onNextPressed,
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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

class _ContactInfoSection extends StatefulWidget {
  const _ContactInfoSection({super.key});

  @override
  State<_ContactInfoSection> createState() => _ContactInfoSectionState();
}

class _ContactInfoSectionState extends State<_ContactInfoSection> {
  bool isEditing = false;
  bool _isLoading = true;

  final UserProfileService _userService = UserProfileService();
  final UserSessionManager _sessionManager = UserSessionManager();

  late TextEditingController nameController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    _loadUserData();
  }

  /// Load user data from API
  Future<void> _loadUserData() async {
    try {
      final userId = _sessionManager.userId;
      if (userId == null || userId <= 0) {
        setState(() => _isLoading = false);
        return;
      }

      print('🔄 [ContactInfo] Loading user data for userId: $userId');
      final userData = await _userService.fetchUserData(userId: userId);

      if (!mounted) return;

      if (userData != null) {
        final firstName = userData.firstName ?? '';
        final lastName = userData.lastName ?? '';
        final phoneNumber = userData.phoneNumber ?? '';

        nameController.text = '$firstName $lastName'.trim();
        phoneController.text = phoneNumber;

        setState(() => _isLoading = false);
        print('✅ [ContactInfo] User data loaded: $firstName $lastName');
      } else {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      print('❌ [ContactInfo] Error loading user data: $e');
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

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
          const SizedBox(height: 14),
          if (_isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: CircularProgressIndicator(),
              ),
            )
          else
            Column(
              children: [
                TextField(
                  controller: nameController,
                  enabled: isEditing,
                  decoration: const InputDecoration(
                    labelText: "Full Name",
                    isDense: true,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.bgPrimaryColor,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: phoneController,
                  enabled: isEditing,
                  decoration: const InputDecoration(
                    labelText: "Mobile Number",
                    isDense: true,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.bgPrimaryColor,
                        width: 2,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ],
            ),
        ],
      ),
    );
  }

  /// Get current form data
  String getFullName() => nameController.text;
  String getPhone() => phoneController.text;
}

/// ---------------- DELIVERY ADDRESS (SELECTOR) ----------------
class _DeliveryAddressSelector extends StatefulWidget {
  final List<AddressModel> addresses;
  final VoidCallback? onAddAddress;
  final VoidCallback? onUpdateAddresses;

  const _DeliveryAddressSelector({
    required this.addresses,
    this.onAddAddress,
    this.onUpdateAddresses,
    super.key,
  });

  @override
  State<_DeliveryAddressSelector> createState() =>
      _DeliveryAddressSelectorState();
}

class _DeliveryAddressSelectorState extends State<_DeliveryAddressSelector> {
  String? _selectedAddressId;

  @override
  void initState() {
    super.initState();
    _setDefaultAddress();
  }

  @override
  void didUpdateWidget(_DeliveryAddressSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.addresses != oldWidget.addresses) {
      _setDefaultAddress();
    }
  }

  /// Auto-select default address from API
  void _setDefaultAddress() {
    if (widget.addresses.isEmpty) {
      _selectedAddressId = null;
      return;
    }

    // First try to find the default address
    try {
      final defaultAddr = widget.addresses.firstWhere(
        (a) => a.isDefault == true,
      );
      _selectedAddressId = defaultAddr.addressId?.toString();
      print(
        '✅ [DeliveryAddressSelector] Default address auto-selected: ${defaultAddr.label}',
      );
    } catch (e) {
      // If no default found, select the first address
      _selectedAddressId = widget.addresses.first.addressId?.toString();
      print(
        '🔄 [DeliveryAddressSelector] No default address, selected first: ${widget.addresses.first.label}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final addresses = widget.addresses;

    return CardContainerWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleIconRowWidget(
            title: "Delivery Information",
            icon: Icons.add,
            onTap: widget.onAddAddress ?? () {},
          ),
          const SizedBox(height: 14),
          _buildAddressDropdown(addresses),
        ],
      ),
    );
  }

  Widget _buildAddressDropdown(List<AddressModel> addresses) {
    if (addresses.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
        ),
        child: const Text(
          'No addresses available. Add a new address.',
          style: TextStyle(color: Colors.grey, fontSize: 13),
        ),
      );
    }

    return DropdownButtonFormField<String>(
      value: _selectedAddressId,
      hint: const Text("Select delivery address"),
      isExpanded: true,
      elevation: 0,

      // 👇 Dropdown items (label + address + tag)
      items: addresses.map((AddressModel addr) {
        final displayMap = addr.toDisplayMap();
        final addressId = addr.addressId?.toString();
        return DropdownMenuItem<String>(
          value: addressId,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                displayMap['label'] ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              if ((displayMap['tag'] ?? '').isNotEmpty)
                Text(
                  displayMap['tag'] ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                ),
              Text(
                displayMap['address'] ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        );
      }).toList(),

      // 👇 Selected item display (ONLY address)
      selectedItemBuilder: (context) {
        return addresses.map((AddressModel addr) {
          final displayMap = addr.toDisplayMap();
          return Align(
            alignment: Alignment.centerLeft,
            child: Text(
              displayMap['address'] ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13),
            ),
          );
        }).toList();
      },

      onChanged: (value) {
        if (value != null) {
          setState(() => _selectedAddressId = value);
          print('🔄 [DeliveryAddressSelector] Address changed to ID: $value');
        }
      },

      decoration: const InputDecoration(
        isDense: true,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.bgPrimaryColor, width: 2),
        ),
      ),
    );
  }

  /// Get selected address ID
  String? getSelectedAddressId() => _selectedAddressId;
}

/// End of file
