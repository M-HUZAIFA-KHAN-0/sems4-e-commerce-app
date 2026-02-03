import 'package:first/core/app_imports.dart';
import 'package:first/services/api/auth_service.dart';
import 'forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();

  late final TextEditingController _emailCtrl;
  late final TextEditingController _passCtrl;

  bool _remember = false;
  bool _obscurePass = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailCtrl = TextEditingController();
    _passCtrl = TextEditingController();
  }

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

  void _submit() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() != true) return;

    setState(() => _isLoading = true);

    try {
      final result = await _authService.login(
        usernameOrEmail: _emailCtrl.text.trim(),
        password: _passCtrl.text.trim(),
        rememberMe: _remember,
      );

      if (!mounted) return;

      // Check if email is not verified
      if (result['emailNotVerified'] == true) {
        print('📧 Email not verified - redirecting to OTP screen');

        final userId = result['userId'];
        final email = _emailCtrl.text.trim();

        // Navigate to OTP verification screen with a special message
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => EmailVerificationPage(
              email: email,
              userId: userId,
              isEmailNotVerified: true,
            ),
          ),
        );
        return;
      }

      if (result['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message'] ?? 'Login successful!'),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate to home/dashboard
        await Future.delayed(const Duration(milliseconds: 500));
        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MyHomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message'] ?? 'Login failed'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An unexpected error occurred'),
          backgroundColor: Colors.red,
        ),
      );
      print('Error during login: $e');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
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
                      // const Icon(
                      //   Icons.directions_car_filled,
                      //   size: 74,
                      //   color: AppColors.textBlack,
                      // ),
                      GradientIconWidget(
                        icon: Icons.laptop_mac,
                        size: 74,
                      ),
                      const SizedBox(height: 16),

                      // const Text(
                      //   "Welcome Back",
                      //   style: TextStyle(
                      //     fontSize: 22,
                      //     fontWeight: FontWeight.w800,
                      //     color: AppColors.textBlack,
                      //   ),
                      // ),

                      GradientText(text: "Welcome Back", fontSize: 22),

                      const SizedBox(height: 18),

                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
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
                                return null;
                              },
                            ),

                            const SizedBox(height: 14),

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
                                      color: AppColors.textBlack87,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              const ForgotPasswordPage(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      "Forgot Password?",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF1F1F1F),
                                        fontWeight: FontWeight.w700,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 14),

                            _PrimaryButton(
                              text: _isLoading ? "Signing in..." : "Sign in",
                              onPressed: _isLoading ? null : _submit,
                            ),

                            // const SizedBox(height: 18),
                            // const _ContinueDivider(text: "or continue with"),
                            // const SizedBox(height: 16),

                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     _SocialIconButton(
                            //       child: const Icon(
                            //         Icons.facebook,
                            //         color: Color(0xFF1877F2),
                            //         size: 22,
                            //       ),
                            //       onTap: () {},
                            //     ),
                            //     const SizedBox(width: 14),
                            //     _SocialIconButton(
                            //       child: const _GoogleG(),
                            //       onTap: () {},
                            //     ),
                            //     const SizedBox(width: 14),
                            //     _SocialIconButton(
                            //       child: const Icon(
                            //         Icons.apple,
                            //         color: AppColors.textBlack,
                            //         size: 22,
                            //       ),
                            //       onTap: () {},
                            //     ),
                            //   ],
                            // ),

                            const SizedBox(height: 18),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don’t have an account? ",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: AppColors.textGreyLabel,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const SignUpPage(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Sign up",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: AppColors.textBlack,
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
        color: isChecked ? Colors.black : AppColors.transparent,
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: AppColors.textBlack, width: 1.2),
      ),
      child: isChecked
          ? const Icon(Icons.check, size: 12, color: AppColors.backgroundWhite)
          : null,
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({required this.text, required this.onPressed});

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        boxShadow: const [
          BoxShadow(
            color: AppColors.formShadow,
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: onPressed != null
              ? AppColors.textBlack
              : Colors.grey,
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
            color: AppColors.backgroundWhite,
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
              color: AppColors.textGreyLabel,
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
          color: AppColors.backgroundWhite,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderGreyLighter, width: 1),
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
          color: AppColors.backgroundWhite,
        ),
      ),
    );
  }
}
