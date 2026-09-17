import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../widgets/primary_button.dart';
import '../home/main_nav_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          child: Column(
            children: [
              const Spacer(),

              // ---- Success badge with layered rings ----
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withOpacity(0.08),
                ),
                child: Center(
                  child: Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary.withOpacity(0.15),
                    ),
                    child: Center(
                      child: Container(
                        width: 74,
                        height: 74,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                        ),
                        child: const Icon(Icons.check_rounded,
                            color: Colors.white, size: 44),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              const Text('Welcome, Zareen! 🎉',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
              const SizedBox(height: 12),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'Your account is all set up. Start exploring luxury homes, connect with agents, and find your perfect place.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.textSecondary,
                      height: 1.6,
                      fontSize: 14),
                ),
              ),

              const SizedBox(height: 36),

              // ---- Feature highlights ----
              _featureRow(
                  Icons.home_work_outlined,
                  'Browse thousands of listings',
                  'Verified luxury properties worldwide'),
              const SizedBox(height: 16),
              _featureRow(Icons.chat_bubble_outline, 'Chat with trusted agents',
                  'Message, call, and schedule viewings'),
              const SizedBox(height: 16),
              _featureRow(Icons.favorite_border, 'Save your favourites',
                  'Keep track of homes you love'),

              const Spacer(),

              PrimaryButton(
                label: 'Get Started',
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const MainNavScreen()),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _featureRow(IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.primary, size: 22),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w700)),
              const SizedBox(height: 2),
              Text(subtitle,
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.textSecondary)),
            ],
          ),
        ),
      ],
    );
  }
}
