import 'package:flutter/material.dart';
import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  bool _remember = false;
  bool _obscurePass = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    final e = email.trim();
    final r = RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[\w]{2,}$');
    return r.hasMatch(e);
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() != true) return;

    // TODO: Call login API
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                          onPressed: () => Navigator.maybePop(context),
                        ),
                      ),

                      const SizedBox(height: 18),
                      const Icon(Icons.directions_car_filled, size: 74, color: Colors.black),
                      const SizedBox(height: 16),

                      const Text(
                        "Welcome Back",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),

                      const SizedBox(height: 18),

                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            _AuthField(
                              hint: "Email",
                              controller: _emailCtrl,
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: Icons.email_outlined,
                              validator: (v) {
                                final value = (v ?? "").trim();
                                if (value.isEmpty) return "Email is required";
                                if (!_isValidEmail(value)) return "Please enter a valid email";
                                return null;
                              },
                            ),
                            const SizedBox(height: 12),
                            _AuthField(
                              hint: "Password",
                              controller: _passCtrl,
                              prefixIcon: Icons.lock_outline,
                              obscureText: _obscurePass,
                              suffixIcon: _obscurePass ? Icons.visibility_off : Icons.visibility,
                              onSuffixTap: () => setState(() => _obscurePass = !_obscurePass),
                              validator: (v) {
                                final value = (v ?? "");
                                if (value.isEmpty) return "Password is required";
                                return null;
                              },
                            ),

                            const SizedBox(height: 14),

                            InkWell(
                              onTap: () => setState(() => _remember = !_remember),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _SquareCheck(isChecked: _remember),
                                  const SizedBox(width: 8),
                                  const Text(
                                    "Remember me",
                                    style: TextStyle(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 14),

                            _PrimaryButton(
                              text: "Sign in",
                              onPressed: _submit,
                            ),

                            const SizedBox(height: 18),
                            const _ContinueDivider(text: "or continue with"),
                            const SizedBox(height: 16),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _SocialIconButton(
                                  child: const Icon(Icons.facebook, color: Color(0xFF1877F2), size: 22),
                                  onTap: () {},
                                ),
                                const SizedBox(width: 14),
                                _SocialIconButton(
                                  child: const _GoogleG(),
                                  onTap: () {},
                                ),
                                const SizedBox(width: 14),
                                _SocialIconButton(
                                  child: const Icon(Icons.apple, color: Colors.black, size: 22),
                                  onTap: () {},
                                ),
                              ],
                            ),

                            const SizedBox(height: 18),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don’t have an account? ",
                                  style: TextStyle(fontSize: 11, color: Color(0xFF9AA0A6), fontWeight: FontWeight.w600),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => const SignUpPage()),
                                    );
                                  },
                                  child: const Text(
                                    "Sign up",
                                    style: TextStyle(fontSize: 11, color: Colors.black, fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// same UI components as signup (copied to keep “no design changes”)
class _AuthField extends StatelessWidget {
  const _AuthField({
    required this.hint,
    required this.controller,
    required this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
  });

  final String hint;
  final TextEditingController controller;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;

  static const Color _fieldBg = Color(0xFFF3F4F6);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700),
      decoration: InputDecoration(
        filled: true,
        fillColor: _fieldBg,
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 12, color: Color(0xFFB0B6BE), fontWeight: FontWeight.w600),
        prefixIcon: Icon(prefixIcon, size: 18, color: Colors.black54),
        suffixIcon: suffixIcon == null
            ? null
            : InkWell(
                onTap: onSuffixTap,
                child: Icon(suffixIcon, size: 18, color: Colors.black45),
              ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(12)),
        errorStyle: const TextStyle(fontSize: 11, height: 1.1),
      ),
    );
  }
}

class _SquareCheck extends StatelessWidget {
  const _SquareCheck({required this.isChecked});
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        color: isChecked ? Colors.black : Colors.transparent,
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: Colors.black, width: 1.2),
      ),
      child: isChecked ? const Icon(Icons.check, size: 12, color: Colors.white) : null,
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({required this.text, required this.onPressed});
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        boxShadow: const [BoxShadow(color: Color(0x22000000), blurRadius: 14, offset: Offset(0, 6))],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800, color: Colors.white),
        ),
      ),
    );
  }
}

class _ContinueDivider extends StatelessWidget {
  const _ContinueDivider({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(thickness: 1, height: 1, color: Color(0xFFE7E9EE))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            text,
            style: const TextStyle(fontSize: 11, color: Color(0xFF9AA0A6), fontWeight: FontWeight.w700),
          ),
        ),
        const Expanded(child: Divider(thickness: 1, height: 1, color: Color(0xFFE7E9EE))),
      ],
    );
  }
}

class _SocialIconButton extends StatelessWidget {
  const _SocialIconButton({required this.child, required this.onTap});
  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 56,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE7E9EE), width: 1),
        ),
        child: Center(child: child),
      ),
    );
  }
}

class _GoogleG extends StatelessWidget {
  const _GoogleG();

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) => const LinearGradient(
        colors: [Color(0xFF4285F4), Color(0xFF34A853), Color(0xFFFBBC05), Color(0xFFEA4335)],
      ).createShader(rect),
      child: const Text(
        "G",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Colors.white),
      ),
    );
  }
}
