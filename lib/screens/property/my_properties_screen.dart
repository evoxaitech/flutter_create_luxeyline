import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/models/property.dart';
import '../../widgets/property_card.dart';
import 'add_property_general_info_screen.dart';

class MyPropertiesScreen extends StatefulWidget {
  const MyPropertiesScreen({super.key});

  @override
  State<MyPropertiesScreen> createState() => _MyPropertiesScreenState();
}

class _MyPropertiesScreenState extends State<MyPropertiesScreen> {
  int _topTab = 0; // Purchased / Saved
  int _filterTab = 0; // All / Active / Pending / Sold

  final _statuses = const ['Occupied', 'Available', 'Sold'];

  @override
  Widget build(BuildContext context) {
    final items = sampleProperties.take(3).toList();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('My Properties',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                const AddPropertyGeneralInfoScreen())),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                          color: AppColors.primary, shape: BoxShape.circle),
                      child:
                          const Icon(Icons.add, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.fieldFill,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(child: _topTabButton('Purchased', 0)),
                    Expanded(child: _topTabButton('Saved', 1)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 34,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _filterChip('All Properties', 0),
                    _filterChip('Active', 1),
                    _filterChip('Pending', 2),
                    _filterChip('Sold', 3),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (_, i) {
                    final p = items[i];
                    return Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.border),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: PropertyImage(
                                url: p.image, height: 60, width: 60),
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
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13)),
                                const SizedBox(height: 3),
                                Text('Date: Mar 15, 2024',
                                    style: const TextStyle(
                                        fontSize: 11,
                                        color: AppColors.textSecondary)),
                                const SizedBox(height: 3),
                                Text(
                                    'Status: ${_statuses[i % _statuses.length]}',
                                    style: const TextStyle(
                                        fontSize: 11,
                                        color: AppColors.textSecondary)),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text('See Detail',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
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

  Widget _topTabButton(String label, int i) {
    final sel = _topTab == i;
    return GestureDetector(
      onTap: () => setState(() => _topTab = i),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: sel ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(label,
            style: TextStyle(
                color: sel ? Colors.white : AppColors.textSecondary,
                fontSize: 13,
                fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget _filterChip(String label, int i) {
    final sel = _filterTab == i;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () => setState(() => _filterTab = i),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: sel ? AppColors.primaryLight : AppColors.fieldFill,
            border:
                Border.all(color: sel ? AppColors.primary : Colors.transparent),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(label,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: sel ? AppColors.primary : AppColors.textSecondary)),
        ),
      ),
    );
  }
}
