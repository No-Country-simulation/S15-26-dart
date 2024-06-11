import 'package:flutter/material.dart';
import 'package:flutter_map_supercluster/flutter_map_supercluster.dart';
import 'package:geolocator/geolocator.dart';
import 'package:turistear_aplication_v1/app/api/overpass_api_service.dart';
import 'package:turistear_aplication_v1/app/services/location_service.dart';
import 'package:turistear_aplication_v1/app/ui/components/custom_app_bar.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:turistear_aplication_v1/app/ui/components/widgetmap/flutter_map_zoom_buttons.dart';

class TouristSite {
  final String name;
  final LatLng location;
  final String category;

  TouristSite(this.name, this.location, this.category);
}

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  MapPageState createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  List<Marker> markers = [];
  LatLng? currentPosition;
  final MapController _mapController = MapController();
  final OverpassApiService _apiService = OverpassApiService();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    LocationService locationService = LocationService();
    LatLng? position = await locationService.getCurrentLocation();
    if (position != null) {
      setState(() {
        currentPosition = position;
        markers.add(
          Marker(
            point: currentPosition!,
            width: 80,
            height: 80,
            child: const Icon(
              Icons.my_location,
              color: Colors.blue,
              size: 40,
            ),
          ),
        );
      });
    }
  }

  List<Marker> _createMarkers(BuildContext context, List<TouristSite> sites) {
    return sites
        .map((site) => Marker(
              point: site.location,
              width: 80,
              height: 80,
              child: GestureDetector(
                onTap: () => _showMarkerInfo(context, site),
                child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ))
        .toList();
  }

  void _showMarkerInfo(BuildContext context, TouristSite site) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(site.name),
          content: Text(
              'Location: ${site.location.latitude}, ${site.location.longitude}'),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'TuristAPP',
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: currentPosition ?? const LatLng(-31.417, -64.183),
          initialZoom: 13.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: const ['a', 'b', 'c'],
          ),
          SuperclusterLayer.immutable(
            initialMarkers: markers,
            indexBuilder: IndexBuilders.computeWithOriginalMarkers,
            clusterWidgetSize: const Size(40, 40),
            builder: (context, position, markerCount, extraClusterData) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.blue,
                ),
                child: Center(
                  child: Text(
                    markerCount.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              );
            },
          ),
          FlutterMapZoomButtons(
            mapController: _mapController,
            alignment: Alignment.topRight,
          )
        ],
      ),
    );
  }
}
