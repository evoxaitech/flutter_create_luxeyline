import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/api/auth_service.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/primary_button.dart';
import 'otp_verification_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _email = TextEditingController();
  final _auth = AuthService();
  bool _loading = false;

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Future<void> _sendOtp() async {
    final email = _email.text.trim();

    // simple validation
    if (email.isEmpty || !email.contains('@') || !email.contains('.')) {
      _snack('Please enter a valid email');
      return;
    }

    setState(() => _loading = true);
    final result = await _auth.forgotPassword(email: email);
    if (!mounted) return;
    setState(() => _loading = false);

    if (result['success'] == true) {
      _snack('OTP sent to your email 📧', success: true);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => OtpVerificationScreen(
            email: email,
            isPasswordReset: true,
          ),
        ),
      );
    } else {
      _snack(result['message']?.toString() ?? 'Something went wrong');
    }
  }

  void _snack(String msg, {bool success = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: success ? AppColors.primary : Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Forgot Password',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              const Text(
                'Enter your email and we’ll send you a one-time code to reset your password.',
                style: TextStyle(
                    color: AppColors.textSecondary, height: 1.5, fontSize: 13),
              ),
              const SizedBox(height: 28),
              CustomTextField(
                  label: 'Email',
                  hint: 'Enter your email',
                  controller: _email,
                  keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 24),
              PrimaryButton(
                label: _loading ? 'Sending...' : 'Send OTP',
                onPressed: _loading ? () {} : _sendOtp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
