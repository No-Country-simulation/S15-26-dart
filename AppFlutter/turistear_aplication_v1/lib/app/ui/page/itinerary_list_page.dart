import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turistear_aplication_v1/app/provider/favorites_provider.dart';
import 'package:turistear_aplication_v1/app/provider/itenerary_provider.dart';
import 'package:turistear_aplication_v1/app/ui/page/itenerary_detail_page.dart';

class ItineraryListPage extends StatefulWidget {
  const ItineraryListPage({super.key});

  @override
  ItineraryListPageState createState() => ItineraryListPageState();
}

class ItineraryListPageState extends State<ItineraryListPage> {
  int _selectedIndex = 0; // Inicialmente en "Favoritos"

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis sitios'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Center(
              child: ToggleButtons(
                isSelected: [_selectedIndex == 0, _selectedIndex == 1],
                onPressed: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                borderRadius: BorderRadius.circular(8.0),
                selectedColor: Colors.white,
                fillColor: Colors.teal,
                color: Colors.black,
                constraints: const BoxConstraints(
                  minHeight: 40.0,
                  minWidth: 100.0,
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Favoritos',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 14.0,
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Itinerarios',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 14.0,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _selectedIndex == 0 ? _buildFavoritesList() : _buildItineraryList(),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoritesList() {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final favoriteSites = favoritesProvider.favoriteSites;

    return Expanded(
      child: ListView.builder(
        itemCount: favoriteSites.length,
        itemBuilder: (context, index) {
          final site = favoriteSites[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.yellow, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              title: Text(
                site.name,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 14.0,
                    ),
              ),
              subtitle: Row(
                children: [
                  const Icon(Icons.place, color: Colors.teal),
                  const SizedBox(width: 8),
                  Text(
                    site.category,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 14.0,
                        ),
                  ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  favoritesProvider.removeFavorite(site);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildItineraryList() {
    return Consumer<ItineraryProvider>(
      builder: (context, itineraryProvider, child) {
        return Expanded(
          child: ListView.builder(
            itemCount: itineraryProvider.itineraries.length,
            itemBuilder: (context, index) {
              final itinerary = itineraryProvider.itineraries[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.yellow, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text(
                    itinerary.itineraryName,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 14.0,
                        ),
                  ),
                  subtitle: Row(
                    children: [
                      const Icon(Icons.place, color: Colors.teal),
                      const SizedBox(width: 8),
                      Text(
                        '${itinerary.favoriteSites.length} Sitios a Visitar',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontSize: 14.0,
                            ),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      itineraryProvider.removeItinerary(itinerary);
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItineraryDetailPage(
                          itinerary: itinerary,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
