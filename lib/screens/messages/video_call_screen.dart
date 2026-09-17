// screens/messages/video_call_screen.dart
//
// Luxeyline — Agent Video Call screen (screen 60)  [REAL CAMERA VERSION]
// -----------------------------------------------------------------------------
// PEHLE 2 SETUP STEPS KARO (warna camera nahi chalega):
//
// 1) pubspec.yaml mein dependencies ke andar add karo:
//        camera: ^0.11.0
//    phir terminal mein:  flutter pub get
//
// 2) android/app/src/main/AndroidManifest.xml mein <application> tag se
//    UPAR ye line add karo:
//        <uses-permission android:name="android.permission.CAMERA"/>
//
// File yahan rakho: lib/screens/messages/video_call_screen.dart
// Pehli baar chalane pe device permission popup aayega — "Allow" dabana.
// -----------------------------------------------------------------------------

import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class VideoCallScreen extends StatefulWidget {
  final String agentName;
  final String agentImage;

  const VideoCallScreen({
    super.key,
    this.agentName = 'Ali Hassan',
    this.agentImage = '',
  });

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  static const Color green = Color(0xFF12B76A);
  static const Color darkBg = Color(0xFF0B1512);

  Timer? _timer;
  int _seconds = 0;

  bool _micOn = true;
  bool _cameraOn = true;
  bool _speakerOn = true;

  // ---- Camera state ----
  List<CameraDescription> _cameras = [];
  CameraController? _cam;
  bool _camReady = false;
  CameraLensDirection _lens = CameraLensDirection.front;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => _seconds++);
    });
    _initCamera();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _cam?.dispose();
    super.dispose();
  }

  Future<void> _initCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras.isEmpty) return;
      await _startCamera(_lens);
    } catch (_) {
      // Permission na mile ya camera na ho to placeholder rahega
      if (mounted) setState(() => _camReady = false);
    }
  }

  Future<void> _startCamera(CameraLensDirection dir) async {
    final desc = _cameras.firstWhere(
      (c) => c.lensDirection == dir,
      orElse: () => _cameras.first,
    );
    final controller = CameraController(
      desc,
      ResolutionPreset.medium,
      enableAudio: false,
    );
    try {
      await controller.initialize();
    } catch (_) {
      return;
    }
    if (!mounted) {
      await controller.dispose();
      return;
    }
    setState(() {
      _cam = controller;
      _lens = desc.lensDirection;
      _camReady = true;
    });
  }

  Future<void> _flipCamera() async {
    if (_cameras.length < 2) return;
    setState(() => _camReady = false);
    await _cam?.dispose();
    final next = _lens == CameraLensDirection.front
        ? CameraLensDirection.back
        : CameraLensDirection.front;
    await _startCamera(next);
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
        body: Stack(
          fit: StackFit.expand,
          children: [
            _agentFeed(),
            _scrim(),
            SafeArea(
              child: Column(
                children: [
                  _header(),
                  const Spacer(),
                  _controls(),
                ],
              ),
            ),
            _selfView(),
          ],
        ),
      ),
    );
  }

  Widget _agentFeed() {
    if (widget.agentImage.isNotEmpty) {
      return Image.network(
        widget.agentImage,
        fit: BoxFit.cover,
        loadingBuilder: (c, child, p) =>
            p == null ? child : _placeholderFeed(loading: true),
        errorBuilder: (c, e, s) => _placeholderFeed(),
      );
    }
    return _placeholderFeed();
  }

  Widget _placeholderFeed({bool loading = false}) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF12362A), darkBg],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 116,
              height: 116,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.08),
                border: Border.all(color: green.withOpacity(0.5), width: 2),
              ),
              child: const Icon(Icons.person, size: 60, color: Colors.white70),
            ),
            const SizedBox(height: 16),
            Text(loading ? 'Connecting…' : widget.agentName,
                style: _t(18, FontWeight.w600, Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _scrim() {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.55),
            Colors.transparent,
            Colors.transparent,
            Colors.black.withOpacity(0.65),
          ],
          stops: const [0.0, 0.25, 0.6, 1.0],
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Row(
        children: [
          _iconBtn(Icons.keyboard_arrow_down_rounded, _endCall),
          Expanded(
            child: Column(
              children: [
                Text(widget.agentName,
                    style: _t(18, FontWeight.w700, Colors.white)),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                          color: green, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 6),
                    Text('Luxeyline Agent • $_duration',
                        style: _t(13, FontWeight.w500, Colors.white70)),
                  ],
                ),
              ],
            ),
          ),
          _iconBtn(Icons.info_outline_rounded, () {}),
        ],
      ),
    );
  }

  Widget _iconBtn(IconData icon, VoidCallback onTap) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.14),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 24),
      ),
    );
  }

  // Picture-in-picture: ASLI front camera
  Widget _selfView() {
    Widget inner;

    if (_cameraOn && _camReady && _cam != null) {
      final size = _cam!.value.previewSize;
      inner = ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Transform(
          alignment: Alignment.center,
          // Front camera ko selfie ki tarah mirror karo
          transform: _lens == CameraLensDirection.front
              ? (Matrix4.identity()..scale(-1.0, 1.0, 1.0))
              : Matrix4.identity(),
          child: SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: size?.height ?? 108,
                height: size?.width ?? 150,
                child: CameraPreview(_cam!),
              ),
            ),
          ),
        ),
      );
    } else {
      inner = Stack(
        children: [
          Center(
            child: Icon(
              _cameraOn ? Icons.person : Icons.videocam_off_rounded,
              color: Colors.white54,
              size: 40,
            ),
          ),
          Positioned(
            bottom: 6,
            left: 8,
            child: Text(_cameraOn ? 'You' : 'Camera off',
                style: _t(11, FontWeight.w600, Colors.white)),
          ),
        ],
      );
    }

    return Positioned(
      top: MediaQuery.of(context).padding.top + 70,
      right: 16,
      child: Container(
        width: 108,
        height: 150,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white24, width: 1.5),
          gradient: (_cameraOn && _camReady)
              ? null
              : const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1E5C46), Color(0xFF0F2A20)],
                ),
          color: (!_cameraOn) ? Colors.black87 : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.35),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: inner,
      ),
    );
  }

  Widget _controls() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.35),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Column(
        children: [
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
                on: _cameraOn,
                onIcon: Icons.videocam_rounded,
                offIcon: Icons.videocam_off_rounded,
                label: 'Video',
                onTap: () => setState(() => _cameraOn = !_cameraOn),
              ),
              _toggle(
                on: _micOn,
                onIcon: Icons.mic_rounded,
                offIcon: Icons.mic_off_rounded,
                label: 'Mic',
                onTap: () => setState(() => _micOn = !_micOn),
              ),
              _toggle(
                on: true,
                onIcon: Icons.cameraswitch_rounded,
                offIcon: Icons.cameraswitch_rounded,
                label: 'Flip',
                onTap: _flipCamera,
              ),
            ],
          ),
          const SizedBox(height: 22),
          GestureDetector(
            onTap: _endCall,
            child: Container(
              width: 68,
              height: 68,
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
                  color: Colors.white, size: 32),
            ),
          ),
        ],
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
            width: 56,
            height: 56,
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
