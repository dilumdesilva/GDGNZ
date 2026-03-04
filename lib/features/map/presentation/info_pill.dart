import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/theme/app_colors.dart';
import '../domain/location_model.dart';

class InfoPill extends StatelessWidget {
  final GdgLocation location;
  final VoidCallback? onDismiss;

  const InfoPill({
    super.key,
    required this.location,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label:
          '${location.chapterName} chapter information. ${location.expertCount} Google Developer Expert.',
      liveRegion: true,
      child: GestureDetector(
        onTap: onDismiss,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                location.chapterName,
                style: GoogleFonts.openSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${location.expertCount} Google Developer Expert',
                style: GoogleFonts.openSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        )
            .animate()
            .fadeIn(duration: 200.ms, curve: Curves.easeInOut)
            .scale(
              begin: const Offset(0.9, 0.9),
              end: const Offset(1.0, 1.0),
              duration: 200.ms,
              curve: Curves.easeInOut,
            ),
      ),
    );
  }
}
