import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../widgets/primary_button.dart';
import 'select_location_screen.dart';

class SelectLanguageScreen extends StatefulWidget {
  const SelectLanguageScreen({super.key});

  @override
  State<SelectLanguageScreen> createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
  int _selected = 0;

  final _languages = const [
    {'name': 'English', 'native': 'English'},
    {'name': 'Spanish', 'native': 'Español'},
    {'name': 'French', 'native': 'Français'},
    {'name': 'German', 'native': 'Deutsch'},
    {'name': 'Arabic', 'native': 'العربية'},
    {'name': 'Hindi', 'native': 'हिन्दी'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.language, color: AppColors.primary, size: 44),
              const SizedBox(height: 20),
              const Text('Select Language',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              const Text(
                'Choose your preferred language to continue using the app.',
                style: TextStyle(color: AppColors.textSecondary, height: 1.5),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.separated(
                  itemCount: _languages.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (_, i) {
                    final sel = _selected == i;
                    return GestureDetector(
                      onTap: () => setState(() => _selected = i),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          color: sel ? AppColors.primaryLight : Colors.white,
                          border: Border.all(
                              color:
                                  sel ? AppColors.primary : AppColors.border),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(_languages[i]['name']!,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600)),
                                  Text(_languages[i]['native']!,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: AppColors.textSecondary)),
                                ],
                              ),
                            ),
                            Icon(
                              sel
                                  ? Icons.radio_button_checked
                                  : Icons.radio_button_off,
                              color: sel
                                  ? AppColors.primary
                                  : AppColors.textSecondary,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              PrimaryButton(
                label: 'Continue',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const SelectLocationScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
