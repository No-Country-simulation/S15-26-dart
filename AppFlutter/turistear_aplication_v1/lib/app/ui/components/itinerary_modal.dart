import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:turistear_aplication_v1/app/data/model/favorites_sites.dart';
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
                // Lógica para agregar al itinerario existente
                if (kDebugMode) {
                  print('Agregar a itinerario: ${site.name}');
                }
                Navigator.of(context).pop(); // Cerrar el bottom sheet
              },
            ),
            ListTile(
              leading: const Icon(Icons.create_new_folder),
              title: const Text('Nuevo Itinerario'),
              onTap: () {
                Navigator.of(context).pop(); // Cerrar el bottom sheet
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NewItineraryPage(
                      site: site,
                    ),
                  ),
                );
                if (kDebugMode) {
                  print('Nuevo itinerario: ${site.name}');
                }
              },
            ),
          ],
        );
      },
    );
  }
}
