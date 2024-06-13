import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:turistear_aplication_v1/app/data/model/favorites_sites.dart';

class FavoritesProvider with ChangeNotifier {
  final List<FavoritesSites> _favoriteSites = [];
  static const String _key = 'favorite_sites';

  List<FavoritesSites> get favoriteSites => _favoriteSites;

  FavoritesProvider() {
    _loadFavorites(); // Cargar favoritos al iniciar el proveedor
  }

  void addFavorite(FavoritesSites site) {
    _favoriteSites.add(site);
    _saveFavorites();
    notifyListeners();
  }

  void removeFavorite(FavoritesSites site) {
    _favoriteSites.remove(site);
    _saveFavorites();
    notifyListeners();
  }

  bool isFavorite(FavoritesSites site) {
    return _favoriteSites.contains(site);
  }

  Future<void> _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoriteSitesString = prefs.getStringList(_key);

    if (favoriteSitesString != null) {
      _favoriteSites.clear();
      _favoriteSites.addAll(
        favoriteSitesString
            .map((site) => FavoritesSites.fromJson(json.decode(site)))
            .toList(),
      );
      notifyListeners();
    }
  }

  Future<void> _saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteSitesString =
        _favoriteSites.map((site) => json.encode(site.toJson())).toList();
    await prefs.setStringList(_key, favoriteSitesString);
  }
}
