import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import 'login_screen.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(),
              const Icon(Icons.forest, color: AppColors.primary, size: 52),
              const SizedBox(height: 16),
              const Text('Get Started',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              const Text("Welcome! Let's dive into your account.",
                  style: TextStyle(color: AppColors.textSecondary)),
              const SizedBox(height: 40),
              _SocialButton(
                  label: 'Sign in with Google',
                  icon: Icons.g_mobiledata,
                  onTap: () {}),
              const SizedBox(height: 14),
              _SocialButton(
                  label: 'Sign in with Apple', icon: Icons.apple, onTap: () {}),
              const SizedBox(height: 14),
              _SocialButton(
                  label: 'Sign in with Facebook',
                  icon: Icons.facebook,
                  onTap: () {}),
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
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const LoginScreen())),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Sign in with Email',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: GestureDetector(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const LoginScreen())),
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

class _SocialButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const _SocialButton(
      {required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, color: AppColors.textPrimary),
        label: Text(label,
            style: const TextStyle(
                color: AppColors.textPrimary, fontWeight: FontWeight.w500)),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.border),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
