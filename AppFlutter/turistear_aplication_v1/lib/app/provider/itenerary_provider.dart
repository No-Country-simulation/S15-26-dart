import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:turistear_aplication_v1/app/api/dio_instance.dart';
import 'package:turistear_aplication_v1/app/data/model/itenerary.dart';
import 'package:turistear_aplication_v1/app/data/model/favorites_sites.dart';
import 'package:turistear_aplication_v1/app/mock/list_favorites_sites.dart';

class ItineraryProvider with ChangeNotifier {
  final List<FavoritesSites> _itinerarySites = [];
  List<Itinerary> _itineraries = [];

  List<FavoritesSites> get itinerarySites => _itinerarySites;
  List<Itinerary> get itineraries => _itineraries;

  ItineraryProvider() {
    _loadItineraries(); // Cargar los itinerarios al iniciar el proveedor
    _addMockItineraries(); // Añadir itinerarios de ejemplo
  }

  void addSite(FavoritesSites site) {
    _itinerarySites.add(site);
    notifyListeners();
  }

  void removeSite(FavoritesSites site) {
    _itinerarySites.remove(site);
    notifyListeners();
  }

  void removeSiteFromItinerary(Itinerary itinerary, FavoritesSites site) {
    itinerary.favoriteSites.remove(site);
    notifyListeners();
    _saveItineraries(); // Guardar los cambios en SharedPreferences
  }

  void removeItinerary(Itinerary itinerary) {
    _itineraries.remove(itinerary);
    notifyListeners();
    _saveItineraries(); // Guardar los cambios en SharedPreferences
  }

  Future<void> saveItinerary(String name) async {
    final Itinerary itinerary = Itinerary(name, List.from(_itinerarySites));

    _itineraries.add(itinerary);
    notifyListeners();
    _saveItineraries();

    // Enviar a un endpoint
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

  Future<void> _loadItineraries() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedItineraries = prefs.getStringList('itineraries') ?? [];
    _itineraries = savedItineraries
        .map((itinerary) => Itinerary.fromJson(json.decode(itinerary)))
        .toList();
    notifyListeners();
  }

  Future<void> _saveItineraries() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedItineraries = _itineraries
        .map((itinerary) => json.encode(itinerary.toJson()))
        .toList();
    await prefs.setStringList('itineraries', savedItineraries);
  }

  void _addMockItineraries() {
    _itineraries = [
      Itinerary('Itinerario 1', []),
      Itinerary('Itinerario 2', []),
      Itinerary('Itinerario 3', List.from(favorites)),
    ];
    notifyListeners();
  }
}
