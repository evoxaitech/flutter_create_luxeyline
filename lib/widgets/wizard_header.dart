import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class WizardHeader extends StatelessWidget {
  final String title;
  final int step; // current step 1-6
  final VoidCallback onBack;

  const WizardHeader({
    super.key,
    required this.title,
    required this.step,
    required this.onBack,
  });

  static const _labels = [
    'General',
    'Details',
    'Photos',
    'Contact',
    'Settings',
    'Legal',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: onBack,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        shape: BoxShape.circle),
                    child: const Icon(Icons.arrow_back,
                        color: Colors.white, size: 18),
                  ),
                ),
                const SizedBox(width: 12),
                Text(title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: List.generate(_labels.length, (i) {
                final n = i + 1;
                final done = n < step;
                final active = n == step;
                return Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: done || active
                              ? Colors.white
                              : Colors.white.withOpacity(0.25),
                          shape: BoxShape.circle,
                        ),
                        child: done
                            ? const Icon(Icons.check,
                                size: 13, color: AppColors.primary)
                            : Text('$n',
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: active
                                        ? AppColors.primary
                                        : Colors.white)),
                      ),
                      if (i != _labels.length - 1)
                        Expanded(
                          child: Container(
                            height: 2,
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            color: done
                                ? Colors.white
                                : Colors.white.withOpacity(0.25),
                          ),
                        ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
