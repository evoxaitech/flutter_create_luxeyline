import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import 'search_result_list_screen.dart';

class SearchAutotypeScreen extends StatefulWidget {
  const SearchAutotypeScreen({super.key});

  @override
  State<SearchAutotypeScreen> createState() => _SearchAutotypeScreenState();
}

class _SearchAutotypeScreenState extends State<SearchAutotypeScreen> {
  final _controller = TextEditingController(text: 'Solo');
  List<String> _suggestions = [
    'Solo House',
    'Blue Apartment Solo',
    'Grandis Barn Solo'
  ];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _removeSuggestion(String term) {
    setState(() => _suggestions.remove(term));
  }

  void _goToResults(String query) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => SearchResultListScreen(query: query)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  border: Border.all(color: AppColors.primary, width: 1.4),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search,
                        color: AppColors.primary, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        autofocus: true,
                        onSubmitted: _goToResults,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search apart, hotel, etc',
                          hintStyle: TextStyle(
                              color: AppColors.textSecondary, fontSize: 14),
                          contentPadding: EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                    if (_controller.text.isNotEmpty)
                      GestureDetector(
                        onTap: () => _controller.clear(),
                        child: const Icon(Icons.close,
                            color: AppColors.textSecondary, size: 18),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text('Suggestions',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textSecondary)),
              const SizedBox(height: 10),
              ..._suggestions.map((s) => GestureDetector(
                    onTap: () => _goToResults(s),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(s,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500)),
                          ),
                          GestureDetector(
                            onTap: () => _removeSuggestion(s),
                            child: const Icon(Icons.close,
                                size: 16, color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
