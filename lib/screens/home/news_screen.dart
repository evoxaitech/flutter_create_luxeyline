import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../widgets/property_card.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 240,
            pinned: true,
            backgroundColor: Colors.white,
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back,
                      color: AppColors.textPrimary),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: const Icon(Icons.share_outlined,
                        color: AppColors.textPrimary),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
            flexibleSpace: const FlexibleSpaceBar(
              background: PropertyImage(
                url:
                    'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=900&q=80',
                height: 240,
                width: double.infinity,
                radius: BorderRadius.zero,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text('Trip',
                            style: TextStyle(
                                fontSize: 11,
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(width: 10),
                      const Text('Dec 18, 2024',
                          style: TextStyle(
                              fontSize: 12, color: AppColors.textSecondary)),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    "'Old Labor Club' warehouse set to smash suburb records",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w700, height: 1.3),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Booking a hotel can be a significant part of your travel planning, affecting your overall experience. Whether you are traveling for business or pleasure, finding the right hotel that meets your needs and budget is crucial. Here are some essential travel tips to guide you through the hotel booking process, ensuring a smooth and enjoyable stay.',
                    style: TextStyle(
                        color: AppColors.textSecondary,
                        height: 1.7,
                        fontSize: 13.5),
                  ),
                  const SizedBox(height: 18),
                  const Text('Book Early, but Be Flexible',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  const Text(
                    'Booking early can secure you a good deal, especially if you\'re traveling during peak season or to a popular destination. However, flexibility can also lead to savings. Learn how to balance both strategies.',
                    style: TextStyle(
                        color: AppColors.textSecondary,
                        height: 1.7,
                        fontSize: 13.5),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
