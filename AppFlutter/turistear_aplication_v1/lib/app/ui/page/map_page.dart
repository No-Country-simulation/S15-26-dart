import 'package:flutter/material.dart';
import 'package:flutter_map_supercluster/flutter_map_supercluster.dart';
import 'package:provider/provider.dart';
import 'package:turistear_aplication_v1/app/api/overpass_api_service.dart';
import 'package:turistear_aplication_v1/app/provider/favorites_provider.dart';
import 'package:turistear_aplication_v1/app/services/location_service.dart';
import 'package:turistear_aplication_v1/app/ui/components/custom_app_bar.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:turistear_aplication_v1/app/ui/components/itinerary_modal.dart';
import 'package:turistear_aplication_v1/app/ui/components/widgetmap/flutter_map_zoom_buttons.dart';
import 'package:turistear_aplication_v1/app/data/model/favorites_sites.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  MapPageState createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  late final SuperclusterMutableController _superclusterController;
  LatLng? currentPosition;
  final MapController _mapController = MapController();
  final OverpassApiService _overpassApiService = OverpassApiService();
  List<FavoritesSites> _touristSites = [];
  List<String> categories = ['Todas']; // Lista de categorías
  String selectedCategory = 'Todas'; // Categoría seleccionada por defecto

  @override
  void initState() {
    super.initState();
    _superclusterController = SuperclusterMutableController();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    LocationService locationService = LocationService();
    LatLng? position = await locationService.getCurrentLocation();
    if (position != null) {
      setState(() {
        currentPosition = position;
        _moveToCurrentLocation();
        _fetchTouristSites(_mapController.camera.visibleBounds.southWest,
            _mapController.camera.visibleBounds.northEast);
      });
    }
  }

  void _updateCategories() {
    final siteCategories =
        _touristSites.map((site) => site.category).toSet().toList();
    setState(() {
      categories = ['Todas', ...siteCategories];
    });
  }

  void _fetchTouristSites(LatLng southwest, LatLng northeast) async {
    try {
      List<FavoritesSites> sites = await _overpassApiService
          .fetchTouristSitesByBoundingBox(southwest, northeast);
      setState(() {
        _touristSites = sites;
        _updateCategories(); // Actualizar las categorías disponibles
        _updateMarkers();
      });
    } catch (e) {
      // Manejo de errores
    }
  }

  void _updateMarkers() {
    final markers = <Marker>[];

    if (currentPosition != null) {
      markers.add(
        Marker(
          point: currentPosition!,
          width: 80,
          height: 80,
          child: GestureDetector(
            onTap: () => _showMarkerInfo(
                context,
                FavoritesSites(
                  id: 0,
                  latitude: currentPosition!.latitude,
                  longitude: currentPosition!.longitude,
                  name: 'Current Location',
                  category: 'Current Location',
                )),
            child: const Icon(
              Icons.my_location,
              color: Colors.blue,
              size: 40,
            ),
          ),
        ),
      );
    }

    for (var site in _touristSites) {
      markers.add(
        Marker(
          point: LatLng(site.latitude, site.longitude),
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
        ),
      );
    }

    _superclusterController.replaceAll(markers);
  }

  void _moveToCurrentLocation() {
    if (currentPosition != null) {
      _mapController.move(currentPosition!, 15.0);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Current location not available'),
        ),
      );
    }
  }

  void _onSearchAreaPressed() {
    var bounds = _mapController.camera.visibleBounds;
    LatLng southwest = bounds.southWest;
    LatLng northeast = bounds.northEast;
    _fetchTouristSites(southwest, northeast);
  }

  void _showMarkerInfo(BuildContext context, FavoritesSites site) {
    final favoritesProvider =
        Provider.of<FavoritesProvider>(context, listen: false);
    bool isFavorite = favoritesProvider.isFavorite(site);
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(site.name),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Category: ${site.category}'),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: isFavorite
                        ? const Icon(Icons.favorite, color: Colors.red)
                        : const Icon(Icons.favorite_border),
                    onPressed: () {
                      if (isFavorite) {
                        favoritesProvider.removeFavorite(site);
                      } else {
                        favoritesProvider.addFavorite(site);
                      }
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _showItineraryDialog(site); // Mostrar diálogo
                    },
                    child: Text(
                      'Agregar Itinerario',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cerrar',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 12,
                      color: Colors.red,
                    ),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showItineraryDialog(FavoritesSites site) {
    ItineraryModal.show(context, site);
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
          initialZoom: 18.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: const ['a', 'b', 'c'],
          ),
          SuperclusterLayer.mutable(
            controller: _superclusterController,
            indexBuilder: IndexBuilders.computeWithOriginalMarkers,
            clusterWidgetSize: const Size(40, 40),
            calculateAggregatedClusterData: true,
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
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: _moveToCurrentLocation,
            child: const Icon(Icons.my_location),
          ),
          const SizedBox(height: 12),
          FloatingActionButton.extended(
            onPressed: _onSearchAreaPressed,
            icon: const Icon(Icons.search),
            label: const Text('Buscar en esta Area'),
          ),
        ],
      ),
    );
  }
}
