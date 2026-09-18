import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/models/property.dart';

class PropertyImage extends StatelessWidget {
  final String url;
  final double height;
  final double? width;
  final BorderRadius radius;
  const PropertyImage({
    super.key,
    required this.url,
    required this.height,
    this.width,
    this.radius = const BorderRadius.all(Radius.circular(14)),
  });

  // Jab backend se image na aaye to ye demo photo dikhao (grey box ki jagah)
  static const String _fallback =
      'https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&w=800';

  @override
  Widget build(BuildContext context) {
    final safeUrl = url.trim().isEmpty ? _fallback : url;
    return ClipRRect(
      borderRadius: radius,
      child: Image.network(
        safeUrl,
        height: height,
        width: width,
        fit: BoxFit.cover,
        loadingBuilder: (c, w, prog) => prog == null
            ? w
            : Container(
                height: height,
                width: width,
                color: AppColors.grey,
                child: const Center(
                    child: CircularProgressIndicator(
                        color: AppColors.primary, strokeWidth: 2)),
              ),
        // Agar URL toota hua ho to bhi fallback demo image try karo
        errorBuilder: (c, e, s) => Image.network(
          _fallback,
          height: height,
          width: width,
          fit: BoxFit.cover,
          errorBuilder: (c, e, s) => Container(
            height: height,
            width: width,
            color: AppColors.grey,
            child: const Icon(Icons.home_outlined,
                color: AppColors.textSecondary, size: 40),
          ),
        ),
      ),
    );
  }
}

class FeaturedPropertyCard extends StatelessWidget {
  final Property property;
  final VoidCallback? onTap;
  const FeaturedPropertyCard({super.key, required this.property, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 230,
        margin: const EdgeInsets.only(right: 16, top: 4, bottom: 8),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          boxShadow: AppColors.softShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                PropertyImage(
                  url: property.image,
                  height: 140,
                  width: 230,
                  radius: const BorderRadius.vertical(top: Radius.circular(18)),
                ),
                // Rating pill (top-left)
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, size: 13, color: AppColors.star),
                        const SizedBox(width: 3),
                        Text('${property.rating}',
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ),
                // Favourite (top-right)
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: AppColors.subtleShadow,
                    ),
                    child: const Icon(Icons.favorite_border,
                        size: 17, color: AppColors.textPrimary),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(property.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.2,
                          color: AppColors.textPrimary)),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          size: 14, color: AppColors.textSecondary),
                      const SizedBox(width: 2),
                      Expanded(
                        child: Text(property.location,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 12, color: AppColors.textSecondary)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _iconText(Icons.bed, '${property.beds}'),
                      const SizedBox(width: 14),
                      _iconText(Icons.bathtub_outlined, '${property.baths}'),
                      const SizedBox(width: 8),
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerRight,
                          child: Text(property.price,
                              maxLines: 1,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.price)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconText(IconData icon, String text) {
    return Row(children: [
      Icon(icon, size: 15, color: AppColors.textSecondary),
      const SizedBox(width: 4),
      Text(text,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary)),
    ]);
  }
}

class ListPropertyCard extends StatelessWidget {
  final Property property;
  final VoidCallback? onTap;
  const ListPropertyCard({super.key, required this.property, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: AppColors.subtleShadow,
        ),
        child: Row(
          children: [
            PropertyImage(url: property.image, height: 82, width: 96),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(property.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.2,
                                color: AppColors.textPrimary)),
                      ),
                      const Icon(Icons.star, size: 14, color: AppColors.star),
                      const SizedBox(width: 2),
                      Text('${property.rating}',
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(children: [
                    const Icon(Icons.location_on,
                        size: 13, color: AppColors.textSecondary),
                    const SizedBox(width: 2),
                    Expanded(
                      child: Text(property.location,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.textSecondary)),
                    ),
                  ]),
                  const SizedBox(height: 8),
                  Row(children: [
                    _miniIcon(Icons.bed, '${property.beds}'),
                    const SizedBox(width: 12),
                    _miniIcon(Icons.bathtub_outlined, '${property.baths}'),
                    const SizedBox(width: 8),
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerRight,
                        child: Text(property.price,
                            maxLines: 1,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: AppColors.price)),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _miniIcon(IconData icon, String text) {
    return Row(children: [
      Icon(icon, size: 14, color: AppColors.textSecondary),
      const SizedBox(width: 3),
      Text(text,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary)),
    ]);
  }
}
