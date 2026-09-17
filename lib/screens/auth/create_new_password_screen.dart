import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/api/auth_service.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/primary_button.dart';
import 'password_reset_success_screen.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  final String resetTicket;
  const CreateNewPasswordScreen({super.key, required this.resetTicket});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final _newPassword = TextEditingController();
  final _confirmPassword = TextEditingController();
  final _auth = AuthService();
  bool _loading = false;

  @override
  void dispose() {
    _newPassword.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final pass = _newPassword.text;
    final confirm = _confirmPassword.text;

    // validation
    if (pass.length < 8) {
      _snack('Password must be at least 8 characters');
      return;
    }
    if (pass != confirm) {
      _snack('Passwords do not match');
      return;
    }

    setState(() => _loading = true);
    final result = await _auth.resetPassword(
      resetTicket: widget.resetTicket,
      newPassword: pass,
    );
    if (!mounted) return;
    setState(() => _loading = false);

    if (result['success'] == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const PasswordResetSuccessScreen()),
      );
    } else {
      _snack(result['message']?.toString() ?? 'Could not reset password');
    }
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.red),
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
              const Text('Create New Password',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              const Text(
                'Your new password must be at least 8 characters and different from previous passwords.',
                style: TextStyle(
                    color: AppColors.textSecondary, height: 1.5, fontSize: 13),
              ),
              const SizedBox(height: 28),
              CustomTextField(
                  label: 'New Password',
                  hint: 'Enter new password',
                  controller: _newPassword,
                  isPassword: true),
              CustomTextField(
                  label: 'Confirm Password',
                  hint: 'Re-enter new password',
                  controller: _confirmPassword,
                  isPassword: true),
              const SizedBox(height: 24),
              PrimaryButton(
                label: _loading ? 'Saving...' : 'Create New Password',
                onPressed: _loading ? () {} : _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
