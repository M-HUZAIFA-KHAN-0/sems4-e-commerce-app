import 'package:flutter/material.dart';
import 'login_page.dart';
import 'email_verification_page.dart';
import '../widgets/widgets.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _emailCtrl;
  late final TextEditingController _firstNameCtrl;
  late final TextEditingController _lastNameCtrl;
  late final TextEditingController _passCtrl;
  late final TextEditingController _confirmCtrl;

  bool _remember = false;
  bool _obscurePass = true;
  bool _obscureConfirm = true;

  @override
  void initState() {
    super.initState();
    _emailCtrl = TextEditingController();
    _firstNameCtrl = TextEditingController();
    _lastNameCtrl = TextEditingController();
    _passCtrl = TextEditingController();
    _confirmCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    final e = email.trim();
    final r = RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[\w]{2,}$');
    return r.hasMatch(e);
  }

  bool _isAlpha(String value) {
    final v = value.trim();
    final r = RegExp(r'^[A-Za-z]+$');
    return r.hasMatch(v);
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() != true) return;

    // TODO: Call your API
    // If success -> navigate to verification screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const EmailVerificationPage()),
    );
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Top back arrow
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new, size: 22),
                          onPressed: () => Navigator.maybePop(context),
                        ),
                      ),

                      const SizedBox(height: 18),

                      // Big icon
                      const Icon(
                        Icons.directions_car_filled,
                        size: 74,
                        color: Colors.black,
                      ),

                      const SizedBox(height: 14),

                      // Title
                      const Text(
                        "Create Your Account",
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
                            AuthField(
                              hint: "First name",
                              controller: _firstNameCtrl,
                              prefixIcon: Icons.person_outline,
                              validator: (v) {
                                final value = (v ?? "").trim();
                                if (value.isEmpty) {
                                  return "First name is required";
                                }
                                if (!_isAlpha(value)) {
                                  return "Only alphabets allowed";
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 12),

                            AuthField(
                              hint: "Last name",
                              controller: _lastNameCtrl,
                              prefixIcon: Icons.person_outline,
                              validator: (v) {
                                final value = (v ?? "").trim();
                                if (value.isEmpty) {
                                  return "Last name is required";
                                }
                                if (!_isAlpha(value)) {
                                  return "Only alphabets allowed";
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 12),

                            AuthField(
                              hint: "Email",
                              controller: _emailCtrl,
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: Icons.email_outlined,
                              validator: (v) {
                                final value = (v ?? "").trim();
                                if (value.isEmpty) return "Email is required";
                                if (!_isValidEmail(value)) {
                                  return "Please enter a valid email";
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 12),

                            AuthField(
                              hint: "Password",
                              controller: _passCtrl,
                              prefixIcon: Icons.lock_outline,
                              obscureText: _obscurePass,
                              suffixIcon: _obscurePass
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              onSuffixTap: () =>
                                  setState(() => _obscurePass = !_obscurePass),
                              validator: (v) {
                                final value = (v ?? "");
                                if (value.isEmpty) {
                                  return "Password is required";
                                }
                                if (value.length < 6) {
                                  return "Password must be at least 6 characters";
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 12),

                            // ✅ Confirm Password (added)
                            AuthField(
                              hint: "Confirm Password",
                              controller: _confirmCtrl,
                              prefixIcon: Icons.lock_outline,
                              obscureText: _obscureConfirm,
                              suffixIcon: _obscureConfirm
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              onSuffixTap: () => setState(
                                () => _obscureConfirm = !_obscureConfirm,
                              ),
                              validator: (v) {
                                final value = (v ?? "");
                                if (value.isEmpty) {
                                  return "Confirm your password";
                                }
                                if (value != _passCtrl.text) {
                                  return "Passwords do not match";
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 14),

                            // Remember me
                            InkWell(
                              onTap: () =>
                                  setState(() => _remember = !_remember),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  _SquareCheck(isChecked: _remember),
                                  const SizedBox(width: 8),
                                  const Text(
                                    "Remember me",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 14),

                            // Sign up button (navigates to verification)
                            _PrimaryButton(
                              text: "Sign up & Verify",
                              onPressed: _submit,
                            ),

                            const SizedBox(height: 18),

                            // Divider: "or continue with"
                            const _ContinueDivider(text: "or continue with"),

                            const SizedBox(height: 16),

                            // Social buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _SocialIconButton(
                                  child: const Icon(
                                    Icons.facebook,
                                    color: Color(0xFF1877F2),
                                    size: 22,
                                  ),
                                  onTap: () {},
                                ),
                                const SizedBox(width: 14),
                                _SocialIconButton(
                                  child: const _GoogleG(),
                                  onTap: () {},
                                ),
                                const SizedBox(width: 14),
                                _SocialIconButton(
                                  child: const Icon(
                                    Icons.apple,
                                    color: Colors.black,
                                    size: 22,
                                  ),
                                  onTap: () {},
                                ),
                              ],
                            ),

                            const SizedBox(height: 18),

                            // Footer link
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Already have an account? ",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF9AA0A6),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const LoginPage(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Sign in",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800,
                                    ),
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
      child: isChecked
          ? const Icon(Icons.check, size: 12, color: Colors.white)
          : null,
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
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
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
        const Expanded(
          child: Divider(thickness: 1, height: 1, color: Color(0xFFE7E9EE)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF9AA0A6),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const Expanded(
          child: Divider(thickness: 1, height: 1, color: Color(0xFFE7E9EE)),
        ),
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
        colors: [
          Color(0xFF4285F4),
          Color(0xFF34A853),
          Color(0xFFFBBC05),
          Color(0xFFEA4335),
        ],
      ).createShader(rect),
      child: const Text(
        "G",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
      ),
    );
  }
}
