import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/wizard_header.dart';
import 'add_property_details_screen.dart';

class AddPropertyGeneralInfoScreen extends StatefulWidget {
  const AddPropertyGeneralInfoScreen({super.key});

  @override
  State<AddPropertyGeneralInfoScreen> createState() =>
      _AddPropertyGeneralInfoScreenState();
}

class _AddPropertyGeneralInfoScreenState
    extends State<AddPropertyGeneralInfoScreen> {
  final _title = TextEditingController();
  final _description = TextEditingController();
  String _propertyType = 'Select type';
  String _propertyStatus = 'Select status';

  final _typeOptions = const [
    'Select type',
    'House',
    'Apartment',
    'Villa',
    'Land'
  ];
  final _statusOptions = const [
    'Select status',
    'For Sale',
    'For Rent',
    'Sold'
  ];

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
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
              step: 1,
              onBack: () => Navigator.pop(context)),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('General Information',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 16),
                  CustomTextField(
                      label: 'Property Title',
                      hint: 'Title',
                      controller: _title),
                  const Text('Property Description',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.fieldFill,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _description,
                      maxLines: 4,
                      maxLength: 300,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(14),
                        hintText: 'Short description',
                        hintStyle: TextStyle(
                            color: AppColors.textSecondary, fontSize: 13),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  _dropdown('Property Type', _propertyType, _typeOptions,
                      (v) => setState(() => _propertyType = v!)),
                  const SizedBox(height: 16),
                  _dropdown('Property Status', _propertyStatus, _statusOptions,
                      (v) => setState(() => _propertyStatus = v!)),
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
                        builder: (_) => const AddPropertyDetailsScreen()));
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
                  const TextStyle(color: AppColors.textPrimary, fontSize: 14),
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
