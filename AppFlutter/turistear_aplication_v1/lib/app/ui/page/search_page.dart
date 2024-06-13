import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:turistear_aplication_v1/app/api/overpass_api_service.dart';
import 'package:turistear_aplication_v1/app/provider/favorites_provider.dart';
import 'package:turistear_aplication_v1/app/services/location_service.dart';
import 'package:turistear_aplication_v1/app/data/model/favorites_sites.dart';
import 'package:turistear_aplication_v1/app/ui/components/itinerary_modal.dart';
import 'package:provider/provider.dart';

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
  int selectedIndex = 0; // Índice del botón seleccionado
  List<String> categories = ['Todas']; // Incluir 'Todas' por defecto
  String selectedCategory = 'Todas';

  @override
  void initState() {
    super.initState();
    _searchNearby('');
  }

  void _updateCategories() {
    final siteCategories =
        allSites.map((site) => site.category).toSet().toList();
    setState(() {
      categories = ['Todas', ...siteCategories];
    });
  }

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
        _updateCategories(); // Actualizar las categorías disponibles
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
    List<FavoritesSites> filteredSites = allSites.where((site) {
      final matchesQuery =
          site.name.toLowerCase().contains(query.toLowerCase());
      final matchesCategory =
          selectedCategory == 'Todas' || site.category == selectedCategory;
      return matchesQuery && matchesCategory;
    }).toList();

    setState(() {
      searchResults = filteredSites;
    });
  }

  Widget _buildSearchResult(FavoritesSites site) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    bool isFavorite = favoritesProvider.isFavorite(site);

    return Card(
      child: ListTile(
        title: Text(site.name),
        subtitle: Text(site.category),
        leading: const Icon(Icons.location_on),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
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
    final ButtonStyle inactiveButtonStyle = ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.primary,
      side: BorderSide(
        color: Theme.of(context).colorScheme.tertiary,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
    final ButtonStyle activeButtonStyle = ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.secondary,
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
                      selectedIndex = 0;
                    });
                    _searchNearby(searchController.text);
                  },
                  style: selectedIndex == 0
                      ? activeButtonStyle
                      : inactiveButtonStyle,
                  child: Text(
                    '5 km',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: selectedIndex == 0
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.tertiary,
                        ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      searchRadius = 10.0;
                      selectedIndex = 1;
                    });
                    _searchNearby(searchController.text);
                  },
                  style: selectedIndex == 1
                      ? activeButtonStyle
                      : inactiveButtonStyle,
                  child: Text(
                    '10 km',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: selectedIndex == 1
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.tertiary,
                        ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      searchRadius = 15.0;
                      selectedIndex = 2;
                    });
                    _searchNearby(searchController.text);
                  },
                  style: selectedIndex == 2
                      ? activeButtonStyle
                      : inactiveButtonStyle,
                  child: Text(
                    '15 km',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: selectedIndex == 2
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.tertiary,
                        ),
                  ),
                ),
                DropdownButton<String>(
                  value: selectedCategory,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCategory = newValue!;
                      _filterResults(searchController.text);
                    });
                  },
                  items: categories
                      .map<DropdownMenuItem<String>>((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                  dropdownColor: Theme.of(context).colorScheme.primary,
                  underline: Container(
                    height: 2,
                    color: Theme.of(context).colorScheme.tertiary,
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
