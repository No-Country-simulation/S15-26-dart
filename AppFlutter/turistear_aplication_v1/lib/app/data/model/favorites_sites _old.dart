class FavoritesSitesOld {
  int turisticId;
  String turisticName;
  String description;
  String category;
  String latitude;
  String longitude;

  FavoritesSitesOld(this.turisticId, this.turisticName, this.description,
      this.category, this.latitude, this.longitude);

  factory FavoritesSitesOld.fromJson(Map<String, dynamic> json) =>
      FavoritesSitesOld(
        0,
        json["Name_TuristSites"],
        json["Description_TuristSites"],
        json["Category_TuristSites"],
        json["Latitude_TuristSites"].toString(),
        json["Longitude_TuristSites"].toString(),
      );

  Map<String, dynamic> toJson() => {
        'Id_TuristSites': turisticId
            .toString(), // Guarda el ID como String en SharedPreferences
        'Name_TuristSites': turisticName,
        'Description_TuristSites': description,
        'Category_TuristSites': category,
        'Latitude_TuristSites': latitude,
        'Longitude_TuristSites': longitude,
      };
}
