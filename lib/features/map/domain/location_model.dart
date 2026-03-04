import 'dart:ui';

class GdgLocation {
  final String name;
  final String chapterName;
  final String description;
  final int expertCount;
  final String memberCount;
  final double latitude;
  final double longitude;
  final Offset normalizedPosition;
  final List<Organizer> organizers;
  final String url;
  final String coverImageAsset;
  final SocialLinks socialLinks;

  const GdgLocation({
    required this.name,
    required this.chapterName,
    required this.description,
    required this.expertCount,
    required this.memberCount,
    required this.latitude,
    required this.longitude,
    required this.normalizedPosition,
    required this.organizers,
    required this.url,
    required this.coverImageAsset,
    required this.socialLinks,
  });
}

class Organizer {
  final String name;
  final String avatarUrl;
  final String linkedinUrl;

  const Organizer({
    required this.name,
    required this.avatarUrl,
    required this.linkedinUrl,
  });
}

class SocialLinks {
  final String facebook;
  final String instagram;
  final String meetup;

  const SocialLinks({
    required this.facebook,
    required this.instagram,
    required this.meetup,
  });
}
