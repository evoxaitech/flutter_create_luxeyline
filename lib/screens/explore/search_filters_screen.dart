import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class SearchFiltersScreen extends StatefulWidget {
  const SearchFiltersScreen({super.key});

  @override
  State<SearchFiltersScreen> createState() => _SearchFiltersScreenState();
}

class _SearchFiltersScreenState extends State<SearchFiltersScreen> {
  String _propertyType = 'All types';
  String _priceMin = 'Any';
  String _priceMax = 'Any';
  String _outdoor = 'Balcony';
  String _indoor = 'Dishwasher';

  void _reset() {
    setState(() {
      _propertyType = 'All types';
      _priceMin = 'Any';
      _priceMax = 'Any';
      _outdoor = 'Balcony';
      _indoor = 'Dishwasher';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: SafeArea(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Search Filters',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w700)),
                    GestureDetector(
                      onTap: _reset,
                      child: const Text('Reset',
                          style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: 13)),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _dropdownField(
                  label: 'Property type',
                  value: _propertyType,
                  options: const [
                    'All types',
                    'Houses',
                    'Apartment',
                    'Villa',
                    'Land'
                  ],
                  onChanged: (v) => setState(() => _propertyType = v!),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _dropdownField(
                        label: 'Price Min',
                        value: _priceMin,
                        options: const [
                          'Any',
                          '\$500',
                          '\$1,000',
                          '\$2,000',
                          '\$5,000'
                        ],
                        onChanged: (v) => setState(() => _priceMin = v!),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _dropdownField(
                        label: 'Price Max',
                        value: _priceMax,
                        options: const [
                          'Any',
                          '\$5,000',
                          '\$10,000',
                          '\$50,000',
                          '\$1,000,000+'
                        ],
                        onChanged: (v) => setState(() => _priceMax = v!),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _dropdownField(
                  label: 'Outdoor features',
                  value: _outdoor,
                  options: const ['Balcony', 'Garden', 'Pool', 'Parking'],
                  onChanged: (v) => setState(() => _outdoor = v!),
                ),
                const SizedBox(height: 16),
                _dropdownField(
                  label: 'Indoor features',
                  value: _indoor,
                  options: const [
                    'Dishwasher',
                    'Washer/Dryer',
                    'AC',
                    'Fireplace'
                  ],
                  onChanged: (v) => setState(() => _indoor = v!),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Apply Filters',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _dropdownField({
    required String label,
    required String value,
    required List<String> options,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: AppColors.fieldFill,
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down,
                  color: AppColors.textSecondary),
              style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
              items: options
                  .map((o) => DropdownMenuItem(value: o, child: Text(o)))
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
