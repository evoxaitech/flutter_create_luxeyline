import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/models/property.dart';
import '../../widgets/property_card.dart';
import '../property/property_detail_screen.dart';
import 'search_autotype_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<String> _recentSearches = [
    'Owent Apartment',
    'Real Estate Home',
    'Small Apartment'
  ];

  void _removeSearch(String term) {
    setState(() => _recentSearches.remove(term));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Explore',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const SearchAutotypeScreen())),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                  decoration: BoxDecoration(
                    color: AppColors.fieldFill,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.search,
                          color: AppColors.textSecondary, size: 20),
                      SizedBox(width: 10),
                      Text('Search apart, hotel, etc',
                          style: TextStyle(
                              color: AppColors.textSecondary, fontSize: 13)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 22),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Recent Search',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                  if (_recentSearches.isNotEmpty)
                    GestureDetector(
                      onTap: () => setState(() => _recentSearches = []),
                      child: const Text('Clear All',
                          style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: 12)),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              if (_recentSearches.isNotEmpty)
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _recentSearches.map((term) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.fieldFill,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(term,
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500)),
                          const SizedBox(width: 6),
                          GestureDetector(
                            onTap: () => _removeSearch(term),
                            child: const Icon(Icons.close,
                                size: 14, color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              const SizedBox(height: 22),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Recent View',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                  Text('See All',
                      style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 12)),
                ],
              ),
              const SizedBox(height: 14),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: sampleProperties.length,
                  itemBuilder: (_, i) {
                    final p = sampleProperties[i];
                    return FeaturedPropertyCard(
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
      ),
    );
  }
}
