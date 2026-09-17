import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import 'terms_condition_screen.dart';

class _AboutItem {
  final String title;
  final IconData icon;
  final String detail;
  const _AboutItem(this.title, this.icon, this.detail);
}

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  final List<_AboutItem> _items = const [
    _AboutItem('Developer', Icons.code,
        'Luxeyline is developed by EVOX AI TECH — building smart, modern digital products for real estate and beyond.'),
    _AboutItem('Partner', Icons.handshake_outlined,
        'We partner with trusted agencies and property owners worldwide to bring you verified luxury listings.'),
    _AboutItem('Accessibility', Icons.accessibility_new,
        'Luxeyline is designed to be usable by everyone, with clear text, high contrast, and simple navigation.'),
    _AboutItem('Terms of Use', Icons.description_outlined, ''),
    _AboutItem('Feedback', Icons.feedback_outlined,
        'We\'d love to hear from you! Share your thoughts and suggestions to help us improve Luxeyline.'),
    _AboutItem('Rate us', Icons.star_outline,
        'Enjoying Luxeyline? Please rate us on the app store — your support helps us grow.'),
    _AboutItem('Visit Our Website', Icons.language,
        'Learn more about us at www.evoxaitech.com'),
    _AboutItem('Follow us On Social Media', Icons.share_outlined,
        'Follow @luxeyline on Instagram, Facebook, and LinkedIn for the latest listings and updates.'),
  ];

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
        title: const Text('About App',
            style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 17,
                fontWeight: FontWeight.w700)),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          const SizedBox(height: 8),
          const Center(
            child: Column(
              children: [
                Icon(Icons.forest, color: AppColors.primary, size: 52),
                SizedBox(height: 10),
                Text('Luxeyline v1.53.0',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          ..._items.map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(item.title,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500)),
                  trailing: const Icon(Icons.chevron_right,
                      color: AppColors.textSecondary),
                  onTap: () {
                    if (item.title == 'Terms of Use') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const TermsConditionScreen()),
                      );
                    } else {
                      _showInfo(context, item);
                    }
                  },
                ),
              )),
        ],
      ),
    );
  }

  void _showInfo(BuildContext context, _AboutItem item) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 44,
                height: 5,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(item.icon, color: AppColors.primary, size: 22),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(item.title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text(item.detail,
                style: const TextStyle(
                    fontSize: 14, color: AppColors.textSecondary, height: 1.6)),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Close',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
