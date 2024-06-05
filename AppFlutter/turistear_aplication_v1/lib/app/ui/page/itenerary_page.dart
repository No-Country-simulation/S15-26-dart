import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turistear_aplication_v1/app/api_connection/dio_instance.dart';
import 'package:turistear_aplication_v1/app/data/model/itenerary.dart';
import 'package:turistear_aplication_v1/app/mock/list_favorites_sites.dart';
import 'package:turistear_aplication_v1/app/ui/components/custom_app_bar.dart';
import 'package:turistear_aplication_v1/app/ui/components/favorites_list.dart';
import 'package:turistear_aplication_v1/app/ui/components/form_nombre.dart';

class ItineraryPage extends StatelessWidget {
  const ItineraryPage({super.key});

  Future<void> saveItinerary(String name, String description) async {
    final Itinerary itinerary = Itinerary(name, favorites);

    final response = await DioInstance.post(
      'https://your-api-endpoint.com/itineraries',
      data: json.encode(itinerary.toJson()),
    );

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('Itinerario guardado correctamente');
      }
    } else {
      if (kDebugMode) {
        print('Error al guardar el itinerario: ${response.data}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'TuristAPP'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Align(
                alignment: Alignment
                    .center, // Asegura que el texto esté alineado a la izquierda
                child: Text(
                  'Crea Nuevo Itinerario',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize:
                            24.sp, // Usa ScreenUtil para el tamaño del texto
                      ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.yellow, width: 2),
                    borderRadius: BorderRadius.circular(20)),
                child: const ExpansionTile(
                  title: Text("3 sitios agregados"),
                  children: <Widget>[
                    // Definir una altura máxima para el contenedor desplazable
                    SizedBox(
                      height: 200, // Ajusta la altura según sea necesario
                      child: SingleChildScrollView(
                        child: ItineraryList(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).colorScheme.tertiary,
                        width: 2),
                    borderRadius: BorderRadius.circular(8)),
                width: MediaQuery.of(context).size.width,
                child: FormNombre(
                  onSave: (name) {
                    saveItinerary(name,
                        'Descripción del itinerario'); // Puedes ajustar la descripción según sea necesario
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItineraryList extends StatelessWidget {
  const ItineraryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        return FavoritesList(favorites[index]);
      },
    );
  }
}
