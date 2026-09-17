import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class _Listing {
  final String title;
  final String location;
  final String price;
  final String image;
  final double rating;
  const _Listing(
      this.title, this.location, this.price, this.image, this.rating);
}

class AgentProfileScreen extends StatefulWidget {
  final String name;
  final String avatar;
  const AgentProfileScreen(
      {super.key, required this.name, required this.avatar});

  @override
  State<AgentProfileScreen> createState() => _AgentProfileScreenState();
}

class _AgentProfileScreenState extends State<AgentProfileScreen> {
  int _tab = 0; // 0 = Listing, 1 = Sold

  final _listing = const [
    _Listing(
        'Skyline Tower',
        'New York City, USA',
        '\$4,500,000',
        'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=300&q=80',
        4.5),
    _Listing(
        'Riviera Villa',
        'Nice, France',
        '€3,200,000',
        'https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=300&q=80',
        4.0),
    _Listing(
        'Pacific Retreat',
        'Auckland, New Zealand',
        '\$2,800,000',
        'https://images.unsplash.com/photo-1502005229762-cf1b2da7c5d6?w=300&q=80',
        3.7),
  ];

  final _sold = const [
    _Listing(
        'Coastal Villa',
        'Malibu, USA',
        '\$8,900,000',
        'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=300&q=80',
        4.8),
    _Listing(
        'Downtown Loft',
        'Chicago, USA',
        '\$1,750,000',
        'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=300&q=80',
        4.2),
  ];

  @override
  Widget build(BuildContext context) {
    final items = _tab == 0 ? _listing : _sold;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: const BoxDecoration(
                  color: AppColors.fieldFill, shape: BoxShape.circle),
              child: const Icon(Icons.arrow_back,
                  color: AppColors.textPrimary, size: 20),
            ),
          ),
        ),
        title: const Text('Profile',
            style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 17,
                fontWeight: FontWeight.w700)),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.more_vert, color: AppColors.textPrimary),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          CircleAvatar(
              radius: 44, backgroundImage: NetworkImage(widget.avatar)),
          const SizedBox(height: 12),
          Text(widget.name,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          const Text('Nice, France',
              style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
          const SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: _actionButton(Icons.chat_bubble_outline, 'Message',
                      () => Navigator.pop(context)),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: _actionButton(Icons.people_outline, 'Contacts', () {}),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: AppColors.fieldFill,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  _tabButton('Listing', 0),
                  _tabButton('Sold', 1),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
              itemCount: items.length,
              separatorBuilder: (_, __) =>
                  const Divider(height: 20, color: AppColors.border),
              itemBuilder: (_, i) => _listingCard(items[i]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(IconData icon, String label, VoidCallback onTap) {
    return SizedBox(
      height: 48,
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 18, color: AppColors.textPrimary),
        label: Text(label,
            style: const TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 14)),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.border),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget _tabButton(String label, int i) {
    final sel = _tab == i;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _tab = i),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: sel ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(9),
          ),
          child: Text(label,
              style: TextStyle(
                  color: sel ? Colors.white : AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14)),
        ),
      ),
    );
  }

  Widget _listingCard(_Listing l) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(l.image,
              height: 62,
              width: 78,
              fit: BoxFit.cover,
              errorBuilder: (c, e, s) => Container(
                    height: 62,
                    width: 78,
                    color: AppColors.grey,
                    child: const Icon(Icons.home_outlined,
                        color: AppColors.textSecondary),
                  )),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l.title,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Row(children: [
                const Icon(Icons.location_on,
                    size: 13, color: AppColors.textSecondary),
                const SizedBox(width: 2),
                Text(l.location,
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textSecondary)),
              ]),
              const SizedBox(height: 6),
              Row(children: [
                Text(l.price,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.price)),
                const Text(' /month',
                    style: TextStyle(
                        fontSize: 11, color: AppColors.textSecondary)),
              ]),
            ],
          ),
        ),
        Row(children: [
          const Icon(Icons.star, size: 15, color: AppColors.star),
          const SizedBox(width: 3),
          Text('${l.rating}',
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        ]),
      ],
    );
  }
}
