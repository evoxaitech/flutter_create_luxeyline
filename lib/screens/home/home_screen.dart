import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/models/property.dart';
import '../../core/api/property_service.dart';
import '../../core/api/token_storage.dart';
import '../../widgets/category_chips.dart';
import '../../widgets/property_card.dart';
import '../search/search_screen.dart';
import '../property/property_detail_screen.dart';
import '../notifications/notifications_screen.dart';
import '../favorites/favorites_screen.dart';
import '../auth/login_screen.dart';
import 'recommendation_screen.dart';
import 'featured_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PropertyService _service = PropertyService();

  String _category = 'Popular';
  bool _loading = true;
  String? _error;
  List<Property> _featured = [];
  List<Property> _recommended = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    final results = await Future.wait([
      _service.getFeatured(),
      _service.getRecommended(),
    ]);
    if (!mounted) return;
    final featuredRes = results[0];
    final recommendedRes = results[1];
    if (featuredRes['success'] == true && recommendedRes['success'] == true) {
      setState(() {
        _featured = featuredRes['data'] as List<Property>;
        _recommended = recommendedRes['data'] as List<Property>;
        _loading = false;
      });
    } else {
      setState(() {
        _error = featuredRes['message']?.toString() ??
            recommendedRes['message']?.toString() ??
            'Could not load properties';
        _loading = false;
      });
    }
  }

  void _openProfileMenu() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(4)),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.logout, color: AppColors.danger),
              title: const Text('Log Out',
                  style: TextStyle(
                      color: AppColors.danger, fontWeight: FontWeight.w600)),
              onTap: () {
                Navigator.pop(sheetContext);
                _confirmLogout();
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _confirmLogout() {
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
                elevation: 0),
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredFeatured = _category == 'Popular'
        ? _featured
        : _featured
            .where((p) => p.type.toUpperCase() == _category.toUpperCase())
            .toList();
    final filteredRecommended = _category == 'Popular'
        ? _recommended
        : _recommended
            .where((p) => p.type.toUpperCase() == _category.toUpperCase())
            .toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadData,
          color: AppColors.primary,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            children: [
              // ---------- Header ----------
              Row(
                children: [
                  GestureDetector(
                    onTap: _openProfileMenu,
                    child: const CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1633332755192-727a05c4013d?w=200&q=80'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: _openProfileMenu,
                      behavior: HitTestBehavior.opaque,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Your Location',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: AppColors.textSecondary)),
                          SizedBox(height: 2),
                          Row(
                            children: [
                              Icon(Icons.location_on,
                                  size: 14, color: AppColors.primary),
                              SizedBox(width: 4),
                              Text('Chicago, New York',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // ----- Favourites (heart) -----
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const FavoritesScreen())),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.border),
                      ),
                      child: const Icon(Icons.favorite_border,
                          size: 20, color: AppColors.textPrimary),
                    ),
                  ),
                  // ----- Notifications (bell) -----
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const NotificationsScreen())),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          const Icon(Icons.notifications_none,
                              size: 20, color: AppColors.textPrimary),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: AppColors.danger,
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.white, width: 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const SearchScreen())),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                  decoration: BoxDecoration(
                    color: AppColors.fieldFill,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.search,
                          color: AppColors.textSecondary, size: 20),
                      SizedBox(width: 10),
                      Text('Search apart, hotel, etc',
                          style: TextStyle(
                              color: AppColors.textSecondary, fontSize: 13)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              CategoryChips(
                onCategorySelected: (cat) => setState(() => _category = cat),
              ),
              const SizedBox(height: 22),
              if (_loading)
                const Padding(
                  padding: EdgeInsets.only(top: 80),
                  child: Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                )
              else if (_error != null)
                _errorBox()
              else
                ..._buildContent(filteredFeatured, filteredRecommended),
            ],
          ),
        ),
      ),
    );
  }

  Widget _errorBox() {
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: Column(
        children: [
          const Icon(Icons.wifi_off, size: 48, color: AppColors.textSecondary),
          const SizedBox(height: 12),
          Text(_error ?? 'Something went wrong',
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _loadData,
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildContent(
      List<Property> featured, List<Property> recommended) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
              _category == 'Popular'
                  ? 'Featured Property'
                  : '$_category Property',
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          GestureDetector(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const FeaturedScreen())),
            child: const Text('See All',
                style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 12)),
          ),
        ],
      ),
      const SizedBox(height: 14),
      if (featured.isEmpty)
        Container(
          height: 120,
          alignment: Alignment.center,
          child: Text('No $_category properties found',
              style: const TextStyle(
                  color: AppColors.textSecondary, fontSize: 13)),
        )
      else
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: featured.length,
            itemBuilder: (_, i) {
              final p = featured[i];
              return FeaturedPropertyCard(
                property: p,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => PropertyDetailScreen(property: p)),
                ),
              );
            },
          ),
        ),
      const SizedBox(height: 22),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Our Recomendation',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const RecommendationScreen())),
            child: const Text('See All',
                style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 12)),
          ),
        ],
      ),
      const SizedBox(height: 14),
      if (recommended.isEmpty)
        Container(
          height: 100,
          alignment: Alignment.center,
          child: Text('No $_category recommendations found',
              style: const TextStyle(
                  color: AppColors.textSecondary, fontSize: 13)),
        )
      else
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: recommended.length,
          itemBuilder: (_, i) {
            final p = recommended[i];
            return ListPropertyCard(
              property: p,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => PropertyDetailScreen(property: p)),
              ),
            );
          },
        ),
    ];
  }
}
