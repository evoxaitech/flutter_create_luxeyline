import 'package:flutter/material.dart';
import '../../widgets/legal_text_scaffold.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  static const _sections = [
    LegalSection('1. Information Collection',
        'Lorem ipsum dolor sit amet consectetur. Faucibus viverra ante amet elementum pretium. Sapien id lobortis venenatis phasellus laoreet. Pulvinar pharetra magna vel augue. Massa parturient nisl tempor fringilla.'),
    LegalSection('2. Information Usage',
        'Lorem ipsum dolor sit amet consectetur. Faucibus viverra ante amet elementum pretium. Sapien id lobortis venenatis phasellus laoreet. Pulvinar pharetra magna vel augue. Massa parturient nisl tempor fringilla.'),
    LegalSection('3. Information Setting',
        'Lorem ipsum dolor sit amet consectetur. Faucibus viverra ante amet elementum pretium. Sapien id lobortis venenatis phasellus laoreet. Pulvinar pharetra magna vel augue. Massa parturient nisl tempor fringilla.'),
    LegalSection('4. Security Measures',
        'Lorem ipsum dolor sit amet consectetur. Faucibus viverra ante amet elementum pretium. Sapien id lobortis venenatis phasellus laoreet. Pulvinar pharetra magna vel augue. Massa parturient nisl tempor fringilla.'),
  ];

  @override
  Widget build(BuildContext context) {
    return const LegalTextScaffold(
      title: 'Privacy & Policy',
      effectiveDate: 'Effective Date: March 20, 2024',
      sections: _sections,
    );
  }
}
