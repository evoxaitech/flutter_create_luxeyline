import 'package:flutter/material.dart';
import '../../widgets/legal_text_scaffold.dart';

class TermsConditionScreen extends StatelessWidget {
  const TermsConditionScreen({super.key});

  static const _sections = [
    LegalSection('Terms',
        'Lorem ipsum is simply dummy text of the printing and typesetting industry. Lorem ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries but also the leap into electronic typesetting.'),
    LegalSection('Changes to the Service and/or Terms',
        'Lorem ipsum is simply dummy text of the printing and typesetting industry. Lorem ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries but also the leap into electronic typesetting.'),
  ];

  @override
  Widget build(BuildContext context) {
    return const LegalTextScaffold(
      title: 'Term & Condition',
      sections: _sections,
    );
  }
}
