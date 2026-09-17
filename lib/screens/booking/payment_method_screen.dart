import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/card_storage.dart';
import '../../core/models/property.dart';
import '../../widgets/property_card.dart';
import 'add_card_screen.dart';
import 'booking_confirmation_screen.dart';

class PaymentMethodScreen extends StatefulWidget {
  final Property property;
  const PaymentMethodScreen({super.key, required this.property});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  int _selected = 2; // PayPal default

  // Fixed payment methods
  final List<Map<String, dynamic>> _fixedMethods = [
    {'name': 'Apple Pay', 'icon': Icons.apple},
    {'name': 'Google Pay', 'icon': Icons.g_mobiledata},
    {'name': 'PayPal', 'icon': Icons.payment},
    {'name': 'Stripe', 'icon': Icons.credit_card},
  ];

  // Permanent saved cards (phone se load honge)
  List<Map<String, dynamic>> _savedCards = [];

  @override
  void initState() {
    super.initState();
    _loadCards();
  }

  Future<void> _loadCards() async {
    final cards = await CardStorage.getCards();
    if (!mounted) return;
    setState(() => _savedCards = cards);
  }

  // Poori list = fixed + saved cards
  List<Map<String, dynamic>> get _allMethods => [
        ..._fixedMethods,
        ..._savedCards.map((c) => {
              'name': c['label'] ?? 'Card',
              'icon': Icons.credit_card,
            }),
      ];

  Future<void> _openAddCard() async {
    final card = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(builder: (_) => const AddCardScreen()),
    );
    if (card != null) {
      await CardStorage.addCard(card); // permanent save
      await _loadCards();
      if (!mounted) return;
      setState(() => _selected = _allMethods.length - 1); // naya card select
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Card added successfully'),
            backgroundColor: AppColors.primary),
      );
    }
  }

  // Saved card delete (long press pe)
  Future<void> _deleteCard(int savedIndex) async {
    await CardStorage.removeCard(savedIndex);
    await _loadCards();
    if (!mounted) return;
    setState(() => _selected = 2);
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.property;
    final methods = _allMethods;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: const Text('Payment Account',
            style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 17,
                fontWeight: FontWeight.w700)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.fieldFill,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: PropertyImage(url: p.image, height: 56, width: 56),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(p.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 14)),
                        const SizedBox(height: 4),
                        const Text('Dec 19, 2024 · 2 Guests',
                            style: TextStyle(
                                fontSize: 11, color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('User Information',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                Text('Change',
                    style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 12)),
              ],
            ),
            const SizedBox(height: 10),
            _infoRow('Full Name', 'Aaron Ramsdale'),
            _infoRow('Email', 'aaronramsdale@gmail.com'),
            _infoRow('Phone Number', '+1 (409) 487-1085'),
            const SizedBox(height: 20),
            const Text('Payment Method',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.separated(
                itemCount: methods.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (_, i) {
                  final sel = _selected == i;
                  final isSavedCard = i >= _fixedMethods.length;
                  return GestureDetector(
                    onTap: () => setState(() => _selected = i),
                    onLongPress: isSavedCard
                        ? () => _deleteCard(i - _fixedMethods.length)
                        : null,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color:
                            sel ? AppColors.primaryLight : AppColors.fieldFill,
                        border: Border.all(
                            color: sel ? AppColors.primary : Colors.transparent,
                            width: 1.4),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(methods[i]['icon'] as IconData,
                              color: AppColors.textPrimary, size: 20),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(methods[i]['name'] as String,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 13)),
                          ),
                          if (sel)
                            Container(
                              padding: const EdgeInsets.all(3),
                              decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle),
                              child: const Icon(Icons.check,
                                  color: Colors.white, size: 12),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Center(
              child: TextButton.icon(
                onPressed: _openAddCard,
                icon: const Icon(Icons.add, color: AppColors.primary, size: 18),
                label: const Text('Add Card',
                    style: TextStyle(
                        color: AppColors.primary, fontWeight: FontWeight.w600)),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => BookingConfirmationScreen(property: p)),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Continue',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 12, color: AppColors.textSecondary)),
          Text(value,
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
