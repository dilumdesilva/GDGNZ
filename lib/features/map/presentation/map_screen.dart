import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/theme/app_colors.dart';
import '../providers/map_providers.dart';
import 'attraction_detail_card.dart';
import 'chapter_detail_card.dart';
import 'hero_title.dart';
import 'satellite_map_widget.dart';

class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLocation = ref.watch(selectedLocationProvider);
    final selectedAttraction = ref.watch(selectedAttractionProvider);
    final showAttractions = ref.watch(showAttractionsProvider);
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: Column(
        children: [
          // White nav bar pinned to very top
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              top: MediaQuery.of(context).padding.top + (isMobile ? 12 : 20),
              bottom: isMobile ? 12 : 20,
            ),
            child: const HeroTitle(),
          ),

          // Map fills the rest
          Expanded(
            child: Stack(
              children: [
                const Positioned.fill(
                  child: SatelliteMapWidget(),
                ),

                // Toggle pill — top-left of map
                Positioned(
                  top: 16,
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
                            child: SingleChildScrollView(
                              child: ChapterDetailCard(
                                key: ValueKey(selectedLocation.name),
                                location: selectedLocation,
                                fullScreen: true,
                                onDismiss: () {
                                  ref
                                      .read(selectedLocationProvider.notifier)
                                      .select(null);
                                },
                              ),
                            ),
                          ),
                        )
                      : Positioned(
                          top: 0,
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
                            child: SingleChildScrollView(
                              child: AttractionDetailCard(
                                key: ValueKey(selectedAttraction.name),
                                attraction: selectedAttraction,
                                fullScreen: true,
                                onDismiss: () {
                                  ref
                                      .read(
                                          selectedAttractionProvider.notifier)
                                      .select(null);
                                },
                              ),
                            ),
                          ),
                        )
                      : Positioned(
                          top: 0,
                          right: 32,
                          bottom: 0,
                          child: Center(
                            child: SingleChildScrollView(
                              child: AttractionDetailCard(
                                key: ValueKey(selectedAttraction.name),
                                attraction: selectedAttraction,
                                onDismiss: () {
                                  ref
                                      .read(
                                          selectedAttractionProvider.notifier)
                                      .select(null);
                                },
                              ),
                            ),
                          ),
                        ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
