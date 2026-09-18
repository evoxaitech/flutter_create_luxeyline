import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _soon(BuildContext c, String l) =>
      ScaffoldMessenger.of(c).showSnackBar(SnackBar(
          content: Text('$l — coming soon'),
          backgroundColor: AppColors.primary,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 1)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        foregroundColor: AppColors.textPrimary,
        title: const Text('Settings',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _tile(context, Icons.language, 'Language',
              () => _push(context, const LanguageScreen())),
          _tile(context, Icons.notifications_none, 'Push Notifications',
              () => _push(context, const PushNotificationsScreen())),
          _tile(context, Icons.lock_outline, 'Account Security',
              () => _push(context, const AccountSecurityScreen())),
          _tile(context, Icons.cleaning_services_outlined, 'Clear Cache',
              () => _soon(context, 'Clear Cache')),
          _tile(context, Icons.privacy_tip_outlined, 'Privacy Policy',
              () => _push(context, const PrivacyPolicyScreen())),
          _tile(context, Icons.description_outlined, 'Terms & Conditions',
              () => _push(context, const TermsScreen())),
          _tile(context, Icons.info_outline, 'About App',
              () => _push(context, const AboutAppScreen())),
        ],
      ),
    );
  }

  void _push(BuildContext c, Widget s) =>
      Navigator.push(c, MaterialPageRoute(builder: (_) => s));

  Widget _tile(BuildContext c, IconData i, String l, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: AppColors.subtleShadow,
      ),
      child: ListTile(
        leading: Icon(i, color: AppColors.textPrimary),
        title: Text(l,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.chevron_right,
            size: 18, color: AppColors.textSecondary),
        onTap: onTap,
      ),
    );
  }
}

// ---------- Language ----------
class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});
  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _sel = 'English (US)';
  static const _langs = [
    'English (US)',
    'English (UK)',
    'Bahasa Indonesia',
    'Spanish',
    'French',
    'Arabic',
    'Chinese',
    'Urdu'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        foregroundColor: AppColors.textPrimary,
        title: const Text('Language',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: _langs.map((l) {
          final sel = l == _sel;
          return ListTile(
            title: Text(l,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: sel ? FontWeight.w700 : FontWeight.w500)),
            trailing: sel
                ? const Icon(Icons.check_circle, color: AppColors.primary)
                : const Icon(Icons.circle_outlined, color: AppColors.border),
            onTap: () => setState(() => _sel = l),
          );
        }).toList(),
      ),
    );
  }
}

// ---------- Push Notifications (toggles) ----------
class PushNotificationsScreen extends StatefulWidget {
  const PushNotificationsScreen({super.key});
  @override
  State<PushNotificationsScreen> createState() =>
      _PushNotificationsScreenState();
}

class _PushNotificationsScreenState extends State<PushNotificationsScreen> {
  final Map<String, bool> _s = {
    'Notifications': true,
    'Sound': false,
    'Vibrate': true,
    'Special Offers': false,
    'Payments': true,
    'Cashback': false,
    'App Updates': true,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        foregroundColor: AppColors.textPrimary,
        title: const Text('Push Notifications',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        children: _s.keys.map((k) {
          return SwitchListTile(
            title: Text(k,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            value: _s[k]!,
            activeColor: AppColors.primary,
            onChanged: (v) => setState(() => _s[k] = v),
          );
        }).toList(),
      ),
    );
  }
}

// ---------- Privacy Policy ----------
class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return _DocScaffold(
      title: 'Privacy Policy',
      sections: const [
        [
          '1. Information Collection',
          'We collect information you provide directly, such as your name, email and phone number, to create and manage your account.'
        ],
        [
          '2. Information Usage',
          'Your information is used to provide, maintain and improve our services, and to personalise your experience within the app.'
        ],
        [
          '3. Information Sharing',
          'We do not sell your personal data. Information is shared only with trusted partners required to operate the service.'
        ],
        [
          '4. Security Measures',
          'We use industry-standard measures to protect your data against unauthorised access, alteration or disclosure.'
        ],
      ],
    );
  }
}

// ---------- Terms & Conditions ----------
class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return _DocScaffold(
      title: 'Terms & Conditions',
      sections: const [
        [
          '1. Acceptance of Terms',
          'By using Luxeyline you agree to these terms. If you do not agree, please discontinue use of the application.'
        ],
        [
          '2. Use of Service',
          'You agree to use the app only for lawful purposes and not to misuse listings, agents or booking features.'
        ],
        [
          '3. Bookings & Payments',
          'All bookings and payments made through the app are subject to the terms of the respective property and agent.'
        ],
        [
          '4. Changes to Terms',
          'We may update these terms from time to time. Continued use of the app means you accept any revised terms.'
        ],
      ],
    );
  }
}

class _DocScaffold extends StatelessWidget {
  final String title;
  final List<List<String>> sections;
  const _DocScaffold({required this.title, required this.sections});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        foregroundColor: AppColors.textPrimary,
        title: Text(title,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('Effective Date: March 20, 2024',
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          const SizedBox(height: 16),
          ...sections.map((s) => Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(s[0],
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 6),
                    Text(s[1],
                        style: const TextStyle(
                            fontSize: 13,
                            height: 1.7,
                            color: AppColors.textSecondary)),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

// ---------- Account Security ----------
class AccountSecurityScreen extends StatefulWidget {
  const AccountSecurityScreen({super.key});
  @override
  State<AccountSecurityScreen> createState() => _AccountSecurityScreenState();
}

class _AccountSecurityScreenState extends State<AccountSecurityScreen> {
  final Map<String, bool> _s = {
    'Remember Password': true,
    'Face ID': false,
    'Biometric ID': true,
    'Google Authenticator': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        foregroundColor: AppColors.textPrimary,
        title: const Text('Account Security',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        children: [
          ..._s.keys.map((k) => SwitchListTile(
                title: Text(k,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500)),
                value: _s[k]!,
                activeColor: AppColors.primary,
                onChanged: (v) => setState(() => _s[k] = v),
              )),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SizedBox(
              height: 52,
              child: OutlinedButton(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Change Password — coming soon'),
                        backgroundColor: AppColors.primary)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Change Password',
                    style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 15,
                        fontWeight: FontWeight.w600)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------- About App ----------
class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  static const _items = [
    'Developer',
    'Partner',
    'Accessibility',
    'Terms of Use',
    'Feedback',
    'Rate us',
    'Visit Our Website',
    'Follow Us On Social Media',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        foregroundColor: AppColors.textPrimary,
        title: const Text('About App',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 8),
          const Center(
            child: Icon(Icons.forest, color: AppColors.primary, size: 52),
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text('Luxeyline v1.0.0',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
          ),
          const SizedBox(height: 4),
          const Center(
            child: Text('Real Estate App',
                style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          ),
          const SizedBox(height: 24),
          ..._items.map((t) => ListTile(
                title: Text(t,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500)),
                trailing: const Icon(Icons.chevron_right,
                    size: 18, color: AppColors.textSecondary),
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('$t — coming soon'),
                        backgroundColor: AppColors.primary,
                        duration: const Duration(seconds: 1))),
              )),
        ],
      ),
    );
  }
}
