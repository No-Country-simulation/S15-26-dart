import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turistear_aplication_v1/app/data/model/itenerary.dart';
import 'package:turistear_aplication_v1/app/provider/itenerary_provider.dart';

class ItineraryDetailPage extends StatelessWidget {
  final Itinerary itinerary;

  const ItineraryDetailPage({required this.itinerary, super.key});

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
