import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web/web.dart' as web;

import '../../../shared/theme/app_colors.dart';
import '../domain/location_model.dart';

class ChapterDetailCard extends StatelessWidget {
  final GdgLocation location;
  final VoidCallback? onDismiss;
  final bool fullScreen;

  const ChapterDetailCard({
    super.key,
    required this.location,
    this.onDismiss,
    this.fullScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth =
        fullScreen ? screenWidth : screenWidth * 0.25;

    return Container(
      width: fullScreen ? null : cardWidth,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: fullScreen ? BorderRadius.zero : BorderRadius.circular(20),
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
          // Cover image
          Stack(
            children: [
              Image.asset(
                location.coverImageAsset,
                width: double.infinity,
                height: 160,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: onDismiss,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.4),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Card body
          Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  location.chapterName,
                  style: GoogleFonts.openSans(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 10),

                // Description
                Text(
                  location.description,
                  style: GoogleFonts.openSans(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),

                // Organizers heading
                Text(
                  'ORGANIZERS',
                  style: GoogleFonts.openSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textSecondary.withValues(alpha: 0.6),
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 14),

                // Organizer cards in a row
                Wrap(
                  spacing: 20,
                  runSpacing: 16,
                  children: location.organizers
                      .map((org) => _OrganizerTile(organizer: org))
                      .toList(),
                ),
                const SizedBox(height: 24),

                // Member count
                Row(
                  children: [
                    Icon(Icons.people_outline,
                        size: 20, color: AppColors.textSecondary),
                    const SizedBox(width: 8),
                    Text(
                      '${location.memberCount} Members',
                      style: GoogleFonts.openSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Our Socials heading
                Text(
                  'OUR SOCIALS',
                  style: GoogleFonts.openSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textSecondary.withValues(alpha: 0.6),
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 12),

                // Social links row
                Row(
                  children: [
                    _SocialCircle(
                      iconAsset: 'assets/icons/facebook.svg.png',
                      url: location.socialLinks.facebook,
                    ),
                    const SizedBox(width: 12),
                    _SocialCircle(
                      iconAsset: 'assets/icons/instagram.png',
                      url: location.socialLinks.instagram,
                    ),
                    const SizedBox(width: 12),
                    _SocialCircle(
                      iconAsset: 'assets/icons/meetup.png',
                      url: location.socialLinks.meetup,
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Visit button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      web.window.open(location.url, '_blank');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.googleBlue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 0,
                    ),
                    child: Text(
                      'Visit ${location.chapterName}',
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

class _OrganizerTile extends StatelessWidget {
  final Organizer organizer;

  const _OrganizerTile({required this.organizer});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => web.window.open(organizer.linkedinUrl, '_blank'),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: SizedBox(
          width: 90,
          child: Column(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: AppColors.googleBlue.withValues(alpha: 0.1),
                backgroundImage: NetworkImage(organizer.avatarUrl),
              ),
              const SizedBox(height: 8),
              Text(
                organizer.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.openSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialCircle extends StatelessWidget {
  final String iconAsset;
  final String url;

  const _SocialCircle({
    required this.iconAsset,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => web.window.open(url, '_blank'),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          width: 42,
          height: 42,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Image.asset(iconAsset, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
