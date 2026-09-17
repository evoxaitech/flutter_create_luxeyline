import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import 'personal_data_screen.dart';
import 'payment_account_screen.dart';
import 'account_security_screen.dart';
import 'push_notifications_screen.dart';
import 'help_center_screen.dart';
import 'privacy_policy_screen.dart';
import 'about_app_screen.dart';
import 'terms_condition_screen.dart';
import '../setup/select_language_screen.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({super.key});

  void _go(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          children: [
            // ---- Profile header ----
            Row(
              children: [
                const CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1633332755192-727a05c4013d?w=200&q=80'),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Zareen',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w700)),
                      SizedBox(height: 3),
                      Text('zareen@gmail.com',
                          style: TextStyle(
                              fontSize: 13, color: AppColors.textSecondary)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // ---- Personal Info ----
            _sectionLabel('Personal Info'),
            _tile(context, Icons.person_outline, 'Personal Data',
                onTap: () => _go(context, const PersonalDataScreen())),
            _tile(context, Icons.account_balance_wallet_outlined,
                'Payment Account',
                onTap: () => _go(context, const PaymentAccountScreen())),
            _tile(context, Icons.shield_outlined, 'Account Security',
                onTap: () => _go(context, const AccountSecurityScreen())),
            const SizedBox(height: 20),

            // ---- General ----
            _sectionLabel('General'),
            _tile(context, Icons.language_outlined, 'Language',
                onTap: () => _go(context, const SelectLanguageScreen())),
            _tile(context, Icons.notifications_none, 'Push Notification',
                onTap: () => _go(context, const PushNotificationsScreen())),
            _tile(context, Icons.cleaning_services_outlined, 'Clear Cache',
                trailing: const Text('58 MB',
                    style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary)), onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cache cleared')),
              );
            }),
            const SizedBox(height: 20),

            // ---- About ----
            _sectionLabel('About'),
            _tile(context, Icons.help_outline, 'Help Center',
                onTap: () => _go(context, const HelpCenterScreen())),
            _tile(context, Icons.privacy_tip_outlined, 'Privacy & Policy',
                onTap: () => _go(context, const PrivacyPolicyScreen())),
            _tile(context, Icons.info_outline, 'About App',
                onTap: () => _go(context, const AboutAppScreen())),
            _tile(context, Icons.description_outlined, 'Term & Condition',
                onTap: () => _go(context, const TermsConditionScreen())),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(text,
          style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600)),
    );
  }

  Widget _tile(BuildContext context, IconData icon, String title,
      {Widget? trailing, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13),
        child: Row(
          children: [
            Icon(icon, size: 22, color: AppColors.textPrimary),
            const SizedBox(width: 14),
            Expanded(
              child: Text(title,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w500)),
            ),
            trailing ??
                const Icon(Icons.chevron_right,
                    color: AppColors.textSecondary, size: 22),
          ],
        ),
      ),
    );
  }
}
