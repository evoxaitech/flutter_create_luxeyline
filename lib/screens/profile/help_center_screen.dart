import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  static const _faqs = [
    [
      'How do I book a property tour?',
      'Open any property, tap the message or call button to reach the agent, or use Buy Now to start the booking flow.'
    ],
    [
      'How do I save a property to favourites?',
      'Tap the heart icon on any property card or on the property detail screen. Saved items appear in your Favourites.'
    ],
    [
      'How do I contact the listing agent?',
      'On the property detail screen, use the chat or call buttons in the Listing Agent section to message or call directly.'
    ],
    [
      'How do I change my personal details?',
      'Go to Profile, tap Personal Information, edit your details and press Save Changes.'
    ],
    [
      'How do I log out?',
      'Open Profile, scroll to Support, and tap Log Out. You will be returned to the login screen.'
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        foregroundColor: AppColors.textPrimary,
        title: const Text('Help Center',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
                color: AppColors.fieldFill,
                borderRadius: BorderRadius.circular(12)),
            child: const Row(
              children: [
                Icon(Icons.search, color: AppColors.textSecondary, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search',
                      hintStyle: TextStyle(
                          color: AppColors.textSecondary, fontSize: 13),
                      contentPadding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ..._faqs.map((f) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    tilePadding: const EdgeInsets.symmetric(horizontal: 16),
                    childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                    title: Text(f[0],
                        style: const TextStyle(
                            fontSize: 13.5, fontWeight: FontWeight.w600)),
                    iconColor: AppColors.primary,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(f[1],
                            style: const TextStyle(
                                fontSize: 13,
                                height: 1.6,
                                color: AppColors.textSecondary)),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
