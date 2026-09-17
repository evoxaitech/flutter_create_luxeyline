import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/models/property.dart';
import '../../widgets/category_chips.dart';
import '../../widgets/property_card.dart';
import '../property/property_detail_screen.dart';

class RecommendationScreen extends StatelessWidget {
  const RecommendationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: const Text('Recomendation',
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
            const SizedBox(height: 4),
            const CategoryChips(),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: sampleProperties.length,
                itemBuilder: (_, i) {
                  final p = sampleProperties[i];
                  return ListPropertyCard(
                    property: p,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => PropertyDetailScreen(property: p)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
