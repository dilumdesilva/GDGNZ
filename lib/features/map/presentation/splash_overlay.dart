import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashOverlay extends StatefulWidget {
  final VoidCallback onComplete;

  const SplashOverlay({super.key, required this.onComplete});

  @override
  State<SplashOverlay> createState() => _SplashOverlayState();
}

class _SplashOverlayState extends State<SplashOverlay> {
  int _phase = 0; // 0 = "Kia Ora!", 1 = "Haere Mai..."
  double _overlayOpacity = 1.0;
  Timer? _swapTimer;
  Timer? _fadeTimer;

  @override
  void initState() {
    super.initState();

    // At 5s, swap greeting text
    _swapTimer = Timer(const Duration(seconds: 5), () {
      if (!mounted) return;
      setState(() => _phase = 1);
    });

    // At 10s, fade out overlay then call onComplete
    _fadeTimer = Timer(const Duration(seconds: 10), () {
      if (!mounted) return;
      setState(() => _overlayOpacity = 0.0);
    });
  }

  @override
  void dispose() {
    _swapTimer?.cancel();
    _fadeTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final greetingSize =
        screenWidth < 600 ? 36.0 : (screenWidth < 1200 ? 52.0 : 68.0);
    final subtitleSize =
        screenWidth < 600 ? 14.0 : (screenWidth < 1200 ? 20.0 : 26.0);

    final greeting =
        _phase == 0 ? 'Kia Ora!' : 'Haere Mai, Nau Mai e ngā iwi e';

    return AnimatedOpacity(
      opacity: _overlayOpacity,
      duration: const Duration(milliseconds: 800),
      onEnd: () {
        if (_overlayOpacity == 0.0) {
          widget.onComplete();
        }
      },
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 150, sigmaY: 150),
          child: Container(
            color: Colors.black.withValues(alpha: 0.7),
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 600),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.3),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOut,
                        )),
                        child: child,
                      ),
                    );
                  },
                  child: Text(
                    greeting,
                    key: ValueKey(_phase),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      fontSize: greetingSize,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Google Developer Groups of New Zealand',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.openSans(
                    fontSize: subtitleSize,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
