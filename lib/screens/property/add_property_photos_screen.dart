import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/wizard_header.dart';
import 'add_property_contact_screen.dart';

class AddPropertyPhotosScreen extends StatefulWidget {
  const AddPropertyPhotosScreen({super.key});

  @override
  State<AddPropertyPhotosScreen> createState() =>
      _AddPropertyPhotosScreenState();
}

class _AddPropertyPhotosScreenState extends State<AddPropertyPhotosScreen> {
  String _uploadMedia = 'Photos';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          WizardHeader(
              title: 'Add Property',
              step: 3,
              onBack: () => Navigator.pop(context)),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Photos and Media',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 16),
                  const Text('Upload Media',
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
                        value: _uploadMedia,
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down,
                            color: AppColors.textSecondary),
                        style: const TextStyle(
                            color: AppColors.textPrimary, fontSize: 14),
                        items: const [
                          DropdownMenuItem(
                              value: 'Photos', child: Text('Photos')),
                          DropdownMenuItem(
                              value: 'Videos', child: Text('Videos')),
                          DropdownMenuItem(
                              value: '3D Tour', child: Text('3D Tour')),
                        ],
                        onChanged: (v) => setState(() => _uploadMedia = v!),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('Upload Property Photos',
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
                        border: Border.all(
                            color: AppColors.border, style: BorderStyle.solid),
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
                            'Upload photos of the property from various\nangles: front view, living rooms, bedrooms,\nkitchen, backyard',
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
                        builder: (_) => const AddPropertyContactScreen()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
