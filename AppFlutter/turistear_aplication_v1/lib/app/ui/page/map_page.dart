import 'package:flutter/material.dart';
import 'package:turistear_aplication_v1/app/ui/components/custom_app_bar.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class TouristSite {
  final String name;
  final LatLng location;

  TouristSite(this.name, this.location);
}

final List<TouristSite> touristSites = [
  TouristSite("Eiffel Tower", const LatLng(48.8584, 2.2945)),
  TouristSite("Louvre Museum", const LatLng(48.8606, 2.3376)),
  TouristSite("Notre Dame Cathedral", const LatLng(48.852968, 2.349902)),
  // Agrega más sitios turísticos aquí
];

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'TuristAPP'),
      body: FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(51.5, -0.09),
          initialZoom: 13.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: const ['a', 'b', 'c'],
          ),
        ],
      ),
    );
  }
}
