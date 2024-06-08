import 'package:flutter/material.dart';
import 'package:flutter_map_supercluster/flutter_map_supercluster.dart';
import 'package:geolocator/geolocator.dart';
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

void _showMarkerInfo(BuildContext context, TouristSite site) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(site.name),
        content: Text(
            'Location: ${site.location.latitude}, ${site.location.longitude}'),
        actions: <Widget>[
          TextButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Marker _createMarker(BuildContext context, TouristSite site) {
  return Marker(
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
  );
}

List<Marker> _createMarkers(BuildContext context) {
  return touristSites.map((site) => _createMarker(context, site)).toList();
}

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  MapPageState createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  List<Marker> markers = [];
  LatLng? currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    markers = _createMarkers(context);
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, don't continue
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, don't continue
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentPosition = LatLng(position.latitude, position.longitude);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'TuristAPP'),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: currentPosition ?? const LatLng(48.8584, 2.2945),
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
        ],
      ),
    );
  }
}
