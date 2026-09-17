import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import '../../core/app_colors.dart';
import '../../core/api/auth_service.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/primary_button.dart';
import 'otp_verification_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _agree = false;
  bool _loading = false;

  final _auth = AuthService();

  String _countryFlag = '🇵🇰';
  String _countryCode = '+92';

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _openCountryPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: (Country country) {
        setState(() {
          _countryFlag = country.flagEmoji;
          _countryCode = '+${country.phoneCode}';
        });
      },
    );
  }

  Future<void> _register() async {
    if (_name.text.trim().isEmpty ||
        _email.text.trim().isEmpty ||
        _password.text.trim().isEmpty ||
        _phone.text.trim().isEmpty) {
      _snack('Please fill all fields');
      return;
    }

    setState(() => _loading = true);

    final result = await _auth.signup(
      fullName: _name.text.trim(),
      phoneNumber: '$_countryCode${_phone.text.trim()}',
      email: _email.text.trim(),
      password: _password.text.trim(),
    );

    if (!mounted) return;
    setState(() => _loading = false);

    if (result['success'] == true) {
      _snack('Account created! Check your email for the OTP.');
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => OtpVerificationScreen(email: _email.text.trim())),
      );
    } else {
      _snack(result['message']?.toString() ?? 'Signup failed');
    }
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Create Your Account',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              const Text(
                'Sign up to start exploring luxury homes and connect with agents.',
                style: TextStyle(
                    color: AppColors.textSecondary, height: 1.5, fontSize: 13),
              ),
              const SizedBox(height: 24),
              CustomTextField(
                  label: 'Full Name',
                  hint: 'Enter your name',
                  controller: _name),
              const Text('Phone Number',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Row(
                children: [
                  GestureDetector(
                    onTap: _openCountryPicker,
                    child: Container(
                      height: 52,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: AppColors.fieldFill,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(_countryFlag,
                              style: const TextStyle(fontSize: 18)),
                          const SizedBox(width: 6),
                          Text(_countryCode,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600)),
                          const Icon(Icons.arrow_drop_down,
                              size: 18, color: AppColors.textSecondary),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 52,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: AppColors.fieldFill,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: _phone,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter your number',
                          hintStyle: TextStyle(
                              color: AppColors.textSecondary, fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CustomTextField(
                  label: 'Email',
                  hint: 'Enter your email',
                  controller: _email,
                  keyboardType: TextInputType.emailAddress),
              CustomTextField(
                  label: 'Password',
                  hint: 'Enter your password',
                  controller: _password,
                  isPassword: true),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 22,
                    width: 22,
                    child: Checkbox(
                      value: _agree,
                      activeColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      onChanged: (v) => setState(() => _agree = v ?? false),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(
                            color: AppColors.textSecondary, fontSize: 12),
                        children: [
                          TextSpan(text: 'By registering you agree to our '),
                          TextSpan(
                              text: 'Terms & Conditions',
                              style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600)),
                          TextSpan(text: ' and '),
                          TextSpan(
                              text: 'Privacy Policy',
                              style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _loading
                  ? const Center(
                      child:
                          CircularProgressIndicator(color: AppColors.primary))
                  : PrimaryButton(
                      label: 'Sign Up',
                      onPressed: _agree ? _register : null,
                    ),
              const SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(
                          color: AppColors.textSecondary, fontSize: 13),
                      children: [
                        TextSpan(text: "Already have an account? "),
                        TextSpan(
                            text: 'Sign In',
                            style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
