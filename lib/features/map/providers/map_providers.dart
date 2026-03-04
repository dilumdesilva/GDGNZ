import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/attractions.dart';
import '../data/locations.dart';
import '../domain/attraction_model.dart';
import '../domain/location_model.dart';

final selectedLocationProvider =
    NotifierProvider<SelectedLocationNotifier, GdgLocation?>(
  SelectedLocationNotifier.new,
);

class SelectedLocationNotifier extends Notifier<GdgLocation?> {
  @override
  GdgLocation? build() => null;

  void select(GdgLocation? location) {
    state = location;
  }
}

final locationsProvider = Provider<List<GdgLocation>>((ref) => gdgLocations);

final showAttractionsProvider =
    NotifierProvider<ShowAttractionsNotifier, bool>(
  ShowAttractionsNotifier.new,
);

class ShowAttractionsNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void toggle(bool value) {
    state = value;
  }
}

final selectedAttractionProvider =
    NotifierProvider<SelectedAttractionNotifier, Attraction?>(
  SelectedAttractionNotifier.new,
);

class SelectedAttractionNotifier extends Notifier<Attraction?> {
  @override
  Attraction? build() => null;

  void select(Attraction? attraction) {
    state = attraction;
  }
}

final attractionsProvider =
    Provider<List<Attraction>>((ref) => nzAttractions);
