import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web/web.dart' as web;

import '../../../shared/theme/app_colors.dart';
import '../domain/attraction_model.dart';

class AttractionDetailCard extends StatelessWidget {
  final Attraction attraction;
  final VoidCallback? onDismiss;
  final bool fullScreen;

  const AttractionDetailCard({
    super.key,
    required this.attraction,
    this.onDismiss,
    this.fullScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = fullScreen ? screenWidth : screenWidth * 0.25;

    return Container(
      width: fullScreen ? null : cardWidth,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            fullScreen ? BorderRadius.zero : BorderRadius.circular(20),
        boxShadow: fullScreen
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 30,
                  offset: const Offset(-4, 8),
                ),
              ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Yellow accent header with close button
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(28, 24, 10, 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.googleYellow, Color(0xFFF9A825)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        attraction.region.toUpperCase(),
                        style: GoogleFonts.openSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Colors.black.withValues(alpha: 0.5),
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        attraction.name,
                        style: GoogleFonts.openSans(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: onDismiss,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Card body
          Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  attraction.description,
                  style: GoogleFonts.openSans(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 28),

                // Visit Website button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      web.window.open(attraction.websiteUrl, '_blank');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.googleYellow,
                      foregroundColor: AppColors.textPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 0,
                    ),
                    child: Text(
                      'Visit Website',
                      style: GoogleFonts.openSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: fullScreen ? 300.ms : 250.ms)
        .slideX(
          begin: fullScreen ? 0.0 : 1.0,
          end: 0.0,
          duration: fullScreen ? 0.ms : 350.ms,
          curve: Curves.easeOutCubic,
        );
  }
}
