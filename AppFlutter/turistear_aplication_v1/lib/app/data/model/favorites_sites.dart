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
        'id': id,
        'lat': latitude,
        'lon': longitude,
        'tags': {
          'name': name,
          'tourism': category,
        },
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FavoritesSites &&
        other.id == id &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.name == name &&
        other.category == category;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      latitude.hashCode ^
      longitude.hashCode ^
      name.hashCode ^
      category.hashCode;
}
