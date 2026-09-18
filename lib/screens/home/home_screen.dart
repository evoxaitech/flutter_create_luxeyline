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
import 'news_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PropertyService _service = PropertyService();

  static const String _userPhoto =
      'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=200&q=80';

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

  // ============ API LOGIC — bilkul same, kuch nahi chhera ============
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
  // ==================================================================

  void _openProfileMenu() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            children: [
              _header(),
              const SizedBox(height: 22),
              _headline(),
              const SizedBox(height: 18),
              _searchBar(),
              const SizedBox(height: 20),
              CategoryChips(
                onCategorySelected: (cat) => setState(() => _category = cat),
              ),
              const SizedBox(height: 24),
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

  Widget _header() {
    return Row(
      children: [
        GestureDetector(
          onTap: _openProfileMenu,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primaryLight, width: 2),
            ),
            child: const CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(_userPhoto),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: _openProfileMenu,
            behavior: HitTestBehavior.opaque,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Hi, Zareen',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.2,
                        color: AppColors.textPrimary)),
                SizedBox(height: 3),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 14, color: AppColors.primary),
                    SizedBox(width: 3),
                    Text('Islamabad, Pakistan',
                        style: TextStyle(
                            fontSize: 12, color: AppColors.textSecondary)),
                  ],
                ),
              ],
            ),
          ),
        ),
        _circleAction(
          icon: Icons.favorite_border,
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const FavoritesScreen())),
        ),
        const SizedBox(width: 10),
        _circleAction(
          icon: Icons.notifications_none,
          showBadge: true,
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const NotificationsScreen())),
        ),
      ],
    );
  }

  Widget _circleAction({
    required IconData icon,
    required VoidCallback onTap,
    bool showBadge = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.surface,
          shape: BoxShape.circle,
          boxShadow: AppColors.subtleShadow,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Icon(icon, size: 20, color: AppColors.textPrimary),
            if (showBadge)
              Positioned(
                right: 11,
                top: 11,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.danger,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.surface, width: 1.5),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _headline() {
    return RichText(
      text: const TextSpan(
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w800,
          height: 1.15,
          letterSpacing: -0.6,
          color: AppColors.textPrimary,
        ),
        children: [
          TextSpan(text: 'Find your dream\n'),
          TextSpan(text: 'home', style: TextStyle(color: AppColors.primary)),
          TextSpan(text: ' with ease'),
        ],
      ),
    );
  }

  Widget _searchBar() {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => const SearchScreen())),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
          boxShadow: AppColors.subtleShadow,
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: AppColors.textSecondary, size: 21),
            const SizedBox(width: 10),
            const Expanded(
              child: Text('Search apartment, hotel, etc',
                  style:
                      TextStyle(color: AppColors.textSecondary, fontSize: 13)),
            ),
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.tune, color: Colors.white, size: 17),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title, VoidCallback onSeeAll) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.3,
                color: AppColors.textPrimary)),
        GestureDetector(
          onTap: onSeeAll,
          child: Row(
            children: const [
              Text('See All',
                  style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 12)),
              SizedBox(width: 3),
              Icon(Icons.arrow_forward_ios, size: 11, color: AppColors.primary),
            ],
          ),
        ),
      ],
    );
  }

  Widget _emptyBox(String text, double height) {
    return Container(
      height: height,
      alignment: Alignment.center,
      child: Text(text,
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
    );
  }

  // ---------- Latest Property News (NAYA) ----------
  Widget _newsCard(String tag, String title, String image) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => const NewsScreen())),
      child: Container(
        width: 230,
        margin: const EdgeInsets.only(right: 14, top: 2, bottom: 4),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: AppColors.softShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(image,
                  height: 100,
                  width: 230,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => Container(
                      height: 100,
                      width: 230,
                      color: AppColors.grey,
                      child: const Icon(Icons.article_outlined,
                          color: AppColors.textSecondary))),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(tag,
                        style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(height: 8),
                  Text(title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          height: 1.3,
                          color: AppColors.textPrimary)),
                ],
              ),
            ),
          ],
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
                foregroundColor: Colors.white,
                elevation: 0,
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildContent(
      List<Property> featured, List<Property> recommended) {
    return [
      _sectionHeader(
        _category == 'Popular' ? 'Featured Property' : '$_category Property',
        () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => const FeaturedScreen())),
      ),
      const SizedBox(height: 14),
      if (featured.isEmpty)
        _emptyBox('No $_category properties found', 120)
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
      const SizedBox(height: 24),
      _sectionHeader(
        'Our Recommendations',
        () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const RecommendationScreen())),
      ),
      const SizedBox(height: 14),
      if (recommended.isEmpty)
        _emptyBox('No $_category recommendations found', 100)
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
      // ---------- Latest Property News section ----------
      const SizedBox(height: 24),
      _sectionHeader(
        'Latest Property News',
        () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => const NewsScreen())),
      ),
      const SizedBox(height: 14),
      SizedBox(
        height: 190,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            _newsCard(
                'Tips',
                "'Old Labor Club' warehouse set to smash suburb records",
                'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=600&q=80'),
            _newsCard(
                'Trends',
                'Incredible awe-inspiring bayside home ticks every box',
                'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=600&q=80'),
          ],
        ),
      ),
      const SizedBox(height: 10),
    ];
  }
}
