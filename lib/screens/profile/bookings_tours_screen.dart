import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class BookingsToursScreen extends StatelessWidget {
  const BookingsToursScreen({super.key});

  static const _items = [
    [
      'Harbourside Duplex',
      'Porto, Portugal',
      'Sat, 20 Sep • 3:00 PM',
      'Upcoming',
      'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=400&q=80'
    ],
    [
      'The Emerald Mansion',
      'Beverly Hills, USA',
      'Wed, 10 Sep • 11:00 AM',
      'Completed',
      'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=400&q=80'
    ],
    [
      'Boulevard Hotel',
      'West Java, Indonesia',
      'Mon, 25 Aug • 1:00 PM',
      'Completed',
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
        title: const Text('Bookings & Tours',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: _items.length,
        itemBuilder: (_, i) {
          final it = _items[i];
          final upcoming = it[3] == 'Upcoming';
          return Container(
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: AppColors.subtleShadow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(it[4],
                          width: 70, height: 70, fit: BoxFit.cover),
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
                                  fontSize: 12,
                                  color: AppColors.textSecondary)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: upcoming
                            ? AppColors.primaryLight
                            : AppColors.fieldFill,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(it[3],
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: upcoming
                                  ? AppColors.primary
                                  : AppColors.textSecondary)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined,
                        size: 14, color: AppColors.primary),
                    const SizedBox(width: 6),
                    Text(it[2],
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
