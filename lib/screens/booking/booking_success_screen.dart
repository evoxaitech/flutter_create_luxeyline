import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../widgets/primary_button.dart';
import '../home/main_nav_screen.dart';

class BookingSuccessScreen extends StatelessWidget {
  const BookingSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void goHome() {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const MainNavScreen()),
        (route) => false,
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          child: Column(
            children: [
              const Spacer(),
              Container(
                height: 220,
                width: 220,
                decoration: const BoxDecoration(
                  color: AppColors.primaryLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.home_rounded,
                    color: AppColors.primary, size: 90),
              ),
              const SizedBox(height: 32),
              const Text('Booking Successful',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
              const SizedBox(height: 10),
              const Text(
                'Your property has been booked successfully. Our agent will contact you shortly.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.textSecondary, height: 1.5, fontSize: 13),
              ),
              const Spacer(),
              PrimaryButton(label: 'Continue', onPressed: goHome),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: goHome,
                child: const Text('Skip',
                    style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 13)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
