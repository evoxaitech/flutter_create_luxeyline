import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/app_colors.dart';
import '../../core/api/auth_service.dart';
import '../../widgets/primary_button.dart';
import 'create_new_password_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;
  final bool isPasswordReset;
  const OtpVerificationScreen({
    super.key,
    required this.email,
    this.isPasswordReset = true,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _c =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _f = List.generate(6, (_) => FocusNode());
  final _auth = AuthService();

  bool _loading = false;
  int _seconds = 56;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _seconds = 56;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_seconds == 0) {
        t.cancel();
      } else {
        setState(() => _seconds--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _c) c.dispose();
    for (final n in _f) n.dispose();
    super.dispose();
  }

  String get _code => _c.map((e) => e.text).join();

  void _onChanged(int i, String v) {
    if (v.isNotEmpty && i < 5) {
      _f[i + 1].requestFocus();
    } else if (v.isEmpty && i > 0) {
      _f[i - 1].requestFocus();
    }
    setState(() {});
  }

  Future<void> _verify() async {
    if (_code.length < 6) {
      _snack('Please enter the full 6-digit code');
      return;
    }

    setState(() => _loading = true);
    final result = await _auth.verifyOtp(email: widget.email, code: _code);
    if (!mounted) return;
    setState(() => _loading = false);

    if (result['success'] == true) {
      final ticket = result['resetTicket']?.toString() ?? '';
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => CreateNewPasswordScreen(resetTicket: ticket),
        ),
      );
    } else {
      _snack(result['message']?.toString() ?? 'Invalid or expired code');
    }
  }

  Future<void> _resend() async {
    setState(() => _loading = true);
    final result = await _auth.forgotPassword(email: widget.email);
    if (!mounted) return;
    setState(() => _loading = false);

    if (result['success'] == true) {
      _startTimer();
      _snack('New code sent to your email 📧', success: true);
    } else {
      _snack(result['message']?.toString() ?? 'Could not resend code');
    }
  }

  void _snack(String msg, {bool success = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: success ? AppColors.primary : Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Enter Verification Code',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              Text(
                'We sent a 6-digit code to ${widget.email}. Enter it below to continue.',
                style: const TextStyle(
                    color: AppColors.textSecondary, height: 1.5, fontSize: 13),
              ),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (i) => _otpBox(i)),
              ),
              const SizedBox(height: 24),
              Center(
                child: Text(
                  _seconds > 0
                      ? 'You can resend the code in $_seconds seconds'
                      : 'Didn\'t get the code?',
                  style: const TextStyle(
                      color: AppColors.textSecondary, fontSize: 13),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: GestureDetector(
                  onTap: (_seconds == 0 && !_loading) ? _resend : null,
                  child: Text(
                    'Resend Code',
                    style: TextStyle(
                      color: _seconds == 0
                          ? AppColors.primary
                          : AppColors.disabled,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              PrimaryButton(
                label: _loading ? 'Verifying...' : 'Continue',
                onPressed: _loading ? () {} : _verify,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _otpBox(int i) {
    final filled = _c[i].text.isNotEmpty;
    return SizedBox(
      width: 48,
      height: 56,
      child: TextField(
        controller: _c[i],
        focusNode: _f[i],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (v) => _onChanged(i, v),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: filled ? AppColors.primaryLight : AppColors.grey,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
                color: filled ? AppColors.primary : AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
          ),
        ),
      ),
    );
  }
}
