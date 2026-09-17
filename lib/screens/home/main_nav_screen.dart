import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import 'home_screen.dart';
import '../explore/explore_screen.dart';
import '../messages/messages_screen.dart';
import '../profile/profile_screen.dart';

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  int _index = 0;

  final _screens = const [
    HomeScreen(),
    ExploreScreen(),
    MessagesScreen(),
    ProfileScreen(),
  ];

  void _onTap(int i) => setState(() => _index = i);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _screens),
      bottomNavigationBar: Container(
        height: 74,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black12, blurRadius: 10, offset: Offset(0, -2)),
          ],
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(Icons.home_outlined, Icons.home, 'Home', 0),
              _navItem(Icons.search_outlined, Icons.search, 'Explore', 1),
              GestureDetector(
                onTap: () => _onTap(0),
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.apartment,
                      color: Colors.white, size: 24),
                ),
              ),
              _navItem(
                  Icons.chat_bubble_outline, Icons.chat_bubble, 'Messages', 2),
              _navItem(Icons.person_outline, Icons.person, 'Profile', 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, IconData activeIcon, String label, int i) {
    final sel = _index == i;
    return GestureDetector(
      onTap: () => _onTap(i),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(sel ? activeIcon : icon,
              color: sel ? AppColors.primary : AppColors.textSecondary,
              size: 22),
          const SizedBox(height: 4),
          Text(label,
              style: TextStyle(
                  fontSize: 10,
                  color: sel ? AppColors.primary : AppColors.textSecondary,
                  fontWeight: sel ? FontWeight.w600 : FontWeight.w400)),
        ],
      ),
    );
  }
}
