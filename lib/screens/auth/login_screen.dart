import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/api/auth_service.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/google_logo.dart';
import 'register_screen.dart';
import 'forgot_password_screen.dart';
import '../home/main_nav_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _loading = false;

  final _auth = AuthService();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  // ======== API LOGIC — bilkul same, kuch nahi chhera ========
  Future<void> _login() async {
    if (_email.text.trim().isEmpty || _password.text.trim().isEmpty) {
      _snack('Please enter email and password');
      return;
    }

    setState(() => _loading = true);

    final result = await _auth.login(
      email: _email.text.trim(),
      password: _password.text.trim(),
    );

    if (!mounted) return;
    setState(() => _loading = false);

    if (result['success'] == true) {
      _snack('Welcome back!');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const MainNavScreen()),
        (route) => false,
      );
    } else {
      _snack(result['message']?.toString() ?? 'Login failed');
    }
  }
  // ===========================================================

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              const Text('Welcome Back!',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              const Text(
                'Sign in to continue exploring luxury homes and connect with agents.',
                style: TextStyle(
                    color: AppColors.textSecondary, height: 1.5, fontSize: 13),
              ),
              const SizedBox(height: 28),
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
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const ForgotPasswordScreen())),
                  child: const Text('Forgot Password?',
                      style: TextStyle(
                          color: AppColors.danger,
                          fontWeight: FontWeight.w600,
                          fontSize: 13)),
                ),
              ),
              const SizedBox(height: 20),
              _loading
                  ? const Center(
                      child:
                          CircularProgressIndicator(color: AppColors.primary))
                  : PrimaryButton(
                      label: 'Sign In',
                      onPressed: _login,
                    ),
              const SizedBox(height: 24),
              Row(
                children: const [
                  Expanded(child: Divider(color: AppColors.border)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text('Or continue with',
                        style: TextStyle(
                            color: AppColors.textSecondary, fontSize: 12)),
                  ),
                  Expanded(child: Divider(color: AppColors.border)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  _SocialCircle(child: GoogleLogo(size: 22)),
                  SizedBox(width: 16),
                  _SocialCircle(
                      child: Icon(Icons.apple, color: Colors.black, size: 22)),
                  SizedBox(width: 16),
                  _SocialCircle(
                      child: Icon(Icons.facebook,
                          color: Color(0xFF1877F2), size: 22)),
                ],
              ),
              const SizedBox(height: 28),
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const RegisterScreen())),
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(
                          color: AppColors.textSecondary, fontSize: 13),
                      children: [
                        TextSpan(text: "Don't have an account? "),
                        TextSpan(
                            text: 'Sign Up',
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

class _SocialCircle extends StatelessWidget {
  final Widget child;
  const _SocialCircle({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}
