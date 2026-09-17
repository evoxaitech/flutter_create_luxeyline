import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/models/property.dart';
import '../../widgets/property_card.dart';
import '../property/property_detail_screen.dart';
import 'search_filters_screen.dart';
import 'search_result_list_screen.dart';

class SearchResultGridScreen extends StatelessWidget {
  final String query;
  const SearchResultGridScreen({super.key, this.query = ''});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: const Text('Search',
            style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 17,
                fontWeight: FontWeight.w700)),
        actions: [
          IconButton(
            icon: const Icon(Icons.view_list_rounded,
                color: AppColors.textPrimary),
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) => SearchResultListScreen(query: query)),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 90),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: AppColors.fieldFill,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search,
                          color: AppColors.textSecondary, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(query.isEmpty ? 'Search' : query,
                            style: const TextStyle(
                                color: AppColors.textPrimary, fontSize: 14)),
                      ),
                      const Icon(Icons.tune,
                          color: AppColors.primary, size: 20),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Search Result',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700)),
                    Text('Sort by',
                        style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 14),
                Expanded(
                  child: GridView.builder(
                    itemCount: sampleProperties.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 14,
                      childAspectRatio: 0.68,
                    ),
                    itemBuilder: (_, i) {
                      final p = sampleProperties[i];
                      return _GridCard(
                        property: p,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  PropertyDetailScreen(property: p)),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: SizedBox(
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const SearchFiltersScreen())),
                icon: const Icon(Icons.tune, size: 18),
                label: const Text('Filters',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GridCard extends StatelessWidget {
  final Property property;
  final VoidCallback onTap;
  const _GridCard({required this.property, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              PropertyImage(
                  url: property.image, height: 110, width: double.infinity),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: const Icon(Icons.favorite_border,
                      size: 14, color: AppColors.textPrimary),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(property.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
                  const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
          const SizedBox(height: 3),
          Row(
            children: [
              const Icon(Icons.location_on,
                  size: 11, color: AppColors.textSecondary),
              const SizedBox(width: 2),
              Expanded(
                child: Text(property.location,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 10, color: AppColors.textSecondary)),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(property.price,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.price)),
              const SizedBox(width: 4),
              const Text('/month',
                  style:
                      TextStyle(fontSize: 9, color: AppColors.textSecondary)),
              const Spacer(),
              const Icon(Icons.star, size: 12, color: AppColors.star),
              const SizedBox(width: 2),
              Text('${property.rating}',
                  style: const TextStyle(
                      fontSize: 11, fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }
}
