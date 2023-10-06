import 'dart:math';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const double rayonTerre = 6371000; // Rayon moyen de la Terre en mètres
Future decodeAddress(LatLng locat) async {
  List<Placemark>  p = await placemarkFromCoordinates(locat.latitude, locat.longitude);
  print(p[0].country! + p[0].locality.toString() +p[0].name!);
  return {'country':p[0].country!,'locality':p[0].locality.toString(),'name':p[0].name!,'locate':p[0].country! + p[0].locality.toString() +p[0].name! };
}

bool estAProximite( double lat2, double lon2) {
  double distance = calculerDistance(3.858919, 11.499989, lat2, lon2);
  print(distance);
  return distance <= 10;
}

double calculerDistance(double lat1, double lon1, double lat2, double lon2) {
  double lat1Rad = degToRad(lat1);
  double lon1Rad = degToRad(lon1);
  double lat2Rad = degToRad(lat2);
  double lon2Rad = degToRad(lon2);

  double deltaLat = lat2Rad - lat1Rad;
  double deltaLon = lon2Rad - lon1Rad;

  double a = sin(deltaLat / 2) * sin(deltaLat / 2) +
      cos(lat1Rad) * cos(lat2Rad) * sin(deltaLon / 2) * sin(deltaLon / 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  double distance = rayonTerre * c;
  return distance;
}

double degToRad(double deg) {
  return deg * pi / 180;
}