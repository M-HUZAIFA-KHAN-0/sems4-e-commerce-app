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
                  _card(
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
                  _card(
                    child: PaymentMethodSelector(
                      paymentType: paymentType,
                      value: paymentMethod,
                      onChanged: (v) {
                        setState(() => paymentMethod = v);
                      },
                    ),
                  ),
                  _card(
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
          _StepLine(active: true),
          StepCircle(active: true, label: "ADDRESS", done: true),
          _StepLine(active: true),
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
        const _SectionTitle("Choose Payment Option"),
        _radioTile("Full Payment", "full"),
        _radioTile("Advance Payment", "advance"),
      ],
    );
  }

  Widget _radioTile(String title, String val) {
    return GestureDetector(
      onTap: () => onChanged(val),
      child: _radioBox(title, value == val),
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
        const _SectionTitle("Payment Method"),
        _methodTile("Bank Transfer", "bank"),
        if (paymentType == "full") _methodTile("Credit Card", "card"),
      ],
    );
  }

  Widget _methodTile(String title, String val) {
    return GestureDetector(
      onTap: () => onChanged(val),
      child: _radioBox(title, value == val),
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
        const _SectionTitle("Payment Details"),
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

              /// 🔔 NOTE BOX
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50, // 👈 NOTE BG COLOR
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.orange.shade300),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.info_outline,
                      size: 18,
                      color: Colors.orange,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "In case of non-payment, your order will be automatically cancelled after 4 hours.",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.orange.shade900,
                        ),
                      ),
                    ),
                  ],
                ),
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
    const _SectionTitle("Card Details"),

    /// 🔔 NOTE BOX
    Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: Colors.orange.shade300,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline,
            size: 18,
            color: Colors.orange,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              "Processing fee of 2% will be applied for credit card payments.",
              style: TextStyle(
                fontSize: 12,
                color: Colors.orange.shade900,
              ),
            ),
          ),
        ],
      ),
    ),
    const SizedBox(height: 16),
    TextField(
      decoration: const InputDecoration(
        labelText: "Card Number",
      ),
    ),
    const SizedBox(height: 12),

    TextField(
      decoration: const InputDecoration(
        labelText: "Expiry Date (MM/YY)",
      ),
    ),
    const SizedBox(height: 12),

    TextField(
      decoration: const InputDecoration(
        labelText: "CVV",
      ),
    ),
  ],
);

  }
}

/// ================= REUSABLE =================
Widget _card({required Widget child}) {
  return Container(
    // margin: const EdgeInsets.all(12),
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
    ),
    child: child,
  );
}

Widget _radioBox(String title, bool active) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      border: Border.all(
        color: active ? Colors.blue : Colors.grey.shade300,
        width: active ? 2 : 1,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.blue),
          ),
          child: active
              ? const Center(
                  child: CircleAvatar(radius: 4, backgroundColor: Colors.blue),
                )
              : null,
        ),
        const SizedBox(width: 12),
        Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    ),
  );
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _StepLine extends StatelessWidget {
  final bool active;
  const _StepLine({required this.active});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.only(bottom: 18),
        color: active ? Colors.green : Colors.grey.shade300,
      ),
    );
  }
}
