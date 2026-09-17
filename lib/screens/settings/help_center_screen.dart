import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class _Faq {
  final String question;
  final String answer;
  const _Faq(this.question, this.answer);
}

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  int? _expanded;
  final _searchController = TextEditingController();
  String _query = '';

  final _faqs = const [
    _Faq(
      'How do I search for a property?',
      'Go to the Home or Explore tab and use the search bar at the top. You can also tap the category chips (Houses, Apartment, Villa) or use filters to narrow results by price, location, beds, and more.',
    ),
    _Faq(
      'How do I book or buy a property?',
      'Open any property to see its details, then tap "Buy Now". Choose your payment method, review the booking summary, and confirm. You\'ll get a confirmation screen once it\'s done.',
    ),
    _Faq(
      'How do I contact an agent?',
      'On a property\'s detail page you\'ll see the listing agent. Tap the chat icon to message them, or the call icon to start a voice or video call directly from the app.',
    ),
    _Faq(
      'How do I save my favourite properties?',
      'Tap the heart icon on any property card or detail page. Saved homes appear in your Favourites so you can quickly find them later.',
    ),
    _Faq(
      'How do I list my own property for sale?',
      'Go to My Properties and tap "Add Property". Fill in the details step by step — general info, photos, contact, and settings — then preview and submit. Your listing goes live once uploaded.',
    ),
    _Faq(
      'How do I reset my password?',
      'On the login screen, tap "Forgot Password?". Enter your email, verify the 6-digit code we send you, and then set a new password.',
    ),
    _Faq(
      'How do I update my profile or account details?',
      'Go to the Profile tab, then Personal Data. You can change your name, email, phone number, date of birth, and photo, then tap Save Changes.',
    ),
    _Faq(
      'How do I manage notifications?',
      'Open Profile > Push Notification. From there you can turn notifications, sounds, offers, and updates on or off according to your preference.',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Search filter
    final filtered = _query.isEmpty
        ? _faqs
        : _faqs
            .where((f) =>
                f.question.toLowerCase().contains(_query.toLowerCase()) ||
                f.answer.toLowerCase().contains(_query.toLowerCase()))
            .toList();

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
        title: const Text('Help Center',
            style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 17,
                fontWeight: FontWeight.w700)),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
                color: AppColors.fieldFill,
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                const Icon(Icons.search,
                    size: 20, color: AppColors.textSecondary),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (v) => setState(() {
                      _query = v;
                      _expanded = null;
                    }),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search help topics',
                      hintStyle: TextStyle(
                          color: AppColors.textSecondary, fontSize: 13),
                      contentPadding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text('Frequently Asked Questions',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
          ),
          if (filtered.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Center(
                child: Text('No results for "$_query"',
                    style: const TextStyle(
                        color: AppColors.textSecondary, fontSize: 13)),
              ),
            )
          else
            ...List.generate(filtered.length, (i) {
              final open = _expanded == i;
              final faq = filtered[i];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(faq.question,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600)),
                      trailing: Icon(
                          open
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: AppColors.textSecondary),
                      onTap: () => setState(() => _expanded = open ? null : i),
                    ),
                    if (open)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(faq.answer,
                              style: const TextStyle(
                                  fontSize: 13,
                                  color: AppColors.textSecondary,
                                  height: 1.6)),
                        ),
                      ),
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }
}
