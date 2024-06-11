import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:turistear_aplication_v1/app/api/overpass_api_service.dart';
import 'package:turistear_aplication_v1/app/services/location_service.dart';
import 'package:turistear_aplication_v1/app/data/model/favorites_sites.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  double searchRadius = 5.0; // Default search radius
  List<FavoritesSites> searchResults = [];

  void _searchNearby(String query) async {
    LocationService locationService = LocationService();
    LatLng? currentPosition = await locationService.getCurrentLocation();

    if (currentPosition == null) {
      // Manejar el error cuando la ubicación no está disponible
      return;
    }

    // Llamar a la API para obtener los sitios turísticos
    OverpassApiService apiService = OverpassApiService();
    List<FavoritesSites> sites = await apiService.fetchTouristSites(
      query,
      currentPosition,
      searchRadius,
    );

    setState(() {
      searchResults = sites;
    });
  }

  Widget _buildSearchResult(FavoritesSites site) {
    return Card(
      child: ListTile(
        title: Text(site.name),
        subtitle: Text(site.category),
        leading: Icon(Icons.location_on),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () {
                // Lógica para agregar a favoritos
                print('Agregar a favoritos: ${site.name}');
              },
            ),
            ElevatedButton(
              onPressed: () {
                // Lógica para agregar al itinerario
                print('Agregar al itinerario: ${site.name}');
              },
              child: Text('Agregar Itinerario'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Buscar Sitios Turísticos',
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                _searchNearby(searchController.text);
              },
            ),
          ),
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
                  child: Text('5 km'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      searchRadius = 10.0;
                    });
                    _searchNearby(searchController.text);
                  },
                  child: Text('10 km'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      searchRadius = 15.0;
                    });
                    _searchNearby(searchController.text);
                  },
                  child: Text('15 km'),
                ),
              ],
            ),
          ),
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
