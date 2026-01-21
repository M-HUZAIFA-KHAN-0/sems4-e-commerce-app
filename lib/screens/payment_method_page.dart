import 'package:flutter/material.dart';
import 'package:first/widgets/widgets.dart';
import '../app_colors.dart';

class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({super.key});

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  String _selectedPaymentMethod = 'credit_card';
  bool _saveCard = true;

  final _nameController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _monthYearController = TextEditingController();
  final _cvvController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _cardNumberController.dispose();
    _monthYearController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black87,
            size: 20,
          ),
        ),
        title: const Text(
          'Payment Method',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: false,
    ),
    body:
    SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          // Progress Indicator
          _buildProgressIndicator(),
          const SizedBox(height: 24),
          // Payment Methods Selection
          _buildPaymentMethodSelection(),
          const SizedBox(height: 24),
          // Payment Form
          _buildPaymentForm(),
          const SizedBox(height: 24),
        ],
      ),
    )
    );
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // Delivery Step
          Column(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: AppColors.primaryGreen,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: AppColors.backgroundWhite, size: 18),
              ),
              const SizedBox(height: 8),
              const Text(
                'DELIVERY',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          // Connector Line 1
          Expanded(
            child: Container(
              height: 2,
              margin: const EdgeInsets.only(top: 16),
              color: AppColors.primaryGreen,
            ),
          ),
          // Address Step
          Column(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: AppColors.primaryGreen,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: AppColors.backgroundWhite, size: 18),
              ),
              const SizedBox(height: 8),
              const Text(
                'ADDRESS',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          // Connector Line 2
          Expanded(
            child: Container(
              height: 2,
              margin: const EdgeInsets.only(top: 16),
              color: AppColors.primaryGreen,
            ),
          ),
          // Payment Step
          Column(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: AppColors.primaryGreen,
                  shape: BoxShape.circle,
                ),
                child: const Text(
                  '3',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'PAYMENT',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryGreen,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodSelection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildPaymentOption('Paypal', 'paypal', Icons.account_balance_wallet),
          _buildPaymentOption('Credit Card', 'credit_card', Icons.credit_card),
          _buildPaymentOption('Apple pay', 'apple_pay', Icons.apple),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(String label, String value, IconData icon) {
    final isSelected = _selectedPaymentMethod == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedPaymentMethod = value),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF2196F3) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? AppColors.primaryBlue : Colors.grey[300]!,
                width: 2,
              ),
            ),
            child: Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey[600],
              size: 32,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isSelected ? AppColors.primaryBlue : Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Credit Card Display
          _buildCreditCardDisplay(),
          const SizedBox(height: 24),
          // Name on Card Field
          buildFormField(
            controller: _nameController,
            label: 'Name on the card',
            icon: Icons.person,
            hintText: 'Enter card holder name',
          ),
          const SizedBox(height: 16),
          // Card Number Field
          buildFormField(
            controller: _cardNumberController,
            label: 'Card number',
            icon: Icons.credit_card,
            hintText: 'Enter card number',
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          // Month/Year and CVV Row
          Row(
            children: [
              Expanded(
                child: buildFormField(
                  controller: _monthYearController,
                  label: 'Month / Year',
                  icon: Icons.calendar_today,
                  hintText: 'MM/YY',
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: buildFormField(
                  controller: _cvvController,
                  label: 'CVV',
                  icon: Icons.lock,
                  hintText: 'CVV',
                  keyboardType: TextInputType.number,
                  isPassword: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Save Card Toggle
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: _saveCard ? const Color(0xFF4CAF50) : Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: _saveCard
                        ? const Color(0xFF4CAF50)
                        : Colors.grey[300]!,
                  ),
                ),
                child: _saveCard
                    ? const Icon(Icons.check, color: Colors.white, size: 16)
                    : null,
              ),
              const SizedBox(width: 12),
              const Text(
                'Save this card',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => setState(() => _saveCard = !_saveCard),
                child: Container(
                  width: 50,
                  height: 24,
                  decoration: BoxDecoration(
                    color: _saveCard
                        ? const Color(0xFF4CAF50)
                        : Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 200),
                        right: _saveCard ? 2 : null,
                        left: _saveCard ? null : 2,
                        top: 2,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: AppColors.backgroundWhite,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Make Payment Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _processPayment,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Make a payment',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreditCardDisplay() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF7CB342), Color(0xFF9CCC65)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 24),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.backgroundWhite.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.credit_card, color: AppColors.backgroundWhite),
              ),
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCardDigits(),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.backgroundWhite.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.payment, color: AppColors.backgroundWhite),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'CARD HOLDER',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _nameController.text.isEmpty
                        ? 'NASRULL AUSTIN'
                        : _nameController.text.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.backgroundWhite,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'VALID THRU',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _monthYearController.text.isEmpty
                        ? '09/25'
                        : _monthYearController.text,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.backgroundWhite,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCardDigits() {
    final cardNumber = _cardNumberController.text.isEmpty
        ? 'XXXX XXXX XXXX B780'
        : _cardNumberController.text;
    return Text(
      cardNumber,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        letterSpacing: 2,
      ),
    );
  }

  void _processPayment() {
    if (_nameController.text.isEmpty ||
        _cardNumberController.text.isEmpty ||
        _monthYearController.text.isEmpty ||
        _cvvController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: AppColors.accentRed,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Payment processed successfully!'),
        backgroundColor: Color(0xFF4CAF50),
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pop(context);
      }
    });
  }
}
