import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:turistear_aplication_v1/app/data/model/favorites_sites.dart';
import 'package:turistear_aplication_v1/app/provider/itenerary_provider.dart';
import 'package:turistear_aplication_v1/app/ui/components/custom_app_bar.dart';
import 'package:turistear_aplication_v1/app/ui/components/form_nombre.dart';

class NewItineraryPage extends StatefulWidget {
  final FavoritesSites site;

  const NewItineraryPage({required this.site, super.key});

  @override
  NewItineraryPageState createState() => NewItineraryPageState();
}

class NewItineraryPageState extends State<NewItineraryPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final itineraryProvider =
          Provider.of<ItineraryProvider>(context, listen: false);
      itineraryProvider.addSite(widget.site);
    });
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
                alignment: Alignment.center,
                child: Text(
                  'Crea Nuevo Itinerario',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 24.sp,
                      ),
                ),
              ),
              const SizedBox(height: 16),
              Consumer<ItineraryProvider>(
                builder: (context, itineraryProvider, child) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.yellow, width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ExpansionTile(
                      title: Text(
                          "${itineraryProvider.itinerarySites.length} sitios agregados"),
                      children: itineraryProvider.itinerarySites.map((site) {
                        return ListTile(
                          title: Text(site.name),
                          subtitle: Text(site.category),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              itineraryProvider.removeSite(site);
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.tertiary,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                width: MediaQuery.of(context).size.width,
                child: FormNombre(
                  onSave: (name) {
                    final itineraryProvider =
                        Provider.of<ItineraryProvider>(context, listen: false);
                    itineraryProvider.saveItinerary(name);
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
