import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class PushNotificationsScreen extends StatefulWidget {
  const PushNotificationsScreen({super.key});

  @override
  State<PushNotificationsScreen> createState() =>
      _PushNotificationsScreenState();
}

class _PushNotificationsScreenState extends State<PushNotificationsScreen> {
  final Map<String, bool> _settings = {
    'Notifications': true,
    'Sound': false,
    'Vibrate': false,
    'Special Offers': false,
    'Payments': false,
    'Cashback': false,
    'App Updates': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: const BoxDecoration(
                  color: AppColors.fieldFill, shape: BoxShape.circle),
              child: const Icon(Icons.arrow_back,
                  color: AppColors.textPrimary, size: 20),
            ),
          ),
        ),
        title: const Text('Notifications',
            style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 17,
                fontWeight: FontWeight.w700)),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        children: [
          const Text('Push Notifications',
              style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          ..._settings.keys.map((key) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(key,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500)),
                    ),
                    Switch(
                      value: _settings[key]!,
                      activeColor: Colors.white,
                      activeTrackColor: AppColors.primary,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: AppColors.border,
                      onChanged: (v) => setState(() => _settings[key] = v),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
