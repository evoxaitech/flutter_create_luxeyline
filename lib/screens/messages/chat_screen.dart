// screens/messages/chat_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'video_call_screen.dart';
import 'voice_call_screen.dart';

class ChatMessage {
  final String text;
  final bool isMe;
  final String time;
  final bool isImage;
  final String? imagePath; // gallery se pick ki hui asli photo ka path
  const ChatMessage({
    required this.text,
    required this.isMe,
    required this.time,
    this.isImage = false,
    this.imagePath,
  });
}

class ChatScreen extends StatefulWidget {
  final String agentName;
  final String agentImage;

  const ChatScreen({
    super.key,
    this.agentName = 'Ali Hassan',
    this.agentImage = '',
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  static const Color green = Color(0xFF12B76A);
  static const Color bg = Color(0xFFF4F7F5);

  final TextEditingController _controller = TextEditingController();
  final ScrollController _scroll = ScrollController();
  final ImagePicker _picker = ImagePicker();

  late final List<ChatMessage> _messages;

  @override
  void initState() {
    super.initState();
    // Greeting mein agent ka asli naam (Zareen / Tehrim / Zainab...) aata hai
    _messages = [
      ChatMessage(
          text: 'Assalam o Alaikum! Luxeyline se ${widget.agentName}.',
          isMe: false,
          time: '10:30'),
      const ChatMessage(
          text: 'Main is 3-bed apartment ke baare mein poochna chahti thi.',
          isMe: true,
          time: '10:31'),
      const ChatMessage(
          text: 'Bilkul! Ye rahi property ki tasveer 👇',
          isMe: false,
          time: '10:32'),
      const ChatMessage(text: '', isMe: false, time: '10:32', isImage: true),
      const ChatMessage(
          text: 'Bohot khoobsurat hai! Visit kab kar sakti hoon?',
          isMe: true,
          time: '10:33'),
    ];
  }

  @override
  void dispose() {
    _controller.dispose();
    _scroll.dispose();
    super.dispose();
  }

  TextStyle _t(double size, FontWeight w, Color c) =>
      GoogleFonts.plusJakartaSans(fontSize: size, fontWeight: w, color: c);

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(ChatMessage(text: text, isMe: true, time: _now()));
      _controller.clear();
    });
    _scrollToBottom();
  }

  // Gallery kholo → asli photo pick karo → bhejo
  Future<void> _sendPhoto() async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (picked == null) return; // user ne cancel kar diya
      setState(() {
        _messages.add(ChatMessage(
          text: '',
          isMe: true,
          time: _now(),
          isImage: true,
          imagePath: picked.path,
        ));
      });
      _scrollToBottom();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gallery nahi khul saki')),
      );
    }
  }

  String _now() {
    final t = TimeOfDay.now();
    final h = t.hour.toString().padLeft(2, '0');
    final m = t.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(
          _scroll.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _openVideoCall() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VideoCallScreen(
            agentName: widget.agentName,
            agentImage: widget.agentImage,
          ),
        ));
  }

  void _openVoiceCall() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VoiceCallScreen(
            agentName: widget.agentName,
            agentImage: widget.agentImage,
          ),
        ));
  }

  void _openAgentProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Agent profile — un-comment to enable')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: _appBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scroll,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              itemCount: _messages.length,
              itemBuilder: (context, i) => _bubble(_messages[i]),
            ),
          ),
          _inputBar(),
        ],
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF1A1A1A), size: 20),
        onPressed: () => Navigator.pop(context),
      ),
      titleSpacing: 0,
      title: InkWell(
        onTap: _openAgentProfile,
        child: Row(
          children: [
            _avatar(20),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.agentName,
                    style: _t(16, FontWeight.w700, const Color(0xFF1A1A1A))),
                Row(
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                          color: green, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 5),
                    Text('Online', style: _t(12, FontWeight.w500, green)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.call_rounded, color: green),
          onPressed: _openVoiceCall,
        ),
        IconButton(
          icon: const Icon(Icons.videocam_rounded, color: green),
          onPressed: _openVideoCall,
        ),
        const SizedBox(width: 4),
      ],
    );
  }

  Widget _avatar(double radius) {
    if (widget.agentImage.isNotEmpty) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: NetworkImage(widget.agentImage),
        backgroundColor: const Color(0xFFDDE7E1),
      );
    }
    return CircleAvatar(
      radius: radius,
      backgroundColor: const Color(0xFFDDE7E1),
      child: Icon(Icons.person, color: green, size: radius),
    );
  }

  Widget _bubble(ChatMessage m) {
    final align = m.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final rowAlign = m.isMe ? MainAxisAlignment.end : MainAxisAlignment.start;

    Widget content;
    if (m.isImage) {
      if (m.imagePath != null) {
        // Gallery se pick ki hui asli photo
        content = ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.file(
            File(m.imagePath!),
            width: 200,
            height: 150,
            fit: BoxFit.cover,
          ),
        );
      } else {
        // Demo property photo (agent ki taraf se)
        content = Container(
          width: 180,
          height: 130,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF9AD8B8), Color(0xFF12B76A)],
            ),
          ),
          child: const Center(
            child: Icon(Icons.home_rounded, color: Colors.white, size: 46),
          ),
        );
      }
    } else {
      content = Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.72),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: m.isMe ? green : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(m.isMe ? 16 : 4),
            bottomRight: Radius.circular(m.isMe ? 4 : 16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          m.text,
          style: _t(14, FontWeight.w500,
              m.isMe ? Colors.white : const Color(0xFF1A1A1A)),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: rowAlign,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!m.isMe) ...[
            _avatar(14),
            const SizedBox(width: 8),
          ],
          Column(
            crossAxisAlignment: align,
            children: [
              content,
              const SizedBox(height: 4),
              Text(m.time, style: _t(11, FontWeight.w400, Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _inputBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // Photo button — ab ASLI gallery kholta hai
            IconButton(
              onPressed: _sendPhoto,
              icon: const Icon(Icons.add_photo_alternate_rounded,
                  color: green, size: 26),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  controller: _controller,
                  minLines: 1,
                  maxLines: 4,
                  style: _t(14, FontWeight.w500, const Color(0xFF1A1A1A)),
                  decoration: InputDecoration(
                    hintText: 'Message…',
                    hintStyle: _t(14, FontWeight.w400, Colors.grey),
                    border: InputBorder.none,
                  ),
                  onSubmitted: (_) => _send(),
                ),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: _send,
              child: Container(
                width: 46,
                height: 46,
                decoration: const BoxDecoration(
                  color: green,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.send_rounded,
                    color: Colors.white, size: 22),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
