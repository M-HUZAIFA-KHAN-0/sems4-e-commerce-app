import 'package:first/core/app_imports.dart';
import 'package:first/services/api/auth_service.dart';

class EmailVerificationPage extends StatefulWidget {
  final String email;
  final dynamic userId;
  final bool isEmailNotVerified;

  const EmailVerificationPage({
    super.key,
    required this.email,
    required this.userId,
    this.isEmailNotVerified = false,
  });

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

  final _authService = AuthService();
  bool _isLoading = false;
  int _resendCountdown = 0;

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
    FocusScope.of(context).unfocus();
    setState(() => _isLoading = true);

    try {
      final result = await _authService.verifyEmail(
        userId: widget.userId,
        otp: code,
      );

      if (!mounted) return;

      if (result['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message'] ?? 'Email verified successfully'),
            backgroundColor: Colors.green,
          ),
        );
        // Navigate to home or login after successful verification
        await Future.delayed(const Duration(milliseconds: 500));
        if (!mounted) return;
        Navigator.of(context).popUntil((route) => route.isFirst);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message'] ?? 'Verification failed'),
            backgroundColor: Colors.red,
          ),
        );
        // Clear the fields
        _c1.clear();
        _c2.clear();
        _c3.clear();
        _c4.clear();
        FocusScope.of(context).requestFocus(_f1);
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred during verification'),
          backgroundColor: Colors.red,
        ),
      );
      print('Error during verification: $e');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _resendOtp() async {
    setState(() => _isLoading = true);

    try {
      final result = await _authService.resendOtp(
        email: widget.email,
        userId: widget.userId,
      );

      if (!mounted) return;

      if (result['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message'] ?? 'OTP sent to your email'),
            backgroundColor: Colors.green,
          ),
        );
        // Start countdown for resend button
        setState(() => _resendCountdown = 60);
        _startCountdown();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message'] ?? 'Failed to resend OTP'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred while resending OTP'),
          backgroundColor: Colors.red,
        ),
      );
      print('Error during resend OTP: $e');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _startCountdown() {
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() {
        if (_resendCountdown > 0) {
          _resendCountdown--;
          if (_resendCountdown > 0) {
            _startCountdown();
          }
        }
      });
    });
  }

  Widget _box(TextEditingController c, FocusNode f, FocusNode? next) {
    return SizedBox(
      width: 56,
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
          // hintText: 'Code',
          counterText: '',
          filled: true,
          fillColor: AppColors.backgroundWhite,
          contentPadding: EdgeInsets.zero,

          // ---- BORDER ----
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 153, 153, 153),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.textBlack, width: 1.5),
          ),

          // ---- HINT STYLE ----
          hintStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
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
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - 100,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Align(
                  //   alignment: Alignment.centerLeft,
                  //   child: IconButton(
                  //     icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                  //     onPressed: () => Navigator.maybePop(context),
                  //   ),
                  // ),
                  const SizedBox(height: 18),

                  const Icon(
                    Icons.email_outlined,
                    size: 74,
                    color: AppColors.textBlack,
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    'Email Verification',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textBlack,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    widget.isEmailNotVerified
                        ? 'Please verify your email first.\nWe\'ve sent a new OTP to your email.'
                        : 'Enter the 4-digit code sent to ${widget.email}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF9AA0A6),
                    ),
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
                      onPressed: _isLoading
                          ? null
                          : () {
                              final code =
                                  _c1.text + _c2.text + _c3.text + _c4.text;
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
                        backgroundColor: _isLoading
                            ? Colors.grey
                            : AppColors.textBlack,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                      child: Text(
                        _isLoading ? 'Verifying...' : 'Continue',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: AppColors.backgroundWhite,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Resend OTP section
                  if (_resendCountdown > 0)
                    Text(
                      'Resend code in $_resendCountdown seconds',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF9AA0A6),
                      ),
                    )
                  else
                    GestureDetector(
                      onTap: _isLoading ? null : _resendOtp,
                      child: Text(
                        'Didn\'t receive the code? Resend',
                        style: TextStyle(
                          fontSize: 12,
                          color: _isLoading
                              ? Color(0xFF9AA0A6)
                              : AppColors.textBlack,
                          fontWeight: FontWeight.w600,
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
