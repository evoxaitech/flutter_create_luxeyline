import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import 'chat_screen.dart';

class _Conversation {
  final String name;
  final String lastMessage;
  final String time;
  final int unread;
  final String avatar;
  final bool archived;
  const _Conversation(
    this.name,
    this.lastMessage,
    this.time,
    this.unread,
    this.avatar, {
    this.archived = false,
  });
}

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  int _tab = 0;
  final _tabs = const ['All Messages', 'Read', 'Unread', 'Archived'];

  final _conversations = const [
    _Conversation('Zareen', "Hi! I'm interested in the 2-bedroom...", '9:00', 2,
        'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=200&q=80'),
    _Conversation(
        'James Michael',
        "That works for me. I'll send you the...",
        '9:12',
        2,
        'https://images.unsplash.com/photo-1633332755192-727a05c4013d?w=200&q=80'),
    _Conversation(
        'John David',
        'Yes, the apartment comes with one parki...',
        '9:20',
        0,
        'https://images.unsplash.com/photo-1560185127-6ed189bf02f4?w=200&q=80'),
    _Conversation(
        'Sophia Rose',
        'Sure, just let me know if you have any ot...',
        '9:30',
        0,
        'https://images.unsplash.com/photo-1556911220-e15b29be8c8f?w=200&q=80'),
    _Conversation('David Wilson', 'Thanks for the tour yesterday!', '8:05', 0,
        'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=200&q=80',
        archived: true),
  ];

  // Selected tab ke hisaab se list filter
  List<_Conversation> get _filtered {
    switch (_tab) {
      case 1: // Read  → unread == 0 aur archived nahi
        return _conversations
            .where((c) => c.unread == 0 && !c.archived)
            .toList();
      case 2: // Unread → unread > 0 aur archived nahi
        return _conversations
            .where((c) => c.unread > 0 && !c.archived)
            .toList();
      case 3: // Archived
        return _conversations.where((c) => c.archived).toList();
      default: // All → archived ke ilawa sab
        return _conversations.where((c) => !c.archived).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final list = _filtered;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Messages',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                    color: AppColors.fieldFill,
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: const [
                    Icon(Icons.search,
                        size: 20, color: AppColors.textSecondary),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search message or name',
                          hintStyle: TextStyle(
                              color: AppColors.textSecondary, fontSize: 13),
                          contentPadding: EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                height: 34,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children:
                      List.generate(_tabs.length, (i) => _tabChip(_tabs[i], i)),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: list.isEmpty
                    ? Center(
                        child: Text('No ${_tabs[_tab].toLowerCase()} found',
                            style: const TextStyle(
                                color: AppColors.textSecondary, fontSize: 13)),
                      )
                    : ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (_, i) {
                          final c = list[i];
                          return GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ChatScreen(
                                        agentName: c.name,
                                        agentImage: c.avatar))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                      radius: 24,
                                      backgroundImage: NetworkImage(c.avatar)),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(c.name,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14)),
                                        const SizedBox(height: 3),
                                        Text(c.lastMessage,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color:
                                                    AppColors.textSecondary)),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(c.time,
                                          style: const TextStyle(
                                              fontSize: 11,
                                              color: AppColors.textSecondary)),
                                      const SizedBox(height: 6),
                                      if (c.unread > 0)
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: const BoxDecoration(
                                              color: AppColors.primary,
                                              shape: BoxShape.circle),
                                          child: Text('${c.unread}',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w700)),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tabChip(String label, int i) {
    final sel = _tab == i;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () => setState(() => _tab = i),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: sel ? AppColors.primaryLight : AppColors.fieldFill,
            border:
                Border.all(color: sel ? AppColors.primary : Colors.transparent),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(label,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: sel ? AppColors.primary : AppColors.textSecondary)),
        ),
      ),
    );
  }
}
