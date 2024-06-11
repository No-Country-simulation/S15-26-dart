import 'package:latlong2/latlong.dart';

class BoundingBox {
  final LatLng southwest;
  final LatLng northeast;

  BoundingBox({required this.southwest, required this.northeast});
}
