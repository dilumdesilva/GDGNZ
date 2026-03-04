import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/locations.dart';
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
