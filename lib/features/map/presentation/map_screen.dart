import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/map_providers.dart';
import 'chapter_detail_card.dart';
import 'hero_title.dart';
import 'satellite_map_widget.dart';

class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLocation = ref.watch(selectedLocationProvider);
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

                // Detail card
                if (selectedLocation != null)
                  isMobile
                      // Mobile: full-screen card overlay
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
                      // Desktop: side card, vertically centered
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
