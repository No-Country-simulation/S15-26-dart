class FavoritesSites {
  int turisticId;
  String turisticName;
  String description;
  String latitude;
  String longitude;

  FavoritesSites(this.turisticId, this.turisticName, this.description,
      this.latitude, this.longitude);

  factory FavoritesSites.fromJson(Map<String, dynamic> json) => FavoritesSites(
        0,
        json["Name_TuristSites"],
        json["Description_TuristSites"],
        json["Latitude_TuristSites"].toString(),
        json["Longitude_TuristSites"].toString(),
      );

  Map<String, dynamic> toJson() => {
        'Id_TuristSites': turisticId
            .toString(), // Guarda el ID como String en SharedPreferences
        'Name_TuristSites': turisticName,
        'Description_TuristSites': description,
        'Latitude_TuristSites': latitude,
        'Longitude_TuristSites': longitude,
      };
}
