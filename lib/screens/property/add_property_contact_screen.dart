import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/wizard_header.dart';
import 'add_property_settings_screen.dart';

class AddPropertyContactScreen extends StatefulWidget {
  const AddPropertyContactScreen({super.key});

  @override
  State<AddPropertyContactScreen> createState() =>
      _AddPropertyContactScreenState();
}

class _AddPropertyContactScreenState extends State<AddPropertyContactScreen> {
  final _sellerName = TextEditingController(text: 'Jane Doe');
  final _phone = TextEditingController(text: '(409) 487-1935');
  final _email = TextEditingController(text: 'jane.doe@example.com');
  final _hours = TextEditingController(text: '09:00 - 18:00 WIB');

  @override
  void dispose() {
    _sellerName.dispose();
    _phone.dispose();
    _email.dispose();
    _hours.dispose();
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
              step: 4,
              onBack: () => Navigator.pop(context)),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Contact Information',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 16),
                  CustomTextField(
                      label: 'Seller Name',
                      hint: 'Jane Doe',
                      controller: _sellerName),
                  const Text('Phone Number',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        height: 52,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: AppColors.fieldFill,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('🇺🇸', style: TextStyle(fontSize: 18)),
                            SizedBox(width: 6),
                            Text('+1',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600)),
                            Icon(Icons.arrow_drop_down,
                                size: 18, color: AppColors.textSecondary),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          height: 52,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            color: AppColors.fieldFill,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: _phone,
                            keyboardType: TextInputType.phone,
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                      label: 'Email Address',
                      hint: 'jane.doe@example.com',
                      controller: _email,
                      keyboardType: TextInputType.emailAddress),
                  CustomTextField(
                      label: 'Available Hours',
                      hint: '09:00 - 18:00 WIB',
                      controller: _hours),
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
                        builder: (_) => const AddPropertySettingsScreen()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
