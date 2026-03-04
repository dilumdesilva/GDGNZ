import 'dart:js_interop';
import 'dart:js_interop_unsafe';
import 'dart:ui_web' as ui_web;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web/web.dart' as web;

import '../data/attractions.dart';
import '../data/locations.dart';
import '../domain/attraction_model.dart';
import '../domain/location_model.dart';
import '../providers/map_providers.dart';

const _viewType = 'maplibre-container';
bool _factoryRegistered = false;

class SatelliteMapWidget extends ConsumerStatefulWidget {
  const SatelliteMapWidget({super.key});

  @override
  ConsumerState<SatelliteMapWidget> createState() =>
      _SatelliteMapWidgetState();
}

class _SatelliteMapWidgetState extends ConsumerState<SatelliteMapWidget> {
  bool _mapInitialized = false;

  @override
  void initState() {
    super.initState();
    _registerViewFactory();
  }

  void _registerViewFactory() {
    if (_factoryRegistered) return;
    _factoryRegistered = true;

    ui_web.platformViewRegistry.registerViewFactory(
      _viewType,
      (int viewId, {Object? params}) {
        final div = web.document.createElement('div') as web.HTMLDivElement;
        div.id = 'maplibre-map';
        div.style.width = '100%';
        div.style.height = '100%';
        return div;
      },
    );
  }

  void _initMapWhenReady() {
    if (_mapInitialized) return;
    _mapInitialized = true;

    // Allow the platform view to mount before initializing MapLibre
    Future.delayed(const Duration(milliseconds: 200), () {
      if (!mounted) return;

      _jsInitMap('maplibre-map'.toJS);
      _setupCallbacks();
    });
  }

  void _setupMarkers() {
    final jsArray = <JSObject>[];
    for (final loc in gdgLocations) {
      final obj = JSObject();
      obj['name'] = loc.name.toJS;
      obj['latitude'] = loc.latitude.toJS;
      obj['longitude'] = loc.longitude.toJS;
      jsArray.add(obj);
    }
    _jsAddMarkers(jsArray.toJS);
  }

  void _setupCallbacks() {
    globalContext['_onMarkerClick'] = ((JSString name) {
      final locationName = name.toDart;
      final location = gdgLocations.cast<GdgLocation?>().firstWhere(
            (l) => l!.name == locationName,
            orElse: () => null,
          );
      if (location != null) {
        ref.read(selectedLocationProvider.notifier).select(location);
      }
    }).toJS;

    globalContext['_onMapBackgroundClick'] = (() {
      ref.read(selectedLocationProvider.notifier).select(null);
      ref.read(selectedAttractionProvider.notifier).select(null);
    }).toJS;

    globalContext['_onAttractionClick'] = ((JSString name) {
      final attractionName = name.toDart;
      final attraction = nzAttractions.cast<Attraction?>().firstWhere(
            (a) => a!.name == attractionName,
            orElse: () => null,
          );
      if (attraction != null) {
        // Clear GDG selection when attraction is clicked
        ref.read(selectedLocationProvider.notifier).select(null);
        ref.read(selectedAttractionProvider.notifier).select(attraction);
      }
    }).toJS;
  }

  void _addAttractionMarkers() {
    final jsArray = <JSObject>[];
    for (final attraction in nzAttractions) {
      final obj = JSObject();
      obj['name'] = attraction.name.toJS;
      obj['latitude'] = attraction.latitude.toJS;
      obj['longitude'] = attraction.longitude.toJS;
      jsArray.add(obj);
    }
    _jsAddAttractionMarkers(jsArray.toJS);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<bool>(splashCompleteProvider, (prev, next) {
      if (next && _mapInitialized) {
        _setupMarkers();
      }
    });

    ref.listen<GdgLocation?>(selectedLocationProvider, (prev, next) {
      if (!_mapInitialized) return;
      if (next != null) {
        // Clear attraction selection when GDG location is clicked
        ref.read(selectedAttractionProvider.notifier).select(null);
        _jsFlyToLocation(next.longitude.toJS, next.latitude.toJS, 11.0.toJS);
      } else if (prev != null) {
        _jsFlyToOverview();
      }
    });

    ref.listen<bool>(showAttractionsProvider, (prev, next) {
      if (!_mapInitialized) return;
      if (next) {
        _addAttractionMarkers();
        _jsEnableMapInteraction();
      } else {
        _jsRemoveAttractionMarkers();
        _jsDisableMapInteraction();
        ref.read(selectedAttractionProvider.notifier).select(null);
        _jsFlyToOverview();
      }
    });

    return HtmlElementView(
      viewType: _viewType,
      onPlatformViewCreated: (_) => _initMapWhenReady(),
    );
  }
}

@JS('initMap')
external void _jsInitMap(JSString containerId);

@JS('addMarkers')
external void _jsAddMarkers(JSArray<JSObject> locations);

@JS('flyToLocation')
external void _jsFlyToLocation(JSNumber lng, JSNumber lat, JSNumber zoom);

@JS('flyToOverview')
external void _jsFlyToOverview();

@JS('addAttractionMarkers')
external void _jsAddAttractionMarkers(JSArray<JSObject> locations);

@JS('removeAttractionMarkers')
external void _jsRemoveAttractionMarkers();

@JS('flyToNZ')
external void jsFlyToNZ();

@JS('enableMapInteraction')
external void _jsEnableMapInteraction();

@JS('disableMapInteraction')
external void _jsDisableMapInteraction();
