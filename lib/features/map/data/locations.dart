import 'dart:ui';

import '../domain/location_model.dart';

final List<GdgLocation> gdgLocations = [
  const GdgLocation(
    name: 'Auckland',
    chapterName: 'GDG Auckland',
    description:
        'A community of developers passionate about Google technologies in Auckland, New Zealand.',
    expertCount: 1,
    memberCount: '3500+',
    latitude: -36.85,
    longitude: 174.76,
    normalizedPosition: Offset(0.68, 0.19),
    url: 'https://gdg.community.dev/gdg-auckland/',
    coverImageAsset: 'assets/images/auckland.jpg',
    socialLinks: SocialLinks(
      facebook: 'https://facebook.com',
      instagram: 'https://instagram.com',
      meetup: 'https://meetup.com',
    ),
    organizers: [
      Organizer(
        name: 'Dilum De Silva',
        avatarUrl:
            'https://ui-avatars.com/api/?name=Dilum+De+Silva&background=4285F4&color=fff',
        linkedinUrl: 'https://linkedin.com',
      ),
      Organizer(
        name: 'Jatin Rao',
        avatarUrl:
            'https://ui-avatars.com/api/?name=Jatin+Rao&background=EA4335&color=fff',
        linkedinUrl: 'https://linkedin.com',
      ),
      Organizer(
        name: 'Emily Chen',
        avatarUrl:
            'https://ui-avatars.com/api/?name=Emily+Chen&background=34A853&color=fff',
        linkedinUrl: 'https://linkedin.com',
      ),
    ],
  ),
  const GdgLocation(
    name: 'Wellington',
    chapterName: 'GDG Wellington',
    description:
        'Wellington\'s community for developers who love building with Google technologies.',
    expertCount: 1,
    memberCount: '1200+',
    latitude: -41.29,
    longitude: 174.78,
    normalizedPosition: Offset(0.69, 0.53),
    url: 'https://gdg.community.dev/gdg-wellington/',
    coverImageAsset: 'assets/images/wellington.jpg',
    socialLinks: SocialLinks(
      facebook: 'https://facebook.com',
      instagram: 'https://instagram.com',
      meetup: 'https://meetup.com',
    ),
    organizers: [
      Organizer(
        name: 'Sarah Kim',
        avatarUrl:
            'https://ui-avatars.com/api/?name=Sarah+Kim&background=FBBC05&color=fff',
        linkedinUrl: 'https://linkedin.com',
      ),
      Organizer(
        name: 'Tom Brown',
        avatarUrl:
            'https://ui-avatars.com/api/?name=Tom+Brown&background=4285F4&color=fff',
        linkedinUrl: 'https://linkedin.com',
      ),
    ],
  ),
  const GdgLocation(
    name: 'Christchurch',
    chapterName: 'GDG Christchurch',
    description:
        'Connecting Christchurch developers through Google technology meetups and events.',
    expertCount: 1,
    memberCount: '800+',
    latitude: -43.53,
    longitude: 172.64,
    normalizedPosition: Offset(0.51, 0.70),
    url: 'https://gdg.community.dev/gdg-christchurch/',
    coverImageAsset: 'assets/images/christchurch.jpg',
    socialLinks: SocialLinks(
      facebook: 'https://facebook.com',
      instagram: 'https://instagram.com',
      meetup: 'https://meetup.com',
    ),
    organizers: [
      Organizer(
        name: 'James Lee',
        avatarUrl:
            'https://ui-avatars.com/api/?name=James+Lee&background=EA4335&color=fff',
        linkedinUrl: 'https://linkedin.com',
      ),
      Organizer(
        name: 'Anna Park',
        avatarUrl:
            'https://ui-avatars.com/api/?name=Anna+Park&background=34A853&color=fff',
        linkedinUrl: 'https://linkedin.com',
      ),
      Organizer(
        name: 'Mike Ray',
        avatarUrl:
            'https://ui-avatars.com/api/?name=Mike+Ray&background=FBBC05&color=fff',
        linkedinUrl: 'https://linkedin.com',
      ),
    ],
  ),
];
