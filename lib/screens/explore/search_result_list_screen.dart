import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/models/property.dart';
import '../../widgets/property_card.dart';
import '../property/property_detail_screen.dart';
import 'search_filters_screen.dart';
import 'search_result_grid_screen.dart';

class SearchResultListScreen extends StatelessWidget {
  final String query;
  const SearchResultListScreen({super.key, this.query = ''});

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
            icon: const Icon(Icons.grid_view_rounded,
                color: AppColors.textPrimary),
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) => SearchResultGridScreen(query: query)),
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
                  child: ListView.builder(
                    itemCount: sampleProperties.length,
                    itemBuilder: (_, i) {
                      final p = sampleProperties[i];
                      return _SearchResultCard(
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

class _SearchResultCard extends StatelessWidget {
  final Property property;
  final VoidCallback onTap;
  const _SearchResultCard({required this.property, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                PropertyImage(
                    url: property.image, height: 160, width: double.infinity),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('3D View',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: const Icon(Icons.favorite_border,
                        size: 16, color: AppColors.textPrimary),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(property.title,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w700)),
                Text(property.price,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.price)),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.star, size: 13, color: AppColors.star),
                const SizedBox(width: 2),
                Text('${property.rating}',
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w600)),
                const SizedBox(width: 4),
                const Text('(324 Reviews)',
                    style: TextStyle(
                        fontSize: 11, color: AppColors.textSecondary)),
                const Spacer(),
                const Text('/month',
                    style: TextStyle(
                        fontSize: 11, color: AppColors.textSecondary)),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.location_on,
                    size: 13, color: AppColors.textSecondary),
                const SizedBox(width: 2),
                Expanded(
                  child: Text(property.location,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.textSecondary)),
                ),
                Text('${property.beds} Beds',
                    style: const TextStyle(
                        fontSize: 11, color: AppColors.textSecondary)),
                const SizedBox(width: 8),
                Text('${property.baths} Baths',
                    style: const TextStyle(
                        fontSize: 11, color: AppColors.textSecondary)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
