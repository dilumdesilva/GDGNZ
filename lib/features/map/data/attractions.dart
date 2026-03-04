import '../domain/attraction_model.dart';

const nzAttractions = <Attraction>[
  // Auckland (6)
  Attraction(
    name: 'Sky Tower',
    description:
        'Auckland\'s iconic 328-metre tower offering panoramic views, a revolving restaurant, and the SkyWalk & SkyJump experiences.',
    latitude: -36.8485,
    longitude: 174.7622,
    websiteUrl: 'https://www.skycityauckland.co.nz/sky-tower/',
    region: 'Auckland',
  ),
  Attraction(
    name: 'Auckland War Memorial Museum',
    description:
        'A premier museum showcasing New Zealand\'s natural history, Māori taonga, and military heritage in a grand neo-classical building in the Auckland Domain.',
    latitude: -36.8600,
    longitude: 174.7770,
    websiteUrl: 'https://www.aucklandmuseum.com/',
    region: 'Auckland',
  ),
  Attraction(
    name: 'Rangitoto Island',
    description:
        'A volcanic island in the Hauraki Gulf, popular for hiking to the summit with stunning views of Auckland\'s skyline and harbour.',
    latitude: -36.7860,
    longitude: 174.8590,
    websiteUrl: 'https://www.doc.govt.nz/parks-and-recreation/places-to-go/auckland/places/rangitoto-island/',
    region: 'Auckland',
  ),
  Attraction(
    name: 'Waiheke Island',
    description:
        'A paradise island in the Hauraki Gulf known for its boutique vineyards, olive groves, pristine beaches, and vibrant arts scene.',
    latitude: -36.8010,
    longitude: 175.0860,
    websiteUrl: 'https://www.waiheke.co.nz/',
    region: 'Auckland',
  ),
  Attraction(
    name: 'One Tree Hill',
    description:
        'A prominent volcanic peak and historic pā site with an obelisk memorial, offering 360-degree views across Auckland.',
    latitude: -36.9008,
    longitude: 174.7790,
    websiteUrl: 'https://www.aucklandcouncil.govt.nz/parks-recreation/pages/park-details.aspx?Location=702',
    region: 'Auckland',
  ),
  Attraction(
    name: 'Viaduct Harbour',
    description:
        'Auckland\'s vibrant waterfront precinct featuring world-class restaurants, bars, and superyacht marina — a hub for dining and entertainment.',
    latitude: -36.8430,
    longitude: 174.7580,
    websiteUrl: 'https://www.viaductharbour.co.nz/',
    region: 'Auckland',
  ),

  // Wellington (6)
  Attraction(
    name: 'Te Papa Tongarewa',
    description:
        'New Zealand\'s national museum on Wellington\'s waterfront, featuring interactive exhibits on Māori culture, natural environment, and art.',
    latitude: -41.2906,
    longitude: 174.7819,
    websiteUrl: 'https://www.tepapa.govt.nz/',
    region: 'Wellington',
  ),
  Attraction(
    name: 'Wellington Cable Car',
    description:
        'An iconic funicular railway climbing from Lambton Quay to the Botanic Garden, with panoramic views of the city and harbour.',
    latitude: -41.2847,
    longitude: 174.7694,
    websiteUrl: 'https://www.wellingtoncablecar.co.nz/',
    region: 'Wellington',
  ),
  Attraction(
    name: 'Zealandia Te Māra a Tāne',
    description:
        'A groundbreaking ecosanctuary in the heart of Wellington, home to rare native wildlife including tuatara, kākā, and little spotted kiwi.',
    latitude: -41.2900,
    longitude: 174.7530,
    websiteUrl: 'https://www.visitzealandia.com/',
    region: 'Wellington',
  ),
  Attraction(
    name: 'Mt Victoria Lookout',
    description:
        'A popular hilltop lookout offering sweeping views of Wellington city, harbour, and surrounding hills — especially stunning at sunset.',
    latitude: -41.2960,
    longitude: 174.7930,
    websiteUrl: 'https://www.wellingtonnz.com/visit/things-to-do/mt-victoria-lookout',
    region: 'Wellington',
  ),
  Attraction(
    name: 'Wellington Botanic Garden',
    description:
        'A beautiful 25-hectare garden featuring native bush, exotic plants, sculptures, and the Carter Observatory.',
    latitude: -41.2810,
    longitude: 174.7680,
    websiteUrl: 'https://wellingtongardens.nz/',
    region: 'Wellington',
  ),
  Attraction(
    name: 'Weta Workshop Unleashed',
    description:
        'An immersive experience in Miramar showcasing the creative genius behind The Lord of the Rings, Avatar, and other blockbuster films.',
    latitude: -41.3110,
    longitude: 174.8230,
    websiteUrl: 'https://tours.wetaworkshop.com/',
    region: 'Wellington',
  ),

  // Christchurch (6)
  Attraction(
    name: 'Christchurch Botanic Gardens',
    description:
        'Established in 1863, these heritage gardens feature stunning plant collections, conservatories, and riverside walks in the heart of the city.',
    latitude: -43.5310,
    longitude: 172.6200,
    websiteUrl: 'https://www.ccc.govt.nz/parks-and-gardens/christchurch-botanic-gardens',
    region: 'Christchurch',
  ),
  Attraction(
    name: 'Christchurch Gondola',
    description:
        'A scenic cable car ride to the top of the Port Hills offering spectacular views of the Canterbury Plains, Lyttelton Harbour, and Southern Alps.',
    latitude: -43.5730,
    longitude: 172.6970,
    websiteUrl: 'https://www.christchurchattractions.nz/christchurch-gondola/',
    region: 'Christchurch',
  ),
  Attraction(
    name: 'International Antarctic Centre',
    description:
        'An interactive experience near Christchurch Airport where visitors can explore Antarctic storms, ride Hagglunds, and meet little blue penguins.',
    latitude: -43.4890,
    longitude: 172.5520,
    websiteUrl: 'https://www.iceberg.co.nz/',
    region: 'Christchurch',
  ),
  Attraction(
    name: 'Canterbury Museum',
    description:
        'A leading museum in the cultural precinct featuring Antarctic exploration history, Māori galleries, and natural history collections.',
    latitude: -43.5310,
    longitude: 172.6270,
    websiteUrl: 'https://www.canterburymuseum.com/',
    region: 'Christchurch',
  ),
  Attraction(
    name: 'Christchurch Tramway',
    description:
        'A heritage tramway looping through the city centre, passing key attractions, cafés, and the revitalised Cathedral Square.',
    latitude: -43.5330,
    longitude: 172.6370,
    websiteUrl: 'https://www.christchurchattractions.nz/christchurch-tram/',
    region: 'Christchurch',
  ),
  Attraction(
    name: 'New Regent Street',
    description:
        'A charming pedestrian-only lane lined with colourful Spanish Mission-style buildings, boutique shops, and cafés.',
    latitude: -43.5310,
    longitude: 172.6380,
    websiteUrl: 'https://www.newregentstreet.co.nz/',
    region: 'Christchurch',
  ),

  // General NZ (6)
  Attraction(
    name: 'Milford Sound',
    description:
        'A breathtaking fiord in Fiordland National Park, renowned for towering Mitre Peak, cascading waterfalls, and pristine rainforest.',
    latitude: -44.6718,
    longitude: 167.9264,
    websiteUrl: 'https://www.milford-sound.co.nz/',
    region: 'General NZ',
  ),
  Attraction(
    name: 'Hobbiton Movie Set',
    description:
        'The real Middle-earth film set near Matamata, featuring 44 hobbit holes, the Green Dragon Inn, and the Party Tree.',
    latitude: -37.8720,
    longitude: 175.6830,
    websiteUrl: 'https://www.hobbitontours.com/',
    region: 'General NZ',
  ),
  Attraction(
    name: 'Tongariro Alpine Crossing',
    description:
        'One of the world\'s greatest day hikes, traversing volcanic terrain with emerald lakes, active craters, and dramatic lava flows.',
    latitude: -39.1328,
    longitude: 175.6520,
    websiteUrl: 'https://www.doc.govt.nz/parks-and-recreation/places-to-go/central-north-island/places/tongariro-national-park/things-to-do/tracks/tongariro-alpine-crossing/',
    region: 'General NZ',
  ),
  Attraction(
    name: 'Te Pūia Rotorua',
    description:
        'Home to the famous Pōhutu Geyser, Te Pūia celebrates Māori culture with traditional arts, carving, weaving, and geothermal wonders.',
    latitude: -38.1620,
    longitude: 176.2520,
    websiteUrl: 'https://www.tepuia.com/',
    region: 'General NZ',
  ),
  Attraction(
    name: 'Abel Tasman National Park',
    description:
        'New Zealand\'s smallest yet most visited national park, famous for golden beaches, turquoise waters, and the coastal track.',
    latitude: -40.8830,
    longitude: 172.9060,
    websiteUrl: 'https://www.doc.govt.nz/parks-and-recreation/places-to-go/nelson-tasman/places/abel-tasman-national-park/',
    region: 'General NZ',
  ),
  Attraction(
    name: 'Fiordland National Park',
    description:
        'A UNESCO World Heritage area of ancient rainforests, dramatic fiords, and remote wilderness — home to the Milford and Kepler tracks.',
    latitude: -45.4145,
    longitude: 167.7180,
    websiteUrl: 'https://www.doc.govt.nz/parks-and-recreation/places-to-go/fiordland/',
    region: 'General NZ',
  ),
];
