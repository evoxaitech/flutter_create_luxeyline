import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/wizard_header.dart';
import 'add_property_preview_screen.dart';

class AddPropertyLegalScreen extends StatefulWidget {
  const AddPropertyLegalScreen({super.key});

  @override
  State<AddPropertyLegalScreen> createState() => _AddPropertyLegalScreenState();
}

class _AddPropertyLegalScreenState extends State<AddPropertyLegalScreen> {
  String _ownershipStatus = 'Placeholder';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          WizardHeader(
              title: 'Add Property',
              step: 6,
              onBack: () => Navigator.pop(context)),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Legal and Documents',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 16),
                  const Text('Ownership Status',
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
                        value: _ownershipStatus,
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down,
                            color: AppColors.textSecondary),
                        style: const TextStyle(
                            color: AppColors.textPrimary, fontSize: 14),
                        items: const [
                          DropdownMenuItem(
                              value: 'Placeholder',
                              child: Text('Select status')),
                          DropdownMenuItem(
                              value: 'Freehold', child: Text('Freehold')),
                          DropdownMenuItem(
                              value: 'Leasehold', child: Text('Leasehold')),
                        ],
                        onChanged: (v) => setState(() => _ownershipStatus = v!),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Upload Documents (Optional)',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 20),
                      decoration: BoxDecoration(
                        color: AppColors.fieldFill,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: const Icon(Icons.add,
                                color: AppColors.primary, size: 22),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Option to upload supporting documents\n(certificate, IMB, etc)',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 11,
                                color: AppColors.textSecondary,
                                height: 1.5),
                          ),
                        ],
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
                        builder: (_) => const AddPropertyPreviewScreen()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
