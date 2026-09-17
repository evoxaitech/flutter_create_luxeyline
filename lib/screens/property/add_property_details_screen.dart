import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/wizard_header.dart';
import 'add_property_photos_screen.dart';

class AddPropertyDetailsScreen extends StatefulWidget {
  const AddPropertyDetailsScreen({super.key});

  @override
  State<AddPropertyDetailsScreen> createState() =>
      _AddPropertyDetailsScreenState();
}

class _AddPropertyDetailsScreenState extends State<AddPropertyDetailsScreen> {
  final _landArea = TextEditingController(text: '250m²');
  final _buildingArea = TextEditingController(text: '180m²');
  String _bedrooms = '3';
  String _bathrooms = '2';
  String _floors = '2';
  String _yearBuilt = '2018';
  String _amenities = 'Garage, Garden, Swimming Pool, Fiber...';

  @override
  void dispose() {
    _landArea.dispose();
    _buildingArea.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          WizardHeader(
              title: 'Add Property',
              step: 2,
              onBack: () => Navigator.pop(context)),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Property Details',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                          child: CustomTextField(
                              label: 'Land Area',
                              hint: '250m²',
                              controller: _landArea)),
                      const SizedBox(width: 14),
                      Expanded(
                          child: CustomTextField(
                              label: 'Building Area',
                              hint: '180m²',
                              controller: _buildingArea)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: _dropdown(
                              'Bedrooms',
                              _bedrooms,
                              ['1', '2', '3', '4', '5+'],
                              (v) => setState(() => _bedrooms = v!))),
                      const SizedBox(width: 14),
                      Expanded(
                          child: _dropdown(
                              'Bathrooms',
                              _bathrooms,
                              ['1', '2', '3', '4', '5+'],
                              (v) => setState(() => _bathrooms = v!))),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                          child: _dropdown(
                              'Floors',
                              _floors,
                              ['1', '2', '3', '4+'],
                              (v) => setState(() => _floors = v!))),
                      const SizedBox(width: 14),
                      Expanded(
                          child: _dropdown(
                              'Year Built',
                              _yearBuilt,
                              ['2018', '2019', '2020', '2021', '2022', '2023'],
                              (v) => setState(() => _yearBuilt = v!))),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _dropdown(
                      'Additional Amenities',
                      _amenities,
                      [
                        'Garage, Garden, Swimming Pool, Fiber...',
                        'Gym, Rooftop',
                        'None'
                      ],
                      (v) => setState(() => _amenities = v!)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: PrimaryButton(
              label: 'Continue',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const AddPropertyPhotosScreen()));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _dropdown(String label, String value, List<String> options,
      ValueChanged<String?> onChanged) {
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
              borderRadius: BorderRadius.circular(12)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down,
                  color: AppColors.textSecondary),
              style:
                  const TextStyle(color: AppColors.textPrimary, fontSize: 13),
              items: options
                  .map((o) => DropdownMenuItem(
                      value: o,
                      child: Text(o, overflow: TextOverflow.ellipsis)))
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
