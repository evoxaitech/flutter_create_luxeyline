import 'package:flutter/material.dart';
import 'package:luxeyline/core/app_colors.dart';

class LegalTextScaffold extends StatelessWidget {
  final String title;
  final String? effectiveDate;
  final List<(String, String)> sections;

  const LegalTextScaffold({
    super.key,
    required this.title,
    this.effectiveDate,
    required this.sections,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: const BoxDecoration(
                  color: AppColors.fieldFill, shape: BoxShape.circle),
              child: const Icon(Icons.arrow_back,
                  color: AppColors.textPrimary, size: 20),
            ),
          ),
        ),
        title: Text(title,
            style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 17,
                fontWeight: FontWeight.w700)),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          if (effectiveDate != null) ...[
            Text(effectiveDate!,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary)),
            const SizedBox(height: 16),
          ],
          ...sections.map((s) => Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(s.$1,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 8),
                    Text(s.$2,
                        style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                            height: 1.6)),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
