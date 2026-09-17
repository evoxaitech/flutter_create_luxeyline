import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/wizard_header.dart';
import 'add_property_legal_screen.dart';

class AddPropertySettingsScreen extends StatefulWidget {
  const AddPropertySettingsScreen({super.key});

  @override
  State<AddPropertySettingsScreen> createState() =>
      _AddPropertySettingsScreenState();
}

class _AddPropertySettingsScreenState extends State<AddPropertySettingsScreen> {
  String _publishingStatus = 'Publish';
  final _schedule =
      TextEditingController(text: 'Saturday, 10:00 AM - 12:00 PM');
  final _notes = TextEditingController(
      text:
          'The house was newly renovated in 2022 with high-quality materials.');

  @override
  void dispose() {
    _schedule.dispose();
    _notes.dispose();
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
              step: 5,
              onBack: () => Navigator.pop(context)),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Additional Settings',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 16),
                  const Text('Publishing Status',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                        color: AppColors.fieldFill,
                        borderRadius: BorderRadius.circular(12)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _publishingStatus,
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down,
                            color: AppColors.textSecondary),
                        style: const TextStyle(
                            color: AppColors.textPrimary, fontSize: 14),
                        items: const [
                          DropdownMenuItem(
                              value: 'Publish', child: Text('Publish')),
                          DropdownMenuItem(
                              value: 'Draft', child: Text('Draft')),
                          DropdownMenuItem(
                              value: 'Scheduled', child: Text('Scheduled')),
                        ],
                        onChanged: (v) =>
                            setState(() => _publishingStatus = v!),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                      label: 'Open House Schedule',
                      hint: 'Saturday, 10:00 AM - 12:00 PM',
                      controller: _schedule),
                  const Text('Additional Notes',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.fieldFill,
                        borderRadius: BorderRadius.circular(12)),
                    child: TextField(
                      controller: _notes,
                      maxLines: 4,
                      maxLength: 300,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(14),
                      ),
                    ),
                  ),
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
                        builder: (_) => const AddPropertyLegalScreen()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
