import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/primary_button.dart';

class PersonalDataScreen extends StatefulWidget {
  const PersonalDataScreen({super.key});

  @override
  State<PersonalDataScreen> createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  final _name = TextEditingController(text: 'Aaron Ramsdale');
  final _email = TextEditingController(text: 'aaronramsdale@gmail.com');
  final _phone = TextEditingController(text: '(409) 487-1935');

  DateTime _dob = DateTime(1998, 12, 20);
  String _gender = 'Male';

  String _countryFlag = '🇺🇸';
  String _countryCode = '+1';

  final List<Map<String, String>> _countries = const [
    {'flag': '🇺🇸', 'code': '+1', 'name': 'United States'},
    {'flag': '🇵🇰', 'code': '+92', 'name': 'Pakistan'},
    {'flag': '🇦🇪', 'code': '+971', 'name': 'UAE'},
    {'flag': '🇰🇼', 'code': '+965', 'name': 'Kuwait'},
    {'flag': '🇸🇦', 'code': '+966', 'name': 'Saudi Arabia'},
    {'flag': '🇬🇧', 'code': '+44', 'name': 'United Kingdom'},
    {'flag': '🇮🇳', 'code': '+91', 'name': 'India'},
  ];

  static const _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  String get _dobText => '${_months[_dob.month - 1]} ${_dob.day}, ${_dob.year}';

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dob,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _dob = picked);
  }

  void _openCountryPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 12),
        children: _countries.map((c) {
          return ListTile(
            leading: Text(c['flag']!, style: const TextStyle(fontSize: 24)),
            title: Text(c['name']!),
            trailing: Text(c['code']!,
                style: const TextStyle(
                    color: AppColors.textSecondary, fontSize: 14)),
            onTap: () {
              setState(() {
                _countryFlag = c['flag']!;
                _countryCode = c['code']!;
              });
              Navigator.pop(context);
            },
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(context, 'Personal Data'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  const CircleAvatar(
                    radius: 44,
                    backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1633332755192-727a05c4013d?w=200&q=80'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child:
                          const Icon(Icons.edit, size: 14, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            CustomTextField(
                label: 'Full Name', hint: 'Enter your name', controller: _name),
            CustomTextField(
                label: 'Email',
                hint: 'Enter your email',
                controller: _email,
                keyboardType: TextInputType.emailAddress),
            const Text('Phone Number',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                  color: AppColors.fieldFill,
                  borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: _openCountryPicker,
                    child: Row(
                      children: [
                        Text('$_countryFlag  $_countryCode',
                            style: const TextStyle(fontSize: 14)),
                        const Icon(Icons.keyboard_arrow_down,
                            size: 18, color: AppColors.textSecondary),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(width: 1, height: 22, color: AppColors.border),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _phone,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text('Date of Birth',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _pickDate,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
                decoration: BoxDecoration(
                    color: AppColors.fieldFill,
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(_dobText,
                            style: const TextStyle(
                                fontSize: 14, color: AppColors.textPrimary))),
                    const Icon(Icons.calendar_today_outlined,
                        size: 18, color: AppColors.textSecondary),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Gender',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                  color: AppColors.fieldFill,
                  borderRadius: BorderRadius.circular(12)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _gender,
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down,
                      color: AppColors.textSecondary),
                  style: const TextStyle(
                      color: AppColors.textPrimary, fontSize: 14),
                  items: const ['Male', 'Female', 'Other']
                      .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                      .toList(),
                  onChanged: (v) => setState(() => _gender = v!),
                ),
              ),
            ),
            const SizedBox(height: 32),
            PrimaryButton(
              label: 'Save Changes',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Changes saved')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

PreferredSizeWidget _appBar(BuildContext context, String title) {
  return AppBar(
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
  );
}
