import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

const _rotatingWords = ['Kia Ora', 'Welcome'];

class HeroTitle extends StatefulWidget {
  const HeroTitle({super.key});

  @override
  State<HeroTitle> createState() => _HeroTitleState();
}

class _HeroTitleState extends State<HeroTitle> {
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _rotatingWords.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final titleSize =
        screenWidth < 600 ? 24.0 : (screenWidth < 1200 ? 36.0 : 48.0);
    final subtitleSize =
        screenWidth < 600 ? 14.0 : (screenWidth < 1200 ? 18.0 : 22.0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
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
            _rotatingWords[_currentIndex],
            key: ValueKey(_currentIndex),
            textAlign: TextAlign.center,
            style: GoogleFonts.openSans(
              fontSize: titleSize,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 4),
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
    )
        .animate()
        .fadeIn(duration: 800.ms, delay: 200.ms, curve: Curves.easeInOut)
        .slideY(
          begin: -0.1,
          end: 0,
          duration: 800.ms,
          delay: 200.ms,
          curve: Curves.easeOut,
        );
  }
}
