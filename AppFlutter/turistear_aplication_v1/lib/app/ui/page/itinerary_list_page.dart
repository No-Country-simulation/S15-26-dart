import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turistear_aplication_v1/app/data/model/itenerary.dart';
import 'package:turistear_aplication_v1/app/provider/itenerary_provider.dart';
import 'package:turistear_aplication_v1/app/ui/components/custom_app_bar.dart';

class ItineraryListPage extends StatelessWidget {
  const ItineraryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Itinerarios'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<ItineraryProvider>(
          builder: (context, itineraryProvider, child) {
            return ListView.builder(
              itemCount: itineraryProvider.itineraries.length,
              itemBuilder: (context, index) {
                final itinerary = itineraryProvider.itineraries[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.yellow, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    title: Text(itinerary.itineraryName),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
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
            );
          },
        ),
      ),
    );
  }
}

class ItineraryDetailPage extends StatelessWidget {
  final Itinerary itinerary;

  const ItineraryDetailPage({super.key, required this.itinerary});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(itinerary.itineraryName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: itinerary.favoriteSites.length,
          itemBuilder: (context, index) {
            final site = itinerary.favoriteSites[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.yellow, width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                title: Text(site.name),
                subtitle: Text(site.category),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    Provider.of<ItineraryProvider>(context, listen: false)
                        .removeSiteFromItinerary(itinerary, site);
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
