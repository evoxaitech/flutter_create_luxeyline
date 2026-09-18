import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class MyListingsScreen extends StatelessWidget {
  const MyListingsScreen({super.key});

  static const _items = [
    [
      'The Lakefront Estate',
      'Lake Geneva, Switzerland',
      '\$1,320,000',
      'Active',
      'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=400&q=80'
    ],
    [
      'Coastal Villa Malibu',
      'Malibu, California',
      '\$2,900,000',
      'Active',
      'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=400&q=80'
    ],
    [
      'Countryside Cottage',
      'Cotswolds, England',
      '\$960,000',
      'Pending',
      'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=400&q=80'
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        foregroundColor: AppColors.textPrimary,
        title: const Text('My Listings',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: _items.length,
        itemBuilder: (_, i) {
          final it = _items[i];
          final active = it[3] == 'Active';
          return Container(
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: AppColors.subtleShadow,
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(it[4],
                      width: 90, height: 80, fit: BoxFit.cover),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(it[0],
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 4),
                      Text(it[1],
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.textSecondary)),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(it[2],
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.price)),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: active
                                  ? AppColors.primaryLight
                                  : const Color(0xFFFFF0DB),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(it[3],
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: active
                                        ? AppColors.primary
                                        : const Color(0xFFB7791F))),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
