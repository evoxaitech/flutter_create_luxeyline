import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/app_colors.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/primary_button.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final _cardName = TextEditingController();
  final _cardNumber = TextEditingController();
  final _expiry = TextEditingController();
  final _cvv = TextEditingController();

  @override
  void dispose() {
    _cardName.dispose();
    _cardNumber.dispose();
    _expiry.dispose();
    _cvv.dispose();
    super.dispose();
  }

  // Card ka type pehle digit se pehchano
  String get _cardType {
    final n = _cardNumber.text.replaceAll(' ', '');
    if (n.isEmpty) return '';
    if (n.startsWith('4')) return 'Visa';
    if (n.startsWith('5')) return 'Mastercard';
    return 'invalid';
  }

  void _saveCard() {
    final name = _cardName.text.trim();
    final number = _cardNumber.text.replaceAll(' ', '').trim();
    final expiry = _expiry.text.trim();
    final cvv = _cvv.text.trim();

    if (name.isEmpty) {
      _snack('Please enter card holder name');
      return;
    }
    // Sirf Visa (4) ya Mastercard (5) allowed
    if (_cardType == 'invalid') {
      _snack('Only Visa (starts with 4) or Mastercard (starts with 5) allowed');
      return;
    }
    if (number.length != 16) {
      _snack('Card number must be 16 digits');
      return;
    }
    if (expiry.length != 5) {
      _snack('Enter expiry as MM/YY');
      return;
    }
    if (cvv.length < 3) {
      _snack('Please enter a valid CVV');
      return;
    }

    final last4 = number.substring(number.length - 4);
    Navigator.pop(context, {
      'name': name,
      'last4': last4,
      'type': _cardType,
      'label': '•••• •••• •••• $last4',
    });
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.red),
    );
  }

  // Visa / Mastercard symbol (chhota badge)
  Widget _cardBadge() {
    if (_cardType == 'Visa') {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(6)),
        child: const Text('VISA',
            style: TextStyle(
                color: Color(0xFF1A1F71),
                fontWeight: FontWeight.w900,
                fontSize: 14,
                fontStyle: FontStyle.italic)),
      );
    }
    if (_cardType == 'Mastercard') {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.circle, color: Color(0xFFEB001B), size: 22),
          Transform.translate(
            offset: const Offset(-8, 0),
            child: const Icon(Icons.circle, color: Color(0xFFF79E1B), size: 22),
          ),
        ],
      );
    }
    return const Icon(Icons.credit_card, color: Colors.white, size: 26);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: const Text('Add Card',
            style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 17,
                fontWeight: FontWeight.w700)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---- Card preview ----
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, Color(0xFF15753D)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.wifi, color: Colors.white70, size: 22),
                        _cardBadge(),
                      ],
                    ),
                    const SizedBox(height: 26),
                    Text(
                      _cardNumber.text.isEmpty
                          ? '**** **** **** ****'
                          : _cardNumber.text,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          letterSpacing: 2,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _cardName.text.isEmpty
                              ? 'CARD HOLDER'
                              : _cardName.text.toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                        Text(
                          _expiry.text.isEmpty ? 'MM/YY' : _expiry.text,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              CustomTextField(
                label: 'Card Name',
                hint: 'Enter card holder name',
                controller: _cardName,
              ),

              // ---- Card Number (16 digit + spaces) ----
              _fieldLabel('Card Number'),
              TextField(
                controller: _cardNumber,
                keyboardType: TextInputType.number,
                onChanged: (_) => setState(() {}),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(16),
                  _CardNumberFormatter(),
                ],
                decoration: _dec('1234 5678 9012 3456',
                    suffix: _cardType == 'Visa' || _cardType == 'Mastercard'
                        ? Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(_cardType,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                    color: AppColors.primary)))
                        : null),
              ),
              const SizedBox(height: 18),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _fieldLabel('Expiry Date'),
                        TextField(
                          controller: _expiry,
                          keyboardType: TextInputType.number,
                          onChanged: (_) => setState(() {}),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(4),
                            _ExpiryFormatter(),
                          ],
                          decoration: _dec('MM/YY'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _fieldLabel('CVV / CVC'),
                        TextField(
                          controller: _cvv,
                          keyboardType: TextInputType.number,
                          obscureText: true,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(4),
                          ],
                          decoration: _dec('123'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              PrimaryButton(label: 'Add Card', onPressed: _saveCard),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fieldLabel(String t) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(t,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary)),
      );

  InputDecoration _dec(String hint, {Widget? suffix}) => InputDecoration(
        hintText: hint,
        suffixIcon: suffix,
        hintStyle:
            const TextStyle(color: AppColors.textSecondary, fontSize: 14),
        filled: true,
        fillColor: AppColors.fieldFill,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      );
}

// Card number ko 4-4-4-4 mein todta hai (1234 5678 9012 3456)
class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final digits = newValue.text.replaceAll(' ', '');
    final buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      if (i > 0 && i % 4 == 0) buffer.write(' ');
      buffer.write(digits[i]);
    }
    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}

// Expiry mein khud / lagata hai (12 -> 12/ -> 12/29)
class _ExpiryFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final digits = newValue.text.replaceAll('/', '');
    String out = digits;
    if (digits.length >= 3) {
      out = '${digits.substring(0, 2)}/${digits.substring(2)}';
    }
    return TextEditingValue(
      text: out,
      selection: TextSelection.collapsed(offset: out.length),
    );
  }
}
