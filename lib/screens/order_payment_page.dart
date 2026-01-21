import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:first/widgets/widgets.dart';

class OrderPaymentPage extends StatefulWidget {
  const OrderPaymentPage({super.key});

  @override
  State<OrderPaymentPage> createState() => _OrderPaymentPageState();
}

class _OrderPaymentPageState extends State<OrderPaymentPage> {
  String paymentType = "full"; // full / advance
  String paymentMethod = "bank"; // bank / card

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "Order Payment",
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
                  CardContainerWidget(
                    child: PaymentOptionSelector(
                      value: paymentType,
                      onChanged: (v) {
                        setState(() {
                          paymentType = v;
                          if (v == "advance") {
                            paymentMethod = "bank"; // credit hide
                          }
                        });
                      },
                    ),
                  ),
                  CardContainerWidget(
                    child: PaymentMethodSelector(
                      paymentType: paymentType,
                      value: paymentMethod,
                      onChanged: (v) {
                        setState(() => paymentMethod = v);
                      },
                    ),
                  ),
                  CardContainerWidget(
                    child: paymentMethod == "bank"
                        ? const BankTransferSection()
                        : const CreditCardSection(),
                  ),
                  const SizedBox(height: 28),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: PrimaryBtnWidget(
              width: double.infinity,
              buttonText: "Next",
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: const [
          StepCircle(active: true, label: "DELIVERY", done: true),
          StepLineWidget(isActive: true),
          StepCircle(active: true, label: "ADDRESS", done: true),
          StepLineWidget(isActive: true),
          StepCircle(active: true, label: "PAYMENT", stepNumber: 3),
        ],
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
        SectionTitleWidget(text: "Choose Payment Option"),
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

/// ================= PAYMENT METHOD =================
class PaymentMethodSelector extends StatelessWidget {
  final String paymentType;
  final String value;
  final ValueChanged<String> onChanged;

  const PaymentMethodSelector({
    super.key,
    required this.paymentType,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitleWidget(text: "Payment Method"),
        _methodTile("Bank Transfer", "bank"),
        if (paymentType == "full") _methodTile("Credit Card", "card"),
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitleWidget(text: "Payment Details"),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
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
          decoration: const InputDecoration(labelText: "Account Holder Name"),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: accCtrl,
          decoration: const InputDecoration(labelText: "Account Number"),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: _pickFile,
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.upload_file, color: Colors.grey),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    proofName ?? "Payment Proof (Screenshot)",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: proofName == null ? Colors.grey : Colors.black,
                    ),
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
class CreditCardSection extends StatelessWidget {
  const CreditCardSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitleWidget(text: "Card Details"),
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
        TextField(decoration: const InputDecoration(labelText: "Card Number")),
        const SizedBox(height: 12),
        TextField(
          decoration: const InputDecoration(labelText: "Expiry Date (MM/YY)"),
        ),
        const SizedBox(height: 12),
        TextField(decoration: const InputDecoration(labelText: "CVV")),
      ],
    );
  }
}

/// End of file
