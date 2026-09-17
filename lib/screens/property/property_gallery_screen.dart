import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/models/property.dart';
import '../../widgets/property_card.dart';

class PropertyGalleryScreen extends StatelessWidget {
  final Property property;
  const PropertyGalleryScreen({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    final images = [
      property.image,
      'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=600&q=80',
      'https://images.unsplash.com/photo-1560185127-6ed189bf02f4?w=600&q=80',
      'https://images.unsplash.com/photo-1556911220-e15b29be8c8f?w=600&q=80',
      'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=600&q=80',
      'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=600&q=80',
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: const Text('Property Gallery',
            style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 17,
                fontWeight: FontWeight.w700)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          itemCount: images.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1,
          ),
          itemBuilder: (_, i) {
            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => Dialog(
                    backgroundColor: Colors.transparent,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: PropertyImage(
                          url: images[i], height: 400, width: double.infinity),
                    ),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: PropertyImage(
                    url: images[i],
                    height: double.infinity,
                    width: double.infinity),
              ),
            );
          },
        ),
      ),
    );
  }
}
