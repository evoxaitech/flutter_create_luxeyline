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
    this.radius = const BorderRadius.all(Radius.circular(12)),
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
        margin: const EdgeInsets.only(right: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                PropertyImage(url: property.image, height: 150, width: 230),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: const Icon(Icons.favorite_border,
                        size: 18, color: AppColors.textPrimary),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(property.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
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
                const SizedBox(width: 6),
                Text(property.price,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.price)),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                _iconText(Icons.bed, '${property.beds} Beds'),
                const SizedBox(width: 16),
                _iconText(Icons.bathtub_outlined, '${property.baths} Baths'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconText(IconData icon, String text) {
    return Row(children: [
      Icon(icon, size: 14, color: AppColors.textSecondary),
      const SizedBox(width: 4),
      Text(text,
          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            PropertyImage(url: property.image, height: 74, width: 90),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(property.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Row(children: [
                    const Icon(Icons.location_on,
                        size: 13, color: AppColors.textSecondary),
                    Expanded(
                      child: Text(property.location,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.textSecondary)),
                    ),
                  ]),
                  const SizedBox(height: 6),
                  Row(children: [
                    Expanded(
                      child: Text(property.price,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.price)),
                    ),
                    const SizedBox(width: 6),
                    const Icon(Icons.star, size: 14, color: AppColors.star),
                    const SizedBox(width: 2),
                    Text('${property.rating}',
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600)),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
