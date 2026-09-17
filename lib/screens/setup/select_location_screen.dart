import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../core/app_colors.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/setup_progress_bar.dart';
import 'add_profile_photo_screen.dart';

class SelectLocationScreen extends StatefulWidget {
  const SelectLocationScreen({super.key});

  @override
  State<SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  final _search = TextEditingController();

  // Default map center — Islamabad, Pakistan
  LatLng _picked = const LatLng(33.6844, 73.0479);

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  void _goNext() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddProfilePhotoScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SetupProgressBar(step: 2),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                      color: AppColors.fieldFill, shape: BoxShape.circle),
                  child: const Icon(Icons.arrow_back,
                      size: 18, color: AppColors.textPrimary),
                ),
              ),
              const SizedBox(height: 24),
              const Text('Choose Location',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              const Text(
                'Search for a place or tap on the map to drop a pin at your preferred location.',
                style: TextStyle(
                    color: AppColors.textSecondary, height: 1.5, fontSize: 13),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: AppColors.fieldFill,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search,
                        size: 20, color: AppColors.textSecondary),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _search,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Find location...',
                          hintStyle: TextStyle(
                              color: AppColors.textSecondary, fontSize: 14),
                          contentPadding: EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text('Current Location',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    children: [
                      FlutterMap(
                        options: MapOptions(
                          initialCenter: _picked,
                          initialZoom: 13,
                          onTap: (tapPosition, point) {
                            setState(() => _picked = point);
                          },
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
                                point: _picked,
                                width: 60,
                                height: 60,
                                alignment: Alignment.topCenter,
                                child: const Icon(Icons.location_on,
                                    color: AppColors.primary, size: 44),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // small "House" label card near top
                      Positioned(
                        top: 12,
                        left: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.12),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2)),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.home,
                                  size: 16, color: AppColors.primary),
                              SizedBox(width: 6),
                              Text('Selected Location',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              PrimaryButton(label: 'Continue', onPressed: _goNext),
              const SizedBox(height: 10),
              Center(
                child: GestureDetector(
                  onTap: _goNext,
                  child: const Text('Skip',
                      style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 13)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
