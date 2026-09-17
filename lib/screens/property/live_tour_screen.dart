import 'package:flutter/material.dart';
import '../../core/models/property.dart';

class LiveTourScreen extends StatefulWidget {
  final Property property;
  const LiveTourScreen({super.key, required this.property});

  @override
  State<LiveTourScreen> createState() => _LiveTourScreenState();
}

class _LiveTourScreenState extends State<LiveTourScreen> {
  int _roomIndex = 0;

  final _rooms = const [
    {
      'name': 'Kitchen',
      'image':
          'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=900&q=80'
    },
    {
      'name': 'Living Room',
      'image':
          'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=900&q=80'
    },
    {
      'name': 'Bedroom',
      'image':
          'https://images.unsplash.com/photo-1560185127-6ed189bf02f4?w=900&q=80'
    },
    {
      'name': 'Bathroom',
      'image':
          'https://images.unsplash.com/photo-1556911220-e15b29be8c8f?w=900&q=80'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final room = _rooms[_roomIndex];
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            room['name'] == null ? '' : room['image']!,
            fit: BoxFit.cover,
            loadingBuilder: (c, w, prog) => prog == null
                ? w
                : Container(
                    color: Colors.grey.shade900,
                    child: const Center(
                        child: CircularProgressIndicator(color: Colors.white)),
                  ),
            errorBuilder: (c, e, s) => Container(
              color: Colors.grey.shade900,
              child: const Icon(Icons.home, color: Colors.white54, size: 60),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black45,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text('Live Tour',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: Colors.black45, shape: BoxShape.circle),
                  child: const Icon(Icons.videocam_outlined,
                      color: Colors.white, size: 20),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.location_on,
                            color: Colors.white, size: 14),
                        const SizedBox(width: 4),
                        Text("You're in the current time",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 11)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () => setState(
                      () => _roomIndex = (_roomIndex + 1) % _rooms.length),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: const Icon(Icons.arrow_forward,
                        color: Colors.black, size: 20),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 4,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(room['name']!,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
