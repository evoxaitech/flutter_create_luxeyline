import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../core/app_colors.dart';
import '../../core/models/property.dart';
import '../../core/api/favourites_service.dart';
import '../../widgets/property_card.dart';
import 'property_gallery_screen.dart';
import '../booking/payment_method_screen.dart';
import '../messages/chat_screen.dart';
import '../messages/voice_call_screen.dart';

class PropertyDetailScreen extends StatefulWidget {
  final Property property;
  const PropertyDetailScreen({super.key, required this.property});

  @override
  State<PropertyDetailScreen> createState() => _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends State<PropertyDetailScreen> {
  final FavouritesService _favService = FavouritesService();
  bool _isFav = false;
  bool _favLoading = false;
  int _featureTab = 0;

  // Listing agent (professional larki) — chat/call ke liye bhi yahi
  static const String _agentPhoto =
      'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=200&q=80';

  Future<void> _toggleFav() async {
    setState(() => _favLoading = true);
    final id = widget.property.id;
    final ok = _isFav
        ? await _favService.removeFavourite(id)
        : await _favService.addFavourite(id);
    if (!mounted) return;
    setState(() {
      if (ok) _isFav = !_isFav;
      _favLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(ok
          ? (_isFav ? 'Added to favourites ❤️' : 'Removed from favourites')
          : 'Something went wrong'),
      backgroundColor: ok ? AppColors.primary : Colors.red,
    ));
  }

  void _openChat() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              const ChatScreen(agentName: 'Zareen', agentImage: _agentPhoto),
        ));
  }

  void _openCall() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const VoiceCallScreen(
              agentName: 'Zareen', agentImage: _agentPhoto),
        ));
  }

  // Har feature tab ki alag details
  List<Widget> _featureContent() {
    switch (_featureTab) {
      case 1: // Exterior
        return [
          _featureRow('Parking', '2 Cars'),
          _featureRow('Garden', 'Yes'),
          _featureRow('Swimming Pool', 'Yes'),
          _featureRow('Roof', 'Tiled'),
          _featureRow('Facing', 'North'),
        ];
      case 2: // Area & Lot
        return [
          _featureRow('Lot Size', '1,940 sqft'),
          _featureRow('Living Area', '1,215 sqft'),
          _featureRow('Land Type', 'Residential'),
          _featureRow('Floors', '2'),
          _featureRow('Zoning', 'R-1'),
        ];
      default: // Interior
        return [
          _featureRow('Status', 'For Sale'),
          _featureRow('Living Area', '1,215 sqft'),
          _featureRow('Type', 'Condo'),
          _featureRow('Year Built', '2000'),
          _featureRow('Lifestyle', 'Beach'),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.property;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  PropertyImage(
                    url: p.image,
                    height: 260,
                    width: double.infinity,
                    radius: BorderRadius.zero,
                  ),
                  Positioned(
                    top: 12,
                    left: 12,
                    child: _circleBtn(
                        Icons.arrow_back, () => Navigator.pop(context)),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Row(
                      children: [
                        _circleBtn(
                            _isFav ? Icons.favorite : Icons.favorite_border,
                            _favLoading ? () {} : _toggleFav,
                            iconColor: _isFav
                                ? AppColors.danger
                                : AppColors.textPrimary),
                        const SizedBox(width: 8),
                        _circleBtn(Icons.share_outlined, () {}),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p.type,
                        style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: Text(p.title,
                              style: const TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.w700)),
                        ),
                        const Icon(Icons.star, size: 16, color: AppColors.star),
                        const SizedBox(width: 3),
                        Text('${p.rating} (324 reviews)',
                            style: const TextStyle(
                                fontSize: 12, color: AppColors.textSecondary)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(children: [
                      const Icon(Icons.location_on,
                          size: 14, color: AppColors.textSecondary),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(p.location,
                            style: const TextStyle(
                                color: AppColors.textSecondary, fontSize: 12)),
                      ),
                    ]),
                    const SizedBox(height: 10),
                    Row(children: [
                      const Icon(Icons.bed,
                          size: 14, color: AppColors.textSecondary),
                      Text(' ${p.beds} Beds   ',
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.textSecondary)),
                      const Icon(Icons.bathtub_outlined,
                          size: 14, color: AppColors.textSecondary),
                      Text(' ${p.baths} Baths   ',
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.textSecondary)),
                      const Icon(Icons.square_foot,
                          size: 14, color: AppColors.textSecondary),
                      const Text(' 1,940 sqft',
                          style: TextStyle(
                              fontSize: 12, color: AppColors.textSecondary)),
                    ]),
                    const SizedBox(height: 20),
                    const Text('Listing Agent',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textSecondary)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 22,
                          backgroundImage: NetworkImage(_agentPhoto),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Zareen',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14)),
                              Text('Partner',
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: AppColors.textSecondary)),
                            ],
                          ),
                        ),
                        // 💬 Message → direct Chat
                        _circleBtn(Icons.chat_bubble_outline, _openChat,
                            bg: AppColors.primaryLight,
                            iconColor: AppColors.primary,
                            size: 40),
                        const SizedBox(width: 8),
                        // 📞 Call → direct Voice Call
                        _circleBtn(Icons.call_outlined, _openCall,
                            bg: AppColors.primaryLight,
                            iconColor: AppColors.primary,
                            size: 40),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text('Overview',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 8),
                    const Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                      style: TextStyle(
                          color: AppColors.textSecondary,
                          height: 1.6,
                          fontSize: 13),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Gallery',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w700)),
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      PropertyGalleryScreen(property: p))),
                          child: const Text('See All',
                              style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 72,
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: PropertyImage(
                                url: p.image, height: 72, width: 72),
                          ),
                          const SizedBox(width: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: PropertyImage(
                                url: p.image, height: 72, width: 72),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        PropertyGalleryScreen(property: p))),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: PropertyImage(
                                      url: p.image, height: 72, width: 72),
                                ),
                                Positioned.fill(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    alignment: Alignment.center,
                                    child: const Text('5+',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text('Location on Maps',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 10),
                    // ASLI interactive map (flutter_map + OpenStreetMap)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: SizedBox(
                        height: 160,
                        width: double.infinity,
                        child: Stack(
                          children: [
                            FlutterMap(
                              options: MapOptions(
                                initialCenter: LatLng(41.1579, -8.6291),
                                initialZoom: 13,
                              ),
                              children: [
                                TileLayer(
                                  urlTemplate:
                                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                  userAgentPackageName: 'com.luxeyline.app',
                                ),
                                MarkerLayer(
                                  markers: [
                                    Marker(
                                      point: LatLng(41.1579, -8.6291),
                                      width: 44,
                                      height: 44,
                                      child: const Icon(Icons.location_on,
                                          color: AppColors.danger, size: 44),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Positioned(
                              top: 10,
                              left: 10,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(p.type,
                                    style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text('Features & Amenities',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 12),
                    Row(
                      children: List.generate(3, (i) {
                        const labels = ['Interior', 'Exterior', 'Area & Lot'];
                        final sel = _featureTab == i;
                        return GestureDetector(
                          onTap: () => setState(() => _featureTab = i),
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color:
                                  sel ? AppColors.primary : AppColors.fieldFill,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(labels[i],
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: sel
                                        ? Colors.white
                                        : AppColors.textSecondary)),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 14),
                    // Content ab tab ke hisaab se badalta hai
                    ..._featureContent(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black12, blurRadius: 10, offset: Offset(0, -2))
          ],
        ),
        child: SafeArea(
          top: false,
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Price',
                      style: TextStyle(
                          fontSize: 11, color: AppColors.textSecondary)),
                  Text(p.price,
                      style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: AppColors.price)),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => PaymentMethodScreen(property: p)),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Buy Now',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _circleBtn(IconData icon, VoidCallback onTap,
      {Color bg = Colors.white,
      Color iconColor = AppColors.textPrimary,
      double size = 40}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
        child: Icon(icon, color: iconColor, size: 20),
      ),
    );
  }

  Widget _featureRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 13, color: AppColors.textSecondary)),
          Text(value,
              style:
                  const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
