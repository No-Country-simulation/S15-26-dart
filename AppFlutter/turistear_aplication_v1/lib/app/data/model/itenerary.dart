import 'package:turistear_aplication_v1/app/data/model/favorites_sites.dart';

class Itinerary {
  int? itineraryId; // Hacerlo opcional
  String itineraryName;
  List<FavoritesSites> favoriteSites;

  Itinerary(this.itineraryName, this.favoriteSites, {this.itineraryId});

  factory Itinerary.fromJson(Map<String, dynamic> json) => Itinerary(
        json["Name_Itinerarys"],
        (json["FavoriteSites"] as List)
            .map((site) => FavoritesSites.fromJson(site))
            .toList(),
        itineraryId: json["Id_Itinerarys"] != null
            ? int.parse(json["Id_Itinerarys"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'Id_Itinerarys': itineraryId
            ?.toString(), // Guarda el ID como String en SharedPreferences
        'Name_Itinerarys': itineraryName,
        'FavoriteSites': favoriteSites.map((site) => site.toJson()).toList(),
      };
}
