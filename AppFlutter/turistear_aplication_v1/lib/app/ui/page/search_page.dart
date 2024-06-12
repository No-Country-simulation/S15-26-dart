import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:turistear_aplication_v1/app/api/overpass_api_service.dart';
import 'package:turistear_aplication_v1/app/services/location_service.dart';
import 'package:turistear_aplication_v1/app/data/model/favorites_sites.dart';
import 'package:turistear_aplication_v1/app/ui/components/itinerary_modal.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  double searchRadius = 5.0; // Default search radius
  List<FavoritesSites> searchResults = [];
  List<FavoritesSites> allSites = []; // Lista completa de sitios
  bool isLoading = false;
  String errorMessage = '';

  void _searchNearby(String query) async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    LocationService locationService = LocationService();
    LatLng? currentPosition = await locationService.getCurrentLocation();

    if (currentPosition == null) {
      setState(() {
        isLoading = false;
        errorMessage = 'Current location not available';
      });
      return;
    }

    // Llamar a la API para obtener los sitios turísticos
    OverpassApiService apiService = OverpassApiService();
    try {
      List<FavoritesSites> sites = await apiService.fetchTouristSitesByRadius(
        currentPosition,
        searchRadius,
      );

      setState(() {
        allSites = sites;
        searchResults = sites; // Inicialmente, mostrar todos los resultados
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to fetch tourist sites: $e';
      });
    }
  }

  void _filterResults(String query) {
    if (query.isEmpty) {
      setState(() {
        searchResults =
            allSites; // Mostrar todos los resultados si el campo de búsqueda está vacío
      });
    } else {
      setState(() {
        searchResults = allSites
            .where(
                (site) => site.name.toLowerCase().contains(query.toLowerCase()))
            .toList(); // Filtrar resultados por nombre
      });
    }
  }

  Widget _buildSearchResult(FavoritesSites site) {
    return Card(
      child: ListTile(
        title: Text(site.name),
        subtitle: Text(site.category),
        leading: const Icon(Icons.location_on),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.favorite_border),
              onPressed: () {
                // Lógica para agregar a favoritos
                if (kDebugMode) {
                  print('Agregar a favoritos: ${site.name}');
                }
              },
            ),
            ElevatedButton(
              onPressed: () {
                // Lógica para agregar al itinerario
                _showItineraryDialog(site); // Mostrar diálogo

                if (kDebugMode) {
                  print('Agregar al itinerario: ${site.name}');
                }
              },
              child: Text(
                'Agregar Itinerario',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showItineraryDialog(FavoritesSites site) {
    ItineraryModal.show(context, site);
  }

  @override
  Widget build(BuildContext context) {
    // Define un ButtonStyle común para los botones
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.primary,
      side: BorderSide(
        color: Theme.of(context).colorScheme.tertiary,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Buscar Sitios Turísticos',
            suffixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                _searchNearby(searchController.text);
              },
            ),
          ),
          onChanged: (value) {
            _filterResults(
                value); // Llamar a _filterResults cada vez que el texto cambia
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      searchRadius = 5.0;
                    });
                    _searchNearby(searchController.text);
                  },
                  style: buttonStyle, // Aplica el estilo definido
                  child: Text(
                    '5 km',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                        ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      searchRadius = 10.0;
                    });
                    _searchNearby(searchController.text);
                  },
                  style: buttonStyle, // Aplica el estilo definido
                  child: Text(
                    '10 km',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                        ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      searchRadius = 15.0;
                    });
                    _searchNearby(searchController.text);
                  },
                  style: buttonStyle, // Aplica el estilo definido
                  child: Text(
                    '15 km',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                        ),
                  ),
                ),
              ],
            ),
          ),
          if (isLoading) const Center(child: CircularProgressIndicator()),
          if (errorMessage.isNotEmpty) Center(child: Text(errorMessage)),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                return _buildSearchResult(searchResults[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
