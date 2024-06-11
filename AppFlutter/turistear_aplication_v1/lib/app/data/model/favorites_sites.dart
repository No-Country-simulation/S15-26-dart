class FavoritesSites {
  final int id;
  final double latitude;
  final double longitude;
  final String name;
  final String category;

  FavoritesSites({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.category,
  });

  factory FavoritesSites.fromJson(Map<String, dynamic> json) {
    return FavoritesSites(
      id: json['id'],
      latitude: json['lat'],
      longitude: json['lon'],
      name: json['tags']['name'] ?? 'Unnamed',
      category: json['tags']['tourism'] ?? 'Unknown',
    );
  }

  Map<String, dynamic> toJson() => {
        'Id_TuristSites':
            id.toString(), // Guarda el ID como String en SharedPreferences
        'Name_TuristSites': name,
        'Latitude_TuristSites': latitude,
        'Longitude_TuristSites': longitude,
        'Category': category,
      };
}
