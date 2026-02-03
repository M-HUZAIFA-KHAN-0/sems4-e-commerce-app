import 'package:first/core/app_imports.dart';

class OrderPaymentPage extends StatefulWidget {
  final int orderId;
  final double itemsTotalAmount;
  final double shippingPrice;

  const OrderPaymentPage({
    required this.orderId,
    required this.itemsTotalAmount,
    required this.shippingPrice,
    super.key,
  });

  @override
  State<OrderPaymentPage> createState() => _OrderPaymentPageState();
}

class _OrderPaymentPageState extends State<OrderPaymentPage> {
  final PaymentService _paymentService = PaymentService();
  final ShipmentService _shipmentService = ShipmentService();
  final UserSessionManager _sessionManager = UserSessionManager();

  String paymentType = "full"; // full / advance
  String paymentMethod = "bank"; // bank / card
  int? selectedPaymentMethodId;

  bool _isLoadingMethods = true;
  bool _isProcessing = false;
  List<PaymentMethod> _paymentMethods = [];

  final GlobalKey<_BankTransferSectionState> _bankTransferKey =
      GlobalKey<_BankTransferSectionState>();
  final GlobalKey<_CreditCardSectionState> _creditCardKey =
      GlobalKey<_CreditCardSectionState>();

  double totalAmount = 0.0;

  @override
  void initState() {
    super.initState();
    _loadPaymentMethods();
    _loadTotalAmount();
  }

  /// Load total amount from passed parameters
  void _loadTotalAmount() {
    // Calculate total: items amount + shipping price
    totalAmount = widget.itemsTotalAmount + widget.shippingPrice;
    print('💰 [OrderPaymentPage] Total Calculation:');
    print('   Items Total: ${widget.itemsTotalAmount}');
    print('   Shipping: ${widget.shippingPrice}');
    print('   Grand Total: $totalAmount');
  }

  /// Load payment methods from API
  Future<void> _loadPaymentMethods() async {
    try {
      print('🔄 [OrderPaymentPage] Loading payment methods...');
      final methods = await _paymentService.getPaymentMethods();

      if (!mounted) return;

      if (methods != null) {
        setState(() {
          _paymentMethods = methods;
          _isLoadingMethods = false;
          // Auto-select first payment method
          if (methods.isNotEmpty) {
            selectedPaymentMethodId = methods.first.paymentMethodId;
          }
        });
        print('✅ [OrderPaymentPage] Loaded ${methods.length} payment methods');
      } else {
        setState(() => _isLoadingMethods = false);
        _showError('Failed to load payment methods');
      }
    } catch (e) {
      print('❌ [OrderPaymentPage] Error loading payment methods: $e');
      if (mounted) {
        setState(() => _isLoadingMethods = false);
      }
      _showError('Error loading payment methods: $e');
    }
  }

  /// Validate payment details based on selected method
  bool _validatePaymentDetails() {
    if (selectedPaymentMethodId == null) {
      _showError('Please select a payment method');
      return false;
    }

    if (paymentMethod == "bank") {
      final isValid = _bankTransferKey.currentState?.validateDetails() ?? false;
      if (!isValid) {
        _showError('Please fill all bank transfer details');
        return false;
      }
    } else if (paymentMethod == "card") {
      final isValid = _creditCardKey.currentState?.validateDetails() ?? false;
      if (!isValid) {
        _showError('Please fill all credit card details');
        return false;
      }
    }

    return true;
  }

  /// Create payment via API
  Future<void> _onNextPressed() async {
    // Validate payment details
    if (!_validatePaymentDetails()) {
      return;
    }

    setState(() => _isProcessing = true);

    try {
      print('🔄 [OrderPaymentPage] Creating payment...');
      print('   OrderId: ${widget.orderId}');
      print('   PaymentMethodId: $selectedPaymentMethodId');
      print('   Amount: $totalAmount');

      final result = await _paymentService.createPayment(
        orderId: widget.orderId,
        paymentMethodId: selectedPaymentMethodId ?? 0,
        amount: totalAmount,
      );

      if (!mounted) return;

      if (result != null && result['success'] == true) {
        print('✅ [OrderPaymentPage] Payment created successfully!');
        print('   PaymentId: ${result['paymentId']}');

        // 🚚 Create Shipment after successful payment
        print('🔄 [OrderPaymentPage] Creating shipment...');
        final shipmentResult = await _shipmentService.createShipment(
          orderId: widget.orderId,
          courierName: "Standard Courier", // Default courier name
          shippingPrice: widget.shippingPrice,
        );

        if (shipmentResult != null && shipmentResult['success'] == true) {
          print('✅ [OrderPaymentPage] Shipment created successfully!');
          print('   ShipmentId: ${shipmentResult['shipmentId']}');
          print('   TrackingNumber: ${shipmentResult['trackingNumber']}');
        } else {
          print('⚠️ [OrderPaymentPage] Warning: Shipment creation failed');
          print('   Message: ${shipmentResult?['message']}');
        }

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Payment processed successfully'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 1),
          ),
        );

        // Wait a moment then navigate to receipt
        await Future.delayed(const Duration(milliseconds: 500));
        if (!mounted) return;

        // Navigate to order confirmation
        // final orderReceiptPage = OrderReceiptPage(
        //   orderNumber: '${widget.orderId}',
        //   productName: 'Product Name',
        //   productPrice: '$totalAmount',
        //   productColor: 'Color',
        //   productImage: '',
        //   orderData: {
        //     'name': _sessionManager.userName ?? 'Customer',
        //     'email': _sessionManager.userEmail ?? '',
        //     'phone': '',
        //     'cnic': '',
        //     'province': '',
        //     'city': '',
        //     'area': '',
        //     'address': '',
        //     'shippingCost': '0',
        //     'expectedDelivery': 'Processing...',
        //     'totalPrice': '$totalAmount',
        //     'paidAmount': '$totalAmount',
        //   },
        // );

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => OrderConfirmationSuccessScreen(
              // targetPage: orderReceiptPage,
              targetPage: const MyHomePage(),
              message: 'Your payment has been processed successfully',
              displayDuration: const Duration(seconds: 2),
            ),
          ),
        );
      } else {
        _showError(result?['message'] ?? 'Failed to process payment');
      }
    } catch (e) {
      print('❌ [OrderPaymentPage] Error: $e');
      _showError('Error: $e');
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
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
          'Order Payment',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  _buildProgressIndicator(),
                  const SizedBox(height: 16),
                  if (_isLoadingMethods)
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    )
                  else ...[
                    CardContainerWidget(
                      child: PaymentOptionSelector(
                        value: paymentType,
                        onChanged: (v) {
                          setState(() {
                            paymentType = v;
                            if (v == "advance") {
                              paymentMethod = "bank";
                            }
                          });
                          // Update payment method ID when payment option changes
                          _updateSelectedPaymentMethod();
                        },
                      ),
                    ),
                    CardContainerWidget(
                      child: PaymentMethodSelectorNew(
                        paymentType: paymentType,
                        value: paymentMethod,
                        onChanged: (v) {
                          setState(() => paymentMethod = v);
                          // Update selected payment method ID based on selection
                          _updateSelectedPaymentMethod();
                        },
                        paymentMethods: _paymentMethods,
                        selectedPaymentMethodId: selectedPaymentMethodId,
                      ),
                    ),
                    CardContainerWidget(
                      child: paymentMethod == "bank"
                          ? BankTransferSection(key: _bankTransferKey)
                          : CreditCardSection(key: _creditCardKey),
                    ),
                    const SizedBox(height: 16),
                    _buildTotalAmountStrip(),
                  ],
                  const SizedBox(height: 28),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: _isProcessing
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
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      ),
                    ),
                  )
                : PrimaryBtnWidget(
                    width: double.infinity,
                    buttonText: "Complete Payment",
                    onPressed: _onNextPressed,
                  ),
          ),
        ],
      ),
    );
  }

  /// Update selected payment method based on current selections
  void _updateSelectedPaymentMethod() {
    // Map payment type and method to payment method ID
    // Format: "Full Payment | Bank Transfer" = 1, etc.
    final paymentTypeText = paymentType == "full"
        ? "Full Payment"
        : "Advance Payment";
    final paymentMethodText = paymentMethod == "bank"
        ? "Bank Transfer"
        : "Credit Card";
    final methodName = "$paymentTypeText | $paymentMethodText";

    print('🔄 [DEBUG] Looking for method: $methodName');
    print(
      '🔄 [DEBUG] Available methods: ${_paymentMethods.map((m) => '${m.paymentMethodId}:${m.methodName}').join(', ')}',
    );

    // Find matching payment method ID
    final method = _paymentMethods.firstWhere(
      (m) => m.methodName == methodName,
      orElse: () => _paymentMethods.isNotEmpty
          ? _paymentMethods.first
          : PaymentMethod(paymentMethodId: 0, methodName: ""),
    );

    setState(() {
      selectedPaymentMethodId = method.paymentMethodId;
    });

    print(
      '🔄 [OrderPaymentPage] Selected payment method: $methodName (ID: ${method.paymentMethodId})',
    );
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: const [
          StepCircle(active: true, label: "DELIVERY", done: true),
          StepLine(active: true),
          StepCircle(active: true, label: "ADDRESS", done: true),
          StepLine(active: true),
          StepCircle(active: true, label: "PAYMENT", stepNumber: 3),
        ],
      ),
    );
  }

  /// Build total amount strip showing items, shipping, and grand total
  Widget _buildTotalAmountStrip() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Summary',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            // Items total row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Items Total',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
                Text(
                  'Rs ${widget.itemsTotalAmount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Shipping total row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Shipping',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
                Text(
                  'Rs ${widget.shippingPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Divider
            Divider(color: Colors.grey.shade300, thickness: 1, height: 16),
            // Grand total row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Grand Total',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  'Rs ${totalAmount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.bgPrimaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// ================= PAYMENT OPTION =================
class PaymentOptionSelector extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;

  const PaymentOptionSelector({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Choose Payment Option",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 12),
        _radioTile("Full Payment", "full"),
        _radioTile("Advance Payment", "advance"),
      ],
    );
  }

  Widget _radioTile(String title, String val) {
    return RadioTileWidget(
      label: title,
      isSelected: value == val,
      onTap: () => onChanged(val),
    );
  }
}

/// ================= PAYMENT METHOD (UPDATED) =================
class PaymentMethodSelectorNew extends StatelessWidget {
  final String paymentType;
  final String value;
  final ValueChanged<String> onChanged;
  final List<PaymentMethod> paymentMethods;
  final int? selectedPaymentMethodId;

  const PaymentMethodSelectorNew({
    super.key,
    required this.paymentType,
    required this.value,
    required this.onChanged,
    required this.paymentMethods,
    this.selectedPaymentMethodId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Payment Method",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        _methodTile("Bank Transfer", "bank"),
        if (paymentType == "full") _methodTile("Credit Card", "card"),
        const SizedBox(height: 8),
        Text(
          'Selected Method ID: $selectedPaymentMethodId',
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _methodTile(String title, String val) {
    return RadioTileWidget(
      label: title,
      isSelected: value == val,
      onTap: () => onChanged(val),
    );
  }
}

/// ================= BANK TRANSFER =================
class BankTransferSection extends StatefulWidget {
  const BankTransferSection({super.key});

  @override
  State<BankTransferSection> createState() => _BankTransferSectionState();
}

class _BankTransferSectionState extends State<BankTransferSection> {
  final nameCtrl = TextEditingController();
  final accCtrl = TextEditingController();
  File? proof;
  String? proofName;

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );

    if (result != null) {
      setState(() {
        proof = File(result.files.single.path!);
        proofName = result.files.single.name;
      });
    }
  }

  /// Validate all bank transfer details
  bool validateDetails() {
    if (nameCtrl.text.trim().isEmpty) {
      print('❌ [BankTransfer] Account holder name is empty');
      return false;
    }
    if (accCtrl.text.trim().isEmpty) {
      print('❌ [BankTransfer] Account number is empty');
      return false;
    }
    if (proof == null) {
      print('❌ [BankTransfer] Payment proof not selected');
      return false;
    }
    print('✅ [BankTransfer] All details validated');
    return true;
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    accCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Payment Details",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: AppColors.tooLightGradientColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Bank Name: Test Bank\n"
                "Account Title: Laptop Harbor\n"
                "Account Number: 1234567890",
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 12),
              NoteBoxWidget(
                message:
                    "In case of non-payment, your order will be automatically cancelled after 4 hours.",
                backgroundColor: Colors.orange.shade50,
                textColor: Colors.orange.shade900,
                borderColor: Colors.orange.shade300,
                icon: Icons.info_outline,
                iconColor: Colors.orange,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: nameCtrl,
          decoration: const InputDecoration(
            labelText: "Account Holder Name *",
            hintText: "Your name",
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: accCtrl,
          decoration: const InputDecoration(
            labelText: "Account Number *",
            hintText: "Your account number",
          ),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: _pickFile,
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              border: Border.all(
                color: proof == null ? Colors.grey.shade400 : Colors.green,
                width: proof == null ? 1 : 2,
              ),
              borderRadius: BorderRadius.circular(8),
              color: proof == null ? Colors.white : Colors.green.shade50,
            ),
            child: Row(
              children: [
                Icon(
                  proof == null ? Icons.upload_file : Icons.check_circle,
                  color: proof == null ? Colors.grey : Colors.green,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        proofName ?? "Payment Proof (Screenshot) *",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: proofName == null
                              ? Colors.grey
                              : AppColors.textBlack,
                        ),
                      ),
                      if (proofName != null)
                        Text(
                          '✓ File selected',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.green.shade700,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// ================= CREDIT CARD =================
class CreditCardSection extends StatefulWidget {
  const CreditCardSection({super.key});

  @override
  State<CreditCardSection> createState() => _CreditCardSectionState();
}

class _CreditCardSectionState extends State<CreditCardSection> {
  final cardNumberCtrl = TextEditingController();
  final expiryCtrl = TextEditingController();
  final cvvCtrl = TextEditingController();

  /// Validate all credit card details
  bool validateDetails() {
    if (cardNumberCtrl.text.trim().isEmpty) {
      print('❌ [CreditCard] Card number is empty');
      return false;
    }
    if (cardNumberCtrl.text.length < 13) {
      print('❌ [CreditCard] Card number is too short');
      return false;
    }
    if (expiryCtrl.text.trim().isEmpty) {
      print('❌ [CreditCard] Expiry date is empty');
      return false;
    }
    if (cvvCtrl.text.trim().isEmpty) {
      print('❌ [CreditCard] CVV is empty');
      return false;
    }
    if (cvvCtrl.text.length < 3) {
      print('❌ [CreditCard] CVV is invalid');
      return false;
    }
    print('✅ [CreditCard] All details validated');
    return true;
  }

  @override
  void dispose() {
    cardNumberCtrl.dispose();
    expiryCtrl.dispose();
    cvvCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Card Details",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        NoteBoxWidget(
          message:
              "Processing fee of 2% will be applied for credit card payments.",
          backgroundColor: Colors.orange.shade50,
          textColor: Colors.orange.shade900,
          borderColor: Colors.orange.shade300,
          icon: Icons.info_outline,
          iconColor: Colors.orange,
          padding: const EdgeInsets.all(12),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: cardNumberCtrl,
          decoration: const InputDecoration(
            labelText: "Card Number *",
            hintText: "1234 5678 9012 3456",
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: expiryCtrl,
                decoration: const InputDecoration(
                  labelText: "Expiry Date *",
                  hintText: "MM/YY",
                ),
                keyboardType: TextInputType.datetime,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: cvvCtrl,
                decoration: const InputDecoration(
                  labelText: "CVV *",
                  hintText: "123",
                ),
                keyboardType: TextInputType.number,
                obscureText: true,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// End of file
}
