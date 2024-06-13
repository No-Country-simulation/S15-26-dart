import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:turistear_aplication_v1/app/data/model/favorites_sites.dart';
import 'package:turistear_aplication_v1/app/provider/itenerary_provider.dart';
import 'package:turistear_aplication_v1/app/ui/page/new_itenerary_page.dart';

class ItineraryModal {
  static void show(BuildContext context, FavoritesSites site) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.playlist_add),
              title: const Text('Agregar a Itinerario'),
              onTap: () {
                Navigator.of(context).pop();
                _showExistingItineraries(context, site);
              },
            ),
            ListTile(
              leading: const Icon(Icons.create_new_folder),
              title: const Text('Nuevo Itinerario'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NewItineraryPage(site: site),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  static void _showExistingItineraries(
      BuildContext context, FavoritesSites site) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Consumer<ItineraryProvider>(
          builder: (context, itineraryProvider, child) {
            final itineraries = itineraryProvider.itineraries;
            return Wrap(
              children: [
                const ListTile(
                  title: Text('Tus itinerarios'),
                ),
                for (var itinerary in itineraries)
                  ListTile(
                    title: Text(itinerary.itineraryName),
                    subtitle: Text(
                        '${itinerary.favoriteSites.length} Sitios a Visitar'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        itineraryProvider.addSiteToItinerary(itinerary, site);
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Agregar',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                            ),
                      ),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
