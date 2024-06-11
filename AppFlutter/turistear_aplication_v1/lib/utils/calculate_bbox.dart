import 'dart:math';
import 'package:latlong2/latlong.dart';
import 'package:turistear_aplication_v1/utils/boundingbox.dart';

BoundingBox calculateBbox(LatLng currentPosition, double radiusKm) {
  double lat = currentPosition.latitude;
  double lon = currentPosition.longitude;

  double deltaLat = radiusKm / 111.32; // Degrees per km in latitude
  double deltaLon = radiusKm /
      (111.32 *
          cos(lat *
              pi /
              180)); // Degrees per km in longitude, adjusted for latitude

  LatLng southwest = LatLng(lat - deltaLat, lon - deltaLon);
  LatLng northeast = LatLng(lat + deltaLat, lon + deltaLon);

  return BoundingBox(southwest: southwest, northeast: northeast);
}
