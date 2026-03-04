import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/theme/app_colors.dart';
import '../providers/map_providers.dart';
import 'attraction_detail_card.dart';
import 'chapter_detail_card.dart';
import 'hero_title.dart';
import 'satellite_map_widget.dart';
import 'splash_overlay.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  bool _splashComplete = false;

  @override
  Widget build(BuildContext context) {
    final selectedLocation = ref.watch(selectedLocationProvider);
    final selectedAttraction = ref.watch(selectedAttractionProvider);
    final showAttractions = ref.watch(showAttractionsProvider);
    final isMobile = MediaQuery.of(context).size.width < 600;
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Stack(
        children: [
          // Map fills the entire screen
          const Positioned.fill(
            child: SatelliteMapWidget(),
          ),

          // Frosted glass nav bar — only visible after splash
          if (_splashComplete)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ui.ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.3),
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.white.withValues(alpha: 0.15),
                          width: 0.5,
                        ),
                      ),
                    ),
                    padding: EdgeInsets.only(
                      left: 24,
                      right: 24,
                      top: topPadding + (isMobile ? 12 : 20),
                      bottom: isMobile ? 12 : 20,
                    ),
                    child: const HeroTitle(),
                  ),
                ),
              ),
            ),

          // Toggle pill — top-left of map area
          if (_splashComplete)
            Positioned(
              top: topPadding + (isMobile ? 130 : 180),
              left: 16,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Show Attractions',
                      style: GoogleFonts.openSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      height: 24,
                      child: Switch(
                        value: showAttractions,
                        onChanged: (value) {
                          ref
                              .read(showAttractionsProvider.notifier)
                              .toggle(value);
                        },
                        activeThumbColor: AppColors.googleYellow,
                        materialTapTargetSize:
                            MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // GDG Chapter detail card
          if (selectedLocation != null)
            isMobile
                ? Positioned.fill(
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(
                              top: topPadding + 16,
                              bottom: 12,
                              left: 24,
                              right: 24,
                            ),
                            child: Text(
                              'Google Developer Groups NZ',
                              style: GoogleFonts.openSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: ChapterDetailCard(
                                key: ValueKey(selectedLocation.name),
                                location: selectedLocation,
                                fullScreen: true,
                                onDismiss: () {
                                  ref
                                      .read(
                                          selectedLocationProvider.notifier)
                                      .select(null);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Positioned(
                    top: topPadding + 120,
                    right: 32,
                    bottom: 0,
                    child: Center(
                      child: SingleChildScrollView(
                        child: ChapterDetailCard(
                          key: ValueKey(selectedLocation.name),
                          location: selectedLocation,
                          onDismiss: () {
                            ref
                                .read(selectedLocationProvider.notifier)
                                .select(null);
                          },
                        ),
                      ),
                    ),
                  ),

          // Attraction detail card
          if (selectedAttraction != null)
            isMobile
                ? Positioned.fill(
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(
                              top: topPadding + 16,
                              bottom: 12,
                              left: 24,
                              right: 24,
                            ),
                            child: Text(
                              'Google Developer Groups NZ',
                              style: GoogleFonts.openSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: AttractionDetailCard(
                                key: ValueKey(selectedAttraction.name),
                                attraction: selectedAttraction,
                                fullScreen: true,
                                onDismiss: () {
                                  ref
                                      .read(selectedAttractionProvider
                                          .notifier)
                                      .select(null);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Positioned(
                    top: topPadding + 120,
                    right: 32,
                    bottom: 0,
                    child: Center(
                      child: SingleChildScrollView(
                        child: AttractionDetailCard(
                          key: ValueKey(selectedAttraction.name),
                          attraction: selectedAttraction,
                          onDismiss: () {
                            ref
                                .read(selectedAttractionProvider.notifier)
                                .select(null);
                          },
                        ),
                      ),
                    ),
                  ),

          // Splash overlay on top of everything
          if (!_splashComplete)
            Positioned.fill(
              child: SplashOverlay(
                onComplete: () {
                  setState(() => _splashComplete = true);
                  ref.read(splashCompleteProvider.notifier).complete();
                  jsFlyToNZ();
                },
              ),
            ),
        ],
      ),
    );
  }
}
