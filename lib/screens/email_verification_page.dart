import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  final _c1 = TextEditingController();
  final _c2 = TextEditingController();
  final _c3 = TextEditingController();
  final _c4 = TextEditingController();

  final _f1 = FocusNode();
  final _f2 = FocusNode();
  final _f3 = FocusNode();
  final _f4 = FocusNode();

  @override
  void dispose() {
    _c1.dispose();
    _c2.dispose();
    _c3.dispose();
    _c4.dispose();
    _f1.dispose();
    _f2.dispose();
    _f3.dispose();
    _f4.dispose();
    super.dispose();
  }

  void _onChanged() {
    final code = _c1.text + _c2.text + _c3.text + _c4.text;
    if (code.length == 4) {
      _verify(code);
    }
  }

  void _verify(String code) async {
    // Simulate verification delay
    FocusScope.of(context).unfocus();
    // TODO: Replace with real API call
    await Future.delayed(const Duration(milliseconds: 400));
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Verification successful')));
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  Widget _box(TextEditingController c, FocusNode f, FocusNode? next) {
    return SizedBox(
      width: 62,
      height: 62,
      child: TextField(
        controller: c,
        focusNode: f,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        maxLength: 1,
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.zero,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color.fromARGB(255, 153, 153, 153), width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.black, width: 1.5),
          ),
        ),
        onChanged: (v) {
          if (v.isNotEmpty) {
            if (next != null) {
              FocusScope.of(context).requestFocus(next);
            } else {
              FocusScope.of(context).unfocus();
            }
          }
          if (v.isEmpty) {
            // if user cleared, move focus back logic is handled by user
          }
          _onChanged();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                      onPressed: () => Navigator.maybePop(context),
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Icon(
                    Icons.email_outlined,
                    size: 74,
                    color: Colors.black,
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    'Email Verification',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Enter the 4-digit code sent to your email',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13, color: Color(0xFF9AA0A6)),
                  ),

                  const SizedBox(height: 22),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _box(_c1, _f1, _f2),
                      const SizedBox(width: 12),
                      _box(_c2, _f2, _f3),
                      const SizedBox(width: 12),
                      _box(_c3, _f3, _f4),
                      const SizedBox(width: 12),
                      _box(_c4, _f4, null),
                    ],
                  ),

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        final code = _c1.text + _c2.text + _c3.text + _c4.text;
                        if (code.length == 4) {
                          _verify(code);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Enter the 4-digit code'),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
