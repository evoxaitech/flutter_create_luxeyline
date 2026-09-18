import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/api/token_storage.dart';
import '../auth/login_screen.dart';
import '../notifications/notifications_screen.dart';
import 'personal_data_screen.dart';
import 'payment_account_screen.dart';
import 'my_listings_screen.dart';
import 'bookings_tours_screen.dart';
import 'help_center_screen.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const String _userPhoto =
      'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=200&q=80';

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Log Out',
            style: TextStyle(fontWeight: FontWeight.w700)),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel',
                style: TextStyle(color: AppColors.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () async {
              await TokenStorage.clearToken();
              if (!context.mounted) return;
              Navigator.pop(dialogContext);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.danger,
              foregroundColor: Colors.white,
              elevation: 0,
            ),
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }

  void _go(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          children: [
            const Text('Profile',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: AppColors.primaryLight, width: 2.5),
                  ),
                  child: const CircleAvatar(
                    radius: 34,
                    backgroundImage: NetworkImage(_userPhoto),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Zareen',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w700)),
                      SizedBox(height: 4),
                      Text('zareen@luxeyline.com',
                          style: TextStyle(
                              fontSize: 12, color: AppColors.textSecondary)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => _go(context, const PersonalDataScreen()),
                  child: const Icon(Icons.edit,
                      color: AppColors.primary, size: 20),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _section('Account', [
              _ProfileTile(
                  icon: Icons.person_outline,
                  label: 'Personal Information',
                  onTap: () => _go(context, const PersonalDataScreen())),
              _ProfileTile(
                  icon: Icons.notifications_none,
                  label: 'Notifications',
                  onTap: () => _go(context, const NotificationsScreen())),
              _ProfileTile(
                  icon: Icons.payment_outlined,
                  label: 'Payment Methods',
                  onTap: () => _go(context, const PaymentAccountScreen())),
            ]),
            const SizedBox(height: 20),
            _section('Property', [
              _ProfileTile(
                  icon: Icons.home_work_outlined,
                  label: 'My Listings',
                  onTap: () => _go(context, const MyListingsScreen())),
              _ProfileTile(
                  icon: Icons.calendar_today_outlined,
                  label: 'Bookings & Tours',
                  onTap: () => _go(context, const BookingsToursScreen())),
            ]),
            const SizedBox(height: 20),
            _section('Support', [
              _ProfileTile(
                  icon: Icons.help_outline,
                  label: 'Help Center',
                  onTap: () => _go(context, const HelpCenterScreen())),
              _ProfileTile(
                  icon: Icons.settings_outlined,
                  label: 'Settings',
                  onTap: () => _go(context, const SettingsScreen())),
              _ProfileTile(
                icon: Icons.logout,
                label: 'Log Out',
                labelColor: AppColors.danger,
                onTap: () => _logout(context),
              ),
            ]),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _section(String title, List<Widget> tiles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.textSecondary)),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: AppColors.subtleShadow,
          ),
          child: Column(children: tiles),
        ),
      ],
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? labelColor;
  final VoidCallback onTap;
  const _ProfileTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: labelColor ?? AppColors.textPrimary),
      title: Text(label,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: labelColor ?? AppColors.textPrimary)),
      trailing: const Icon(Icons.chevron_right,
          size: 18, color: AppColors.textSecondary),
      onTap: onTap,
    );
  }
}
