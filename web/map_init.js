// MapLibre GL JS controller for GDG NZ satellite map

let map = null;
const markers = [];

const NZ_CENTER = [173.5, -41.5];
const NZ_ZOOM = 5.5;
const NZ_PITCH = 60;
const NZ_BEARING = -10;

function initMap(containerId) {
  map = new maplibregl.Map({
    container: containerId,
    style: {
      version: 8,
      sources: {
        'esri-satellite': {
          type: 'raster',
          tiles: [
            'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}'
          ],
          tileSize: 256,
          maxzoom: 18,
          attribution: 'Tiles &copy; Esri'
        },
        'terrain-dem': {
          type: 'raster-dem',
          tiles: [
            'https://s3.amazonaws.com/elevation-tiles-prod/terrarium/{z}/{x}/{y}.png'
          ],
          tileSize: 256,
          maxzoom: 15,
          encoding: 'terrarium'
        }
      },
      layers: [
        {
          id: 'satellite-layer',
          type: 'raster',
          source: 'esri-satellite',
          minzoom: 0,
          maxzoom: 18
        }
      ],
      terrain: {
        source: 'terrain-dem',
        exaggeration: 1.5
      },
      sky: {}
    },
    center: NZ_CENTER,
    zoom: NZ_ZOOM,
    pitch: NZ_PITCH,
    bearing: NZ_BEARING,
    maxPitch: 85,
    antialias: true,
    attributionControl: false
  });

  // Disable mouse-driven movement on desktop so pins stay stable
  // On mobile (touch), allow panning around NZ
  var isMobile = window.innerWidth < 600;
  if (!isMobile) {
    map.dragPan.disable();
    map.dragRotate.disable();
    map.scrollZoom.disable();
    map.doubleClickZoom.disable();
    map.keyboard.disable();
  }
  // Keep touch zoom/rotate enabled on mobile, disable on desktop
  if (!isMobile) {
    map.touchZoomRotate.disable();
  }

  // Click on map background → fly back to overview
  map.on('click', function (e) {
    // Check if click was on a marker (marker clicks stop propagation)
    if (e.originalEvent && e.originalEvent._markerClick) return;
    flyToOverview();
    if (window._onMapBackgroundClick) {
      window._onMapBackgroundClick();
    }
  });
}

function addMarkers(locations) {
  // Remove existing markers
  markers.forEach(m => m.remove());
  markers.length = 0;

  locations.forEach(function (loc) {
    // Wrapper holds pin + label side by side
    const wrapper = document.createElement('div');
    wrapper.className = 'gdg-marker-wrapper';
    wrapper.style.cssText = `
      display: flex;
      align-items: center;
      gap: 8px;
      cursor: pointer;
    `;

    // Pin circle
    const el = document.createElement('div');
    el.className = 'gdg-marker';
    el.style.cssText = `
      width: 36px;
      height: 36px;
      min-width: 36px;
      border-radius: 50%;
      background: #4285F4;
      border: 3px solid white;
      cursor: pointer;
      box-shadow: 0 2px 8px rgba(0,0,0,0.3);
      position: relative;
      transition: transform 0.2s ease, background 0.2s ease;
    `;

    // Pulse ring
    const pulse = document.createElement('div');
    pulse.style.cssText = `
      position: absolute;
      top: -6px;
      left: -6px;
      width: 48px;
      height: 48px;
      border-radius: 50%;
      border: 2px solid rgba(66, 133, 244, 0.5);
      animation: gdg-pulse 2s infinite;
      pointer-events: none;
    `;
    el.appendChild(pulse);

    // City name label
    const label = document.createElement('span');
    label.textContent = loc.name;
    label.style.cssText = `
      color: white;
      font-family: 'Open Sans', Arial, sans-serif;
      font-size: 13px;
      font-weight: 700;
      text-shadow: 0 1px 4px rgba(0,0,0,0.7);
      white-space: nowrap;
      pointer-events: none;
      user-select: none;
    `;

    wrapper.appendChild(el);
    wrapper.appendChild(label);

    // Add pulse animation style if not exists
    if (!document.getElementById('gdg-marker-styles')) {
      const style = document.createElement('style');
      style.id = 'gdg-marker-styles';
      style.textContent = `
        @keyframes gdg-pulse {
          0% { transform: scale(1); opacity: 1; }
          100% { transform: scale(1.8); opacity: 0; }
        }
        .gdg-marker-wrapper:hover .gdg-marker {
          transform: scale(1.2);
        }
      `;
      document.head.appendChild(style);
    }

    wrapper.addEventListener('click', function (e) {
      e.stopPropagation();
      // Tag the original event so map click handler can ignore it
      if (map && e._markerClick === undefined) {
        e._markerClick = true;
      }

      flyToLocation(loc.longitude, loc.latitude, 11);

      if (window._onMarkerClick) {
        window._onMarkerClick(loc.name);
      }
    });

    const marker = new maplibregl.Marker({ element: wrapper, anchor: 'left' })
      .setLngLat([loc.longitude, loc.latitude])
      .addTo(map);

    markers.push(marker);
  });
}

function flyToLocation(lng, lat, zoom) {
  if (!map) return;
  map.flyTo({
    center: [lng, lat],
    zoom: zoom || 11,
    pitch: 60,
    bearing: 0,
    duration: 2000,
    essential: true
  });
}

function flyToOverview() {
  if (!map) return;
  map.flyTo({
    center: NZ_CENTER,
    zoom: NZ_ZOOM,
    pitch: NZ_PITCH,
    bearing: NZ_BEARING,
    duration: 2000,
    essential: true
  });
}
