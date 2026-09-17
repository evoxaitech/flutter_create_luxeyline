import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/wizard_header.dart';
import 'add_property_success_screen.dart';

class AddPropertyPreviewScreen extends StatefulWidget {
  const AddPropertyPreviewScreen({super.key});

  @override
  State<AddPropertyPreviewScreen> createState() =>
      _AddPropertyPreviewScreenState();
}

class _AddPropertyPreviewScreenState extends State<AddPropertyPreviewScreen> {
  final _title =
      TextEditingController(text: '3 Bedroom Luxury House in City Center');
  final _description = TextEditingController(
      text:
          'A luxurious 3-bedroom house with a modern design in the city center. The property features a spacious living room, fully equipped kitchen, and a backyard ide...');
  String _propertyType = 'House';
  String _propertyStatus = 'For sale';

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
              step: 7,
              onBack: () => Navigator.pop(context)),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Preview and Submit',
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
                        borderRadius: BorderRadius.circular(12)),
                    child: TextField(
                      controller: _description,
                      maxLines: 4,
                      maxLength: 300,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  _dropdown(
                      'Property Type',
                      _propertyType,
                      ['House', 'Apartment', 'Villa', 'Land'],
                      (v) => setState(() => _propertyType = v!)),
                  const SizedBox(height: 16),
                  _dropdown(
                      'Property Status',
                      _propertyStatus,
                      ['For sale', 'For rent', 'Sold'],
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
                        builder: (_) => const AddPropertySuccessScreen()));
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
