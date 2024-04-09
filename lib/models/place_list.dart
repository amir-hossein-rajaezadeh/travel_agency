import 'package:travel_agency/models/place_model.dart';

//Fake place list
final List<PlaceModel> placeList = [
  PlaceModel(
      name: 'Dubai',
      desc:
          'Established in the 18th century as a small fishing village, Dubai grew into a regional trading hub in the early 20th century and grew rapidly in the late 20th and early 21st centuries with a focus on tourism and luxury.',
      placeVideo: 'assets/videos/dubai.mp4',
      hashtags: ['luxury', 'beach', 'persian_gulf'],
      additionalHashtagNums: 2),
  PlaceModel(
      name: 'New York',
      desc:
          'New York, often called New York City or simply NYC, is the most populous city in the United States, located at the southern tip of New York State on one of the worlds largest natural harbors. The city comprises five boroughs, each of which is coextensive with a respective county.',
      placeVideo: 'assets/videos/newyork.mp4',
      hashtags: ['USA', 'buisness_trip', 'city'],
      additionalHashtagNums: 4),
  PlaceModel(
      name: 'Shanghai ',
      desc:
          'Shanghai[a] is one of the four direct-administered municipalities of China.[b] The city is located on the southern estuary of the Yangtze River, with the Huangpu River flowing through it.',
      placeVideo: 'assets/videos/shanghi.mp4',
      hashtags: [
        'city_tour',
        'mega_police',
        'shopping',
      ],
      additionalHashtagNums: 2),
  PlaceModel(
      name: 'Paris ',
      desc:
          'Paris is a major railway, highway, and air-transport hub served by two international airports: Charles de Gaulle Airport (the third-busiest airport in Europe) and Orly Airport.',
      placeVideo: 'assets/videos/paris.mp4',
      hashtags: [
        'romantic',
        'city_tour',
        'eiffle_tower',
      ],
      additionalHashtagNums: 3),
];
