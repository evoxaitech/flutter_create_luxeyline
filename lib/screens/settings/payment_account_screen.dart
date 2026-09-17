import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/app_colors.dart';
import '../../widgets/primary_button.dart';

class PaymentAccountScreen extends StatelessWidget {
  const PaymentAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final methods = [
      _PayMethod('Apple Pay', Icons.apple, Colors.black),
      _PayMethod(
          'Google Pay', Icons.account_balance_wallet, const Color(0xFF4285F4)),
      _PayMethod('PayPal', Icons.payment, const Color(0xFF003087)),
    ];

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
        title: const Text('Payment Account',
            style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 17,
                fontWeight: FontWeight.w700)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ...methods.map((m) => Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      Icon(m.icon, color: m.color, size: 26),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(m.name,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600)),
                      ),
                      const Text('Connected',
                          style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 13,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                )),
            const Spacer(),
            PrimaryButton(
              label: 'Add New Card',
              onPressed: () => _openAddCard(context),
            ),
          ],
        ),
      ),
    );
  }

  void _openAddCard(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const _AddCardSheet(),
    );
  }
}

class _PayMethod {
  final String name;
  final IconData icon;
  final Color color;
  const _PayMethod(this.name, this.icon, this.color);
}

class _AddCardSheet extends StatefulWidget {
  const _AddCardSheet();

  @override
  State<_AddCardSheet> createState() => _AddCardSheetState();
}

class _AddCardSheetState extends State<_AddCardSheet> {
  final _number = TextEditingController();
  final _name = TextEditingController();
  final _expiry = TextEditingController();
  final _cvv = TextEditingController();

  @override
  void dispose() {
    _number.dispose();
    _name.dispose();
    _expiry.dispose();
    _cvv.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      // keyboard ke upar rehne ke liye
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 44,
              height: 5,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text('Add New Card',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          const Text('Enter your card details securely.',
              style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
          const SizedBox(height: 20),
          _label('Card Number'),
          _field(
            controller: _number,
            hint: '1234 5678 9012 3456',
            keyboardType: TextInputType.number,
            maxLength: 19,
            formatters: [
              FilteringTextInputFormatter.digitsOnly,
              _CardNumberFormatter(),
            ],
            icon: Icons.credit_card,
          ),
          const SizedBox(height: 14),
          _label('Card Holder Name'),
          _field(
            controller: _name,
            hint: 'Zareen',
            keyboardType: TextInputType.name,
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _label('Expiry Date'),
                    _field(
                      controller: _expiry,
                      hint: 'MM/YY',
                      keyboardType: TextInputType.number,
                      maxLength: 5,
                      formatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        _ExpiryFormatter(),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _label('CVV'),
                    _field(
                      controller: _cvv,
                      hint: '123',
                      keyboardType: TextInputType.number,
                      maxLength: 3,
                      obscure: true,
                      formatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            label: 'Save Card',
            onPressed: () {
              if (_number.text.trim().isEmpty ||
                  _name.text.trim().isEmpty ||
                  _expiry.text.trim().isEmpty ||
                  _cvv.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please fill all fields')),
                );
                return;
              }
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Card added successfully')),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(text,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
      );

  Widget _field({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    int? maxLength,
    bool obscure = false,
    List<TextInputFormatter>? formatters,
    IconData? icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.fieldFill,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 20, color: AppColors.textSecondary),
            const SizedBox(width: 10),
          ],
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              obscureText: obscure,
              maxLength: maxLength,
              inputFormatters: formatters,
              decoration: InputDecoration(
                border: InputBorder.none,
                counterText: '',
                hintText: hint,
                hintStyle: const TextStyle(
                    color: AppColors.textSecondary, fontSize: 14),
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Card number ko 4-4-4-4 mein space deta hai
class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final digits = newValue.text.replaceAll(' ', '');
    final buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      if (i != 0 && i % 4 == 0) buffer.write(' ');
      buffer.write(digits[i]);
    }
    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}

// Expiry ko MM/YY banata hai
class _ExpiryFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final digits = newValue.text.replaceAll('/', '');
    final buffer = StringBuffer();
    for (int i = 0; i < digits.length && i < 4; i++) {
      if (i == 2) buffer.write('/');
      buffer.write(digits[i]);
    }
    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}
