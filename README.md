# GDG New Zealand

An interactive web experience showcasing Google Developer Group chapters across New Zealand, built with Flutter Web and MapLibre GL JS.

## About

GDG NZ features a 3D satellite map of New Zealand where users can explore GDG chapters in Auckland, Wellington, and Christchurch. Clicking a location pin reveals chapter details including organizers, member count, social links, and a direct link to the chapter page.

### Chapters

- **GDG Auckland** — 3500+ members
- **GDG Wellington** — 1200+ members
- **GDG Christchurch** — 800+ members

## Tech Stack

| Layer | Technology |
|-------|-----------|
| **Framework** | Flutter Web (Dart SDK ^3.11.0) |
| **State Management** | Riverpod 3.x |
| **Map Rendering** | MapLibre GL JS 4.7 (open-source, no API key) |
| **Satellite Imagery** | ESRI World Imagery (free raster tiles) |
| **3D Terrain** | AWS Terrain Tiles (Terrarium format, public S3) |
| **Dart-JS Bridge** | `dart:js_interop` + `dart:js_interop_unsafe` |
| **Fonts** | Google Fonts (Open Sans) |
| **Animations** | flutter_animate |

## Architecture

```
lib/
  app/                    # App entry point, routing, theme
  features/
    map/
      data/               # GDG location data (coordinates, organizers, socials)
      domain/             # Location model, Organizer, SocialLinks
      providers/          # Riverpod state (selectedLocation, locations)
      presentation/       # UI widgets
        map_screen.dart           # Main layout (nav bar + map + card overlay)
        satellite_map_widget.dart # HtmlElementView wrapping MapLibre
        chapter_detail_card.dart  # Detail card with cover, organizers, socials
        hero_title.dart           # Rotating greeting header
        info_pill.dart            # Compact location info pill
  shared/
    theme/                # App colors, theme data
    widgets/              # Responsive builder utility

web/
  index.html              # Entry point with MapLibre CDN
  map_init.js             # JS map controller (init, markers, flyTo)

assets/
  images/                 # City cover photos (Auckland, Wellington, Christchurch)
  icons/                  # Social media icons (Facebook, Instagram, Meetup)
```

## How It Works

1. **Page loads** — MapLibre renders a 3D satellite view of New Zealand at 60° pitch with terrain exaggeration
2. **Markers appear** — Blue pulsing pins with city labels for each GDG chapter
3. **Click a pin** — Map flies to the city; a detail card slides in from the right (desktop) or fills the screen (mobile)
4. **Detail card** — Shows cover image, chapter description, organizer avatars (linked to LinkedIn), member count, social links, and a visit button
5. **Dismiss** — Click the X or tap the map background to fly back to the overview

### Desktop vs Mobile

- **Desktop**: Map interactions locked for stability. Detail card appears as a side panel (25% width).
- **Mobile**: Touch pan and pinch-to-zoom enabled. Detail card opens full-screen with a close button.

## Getting Started

### Prerequisites

- Flutter SDK ^3.11.0
- Chrome browser (for web target)

### Run

```bash
flutter pub get
flutter run -d chrome
```

### Build

```bash
flutter build web
```

The build output is in `build/web/`.

## Data

Location data is defined in `lib/features/map/data/locations.dart`. To add or update a chapter, modify the `gdgLocations` list with:

- Chapter name and description
- Coordinates (latitude/longitude)
- Organizer names, avatar URLs, and LinkedIn links
- Member count
- Social media links (Facebook, Instagram, Meetup)
- Cover image (add to `assets/images/`)

## Disclaimer

All chapter data currently displayed (organizer names, member counts, social links, etc.) is **mocked and not accurate**. This will be replaced with real data in a future update.

## License

This project is maintained by GDG Auckland.
