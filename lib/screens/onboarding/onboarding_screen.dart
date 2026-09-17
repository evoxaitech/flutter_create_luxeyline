import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../widgets/primary_button.dart';
import '../auth/get_started_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _Slide {
  final String image;
  final String title;
  final String desc;
  const _Slide(this.image, this.title, this.desc);
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _index = 0;

  final _pages = const [
    _Slide(
      'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=900&q=80',
      'Find your perfect rental on Luxeyline',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    ),
    _Slide(
      'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=900&q=80',
      'Sell for top dollar and save thousands on fees',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    ),
    _Slide(
      'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=900&q=80',
      'Local expertise for luxury homes',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    ),
  ];

  void _next() {
    if (_index < _pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _goToStart();
    }
  }

  void _goToStart() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const GetStartedScreen()),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLast = _index == _pages.length - 1;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (i) => setState(() => _index = i),
                itemBuilder: (_, i) {
                  final p = _pages[i];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                    child: Column(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(24),
                                  child: Image.network(
                                    p.image,
                                    fit: BoxFit.cover,
                                    loadingBuilder: (c, w, prog) => prog == null
                                        ? w
                                        : Container(
                                            color: AppColors.grey,
                                            child: const Center(
                                              child: CircularProgressIndicator(
                                                  color: AppColors.primary),
                                            ),
                                          ),
                                    errorBuilder: (c, e, s) => Container(
                                      color: AppColors.grey,
                                      child: const Icon(Icons.home_outlined,
                                          size: 60,
                                          color: AppColors.textSecondary),
                                    ),
                                  ),
                                ),
                              ),
                              if (_index != 0)
                                Positioned(
                                  top: 12,
                                  right: 12,
                                  child: GestureDetector(
                                    onTap: _goToStart,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.35),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Text('Skip',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                  ),
                                ),
                              if (i == 1)
                                Positioned(
                                  top: 12,
                                  right: _index != 0 ? 70 : 12,
                                  child: const CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Colors.white,
                                    backgroundImage: NetworkImage(
                                        'https://images.unsplash.com/photo-1633332755192-727a05c4013d?w=200&q=80'),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          p.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              height: 1.3),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          p.desc,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            height: 1.5,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_pages.length, (i) {
                final active = i == _index;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 6,
                  width: active ? 18 : 6,
                  decoration: BoxDecoration(
                    color: active ? AppColors.primary : AppColors.border,
                    borderRadius: BorderRadius.circular(6),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: PrimaryButton(
                label: isLast ? 'Get Started' : 'Continue',
                onPressed: _next,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
