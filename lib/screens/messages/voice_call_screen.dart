// screens/messages/voice_call_screen.dart
//
// Luxeyline — Agent Voice Call screen (screen 59)
// File yahan rakho: lib/screens/messages/voice_call_screen.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class VoiceCallScreen extends StatefulWidget {
  final String agentName;
  final String agentImage;

  const VoiceCallScreen({
    super.key,
    this.agentName = 'Ali Hassan',
    this.agentImage = '',
  });

  @override
  State<VoiceCallScreen> createState() => _VoiceCallScreenState();
}

class _VoiceCallScreenState extends State<VoiceCallScreen> {
  static const Color green = Color(0xFF12B76A);
  static const Color darkBg = Color(0xFF0B1512);

  Timer? _timer;
  int _seconds = 0;
  bool _micOn = true;
  bool _speakerOn = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => _seconds++);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _duration {
    final m = (_seconds ~/ 60).toString().padLeft(2, '0');
    final s = (_seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  TextStyle _t(double size, FontWeight w, Color c) =>
      GoogleFonts.plusJakartaSans(fontSize: size, fontWeight: w, color: c);

  void _endCall() => Navigator.of(context).maybePop();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: darkBg,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF12362A), darkBg],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 50),
                // Agent avatar
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: green.withOpacity(0.6), width: 2),
                  ),
                  child: CircleAvatar(
                    radius: 62,
                    backgroundColor: Colors.white.withOpacity(0.1),
                    backgroundImage: widget.agentImage.isNotEmpty
                        ? NetworkImage(widget.agentImage)
                        : null,
                    child: widget.agentImage.isEmpty
                        ? const Icon(Icons.person,
                            size: 64, color: Colors.white70)
                        : null,
                  ),
                ),
                const SizedBox(height: 22),
                Text(widget.agentName,
                    style: _t(24, FontWeight.w700, Colors.white)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration:
                          const BoxDecoration(color: green, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 6),
                    Text('Luxeyline Agent • $_duration',
                        style: _t(14, FontWeight.w500, Colors.white70)),
                  ],
                ),
                const Spacer(),
                // Controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _toggle(
                      on: _speakerOn,
                      onIcon: Icons.volume_up_rounded,
                      offIcon: Icons.volume_off_rounded,
                      label: 'Speaker',
                      onTap: () => setState(() => _speakerOn = !_speakerOn),
                    ),
                    _toggle(
                      on: _micOn,
                      onIcon: Icons.mic_rounded,
                      offIcon: Icons.mic_off_rounded,
                      label: 'Mute',
                      onTap: () => setState(() => _micOn = !_micOn),
                    ),
                    _toggle(
                      on: true,
                      onIcon: Icons.dialpad_rounded,
                      offIcon: Icons.dialpad_rounded,
                      label: 'Keypad',
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 36),
                // End call
                GestureDetector(
                  onTap: _endCall,
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5484D),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFE5484D).withOpacity(0.45),
                          blurRadius: 18,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.call_end_rounded,
                        color: Colors.white, size: 34),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _toggle({
    required bool on,
    required IconData onIcon,
    required IconData offIcon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: on ? Colors.white.withOpacity(0.16) : Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              on ? onIcon : offIcon,
              color: on ? Colors.white : const Color(0xFFE5484D),
              size: 26,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: _t(12, FontWeight.w500, Colors.white70)),
      ],
    );
  }
}