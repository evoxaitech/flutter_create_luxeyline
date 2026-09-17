import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class VoiceCallScreen extends StatelessWidget {
  final String name;
  final String avatar;
  const VoiceCallScreen({super.key, required this.name, required this.avatar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                          color: AppColors.fieldFill, shape: BoxShape.circle),
                      child: const Icon(Icons.arrow_back,
                          color: AppColors.textPrimary, size: 20),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text('Voice Call',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w700)),
                    ),
                  ),
                  const SizedBox(width: 36),
                ],
              ),
            ),
            const SizedBox(height: 70),
            CircleAvatar(radius: 58, backgroundImage: NetworkImage(avatar)),
            const SizedBox(height: 18),
            Text(name,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            const Text('Connected',
                style: TextStyle(
                    fontSize: 14,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600)),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _roundButton(Icons.volume_up, AppColors.fieldFill,
                      AppColors.textPrimary, () {}),
                  const SizedBox(width: 28),
                  _roundButton(Icons.call_end, AppColors.danger, Colors.white,
                      () => Navigator.pop(context),
                      big: true),
                  const SizedBox(width: 28),
                  _roundButton(Icons.mic, AppColors.fieldFill,
                      AppColors.textPrimary, () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _roundButton(IconData icon, Color bg, Color fg, VoidCallback onTap,
      {bool big = false}) {
    final size = big ? 66.0 : 54.0;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
        child: Icon(icon, color: fg, size: big ? 30 : 24),
      ),
    );
  }
}
