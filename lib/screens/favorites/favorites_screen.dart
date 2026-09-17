import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/models/property.dart';
import '../../core/api/favourites_service.dart';
import '../../widgets/property_card.dart';
import '../property/property_detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final FavouritesService _service = FavouritesService();

  bool _loading = true;
  String? _error;
  List<Property> _favorites = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    final res = await _service.getFavourites();
    if (!mounted) return;
    if (res['success'] == true) {
      setState(() {
        _favorites = res['data'] as List<Property>;
        _loading = false;
      });
    } else {
      setState(() {
        _error = res['message']?.toString() ?? 'Could not load favourites';
        _loading = false;
      });
    }
  }

  Future<void> _remove(Property p) async {
    setState(() => _favorites.remove(p));
    await _service.removeFavourite(p.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Favorites',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                  IconButton(
                    icon: const Icon(Icons.refresh, color: AppColors.primary),
                    onPressed: _load,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: _loading
                    ? const Center(
                        child:
                            CircularProgressIndicator(color: AppColors.primary))
                    : _error != null
                        ? _errorView()
                        : _favorites.isEmpty
                            ? _emptyView()
                            : RefreshIndicator(
                                onRefresh: _load,
                                color: AppColors.primary,
                                child: ListView.builder(
                                  itemCount: _favorites.length,
                                  itemBuilder: (_, i) {
                                    final p = _favorites[i];
                                    return Dismissible(
                                      key: ValueKey(p.id),
                                      direction: DismissDirection.endToStart,
                                      onDismissed: (_) => _remove(p),
                                      background: Container(
                                        alignment: Alignment.centerRight,
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        margin:
                                            const EdgeInsets.only(bottom: 14),
                                        decoration: BoxDecoration(
                                          color: AppColors.danger,
                                          borderRadius:
                                              BorderRadius.circular(14),
                                        ),
                                        child: const Icon(Icons.delete,
                                            color: Colors.white),
                                      ),
                                      child: ListPropertyCard(
                                        property: p,
                                        onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  PropertyDetailScreen(
                                                      property: p)),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emptyView() {
    return ListView(
      children: const [
        SizedBox(height: 120),
        Icon(Icons.favorite_border, size: 60, color: AppColors.textSecondary),
        SizedBox(height: 12),
        Center(
          child: Text('No favorites yet',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        ),
        SizedBox(height: 6),
        Center(
          child: Text('Properties you like will appear here',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
        ),
      ],
    );
  }

  Widget _errorView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.wifi_off, size: 48, color: AppColors.textSecondary),
          const SizedBox(height: 12),
          Text(_error ?? 'Error',
              style: const TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: _load,
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
