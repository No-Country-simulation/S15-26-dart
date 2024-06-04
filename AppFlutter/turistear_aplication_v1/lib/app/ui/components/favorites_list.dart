import 'package:flutter/material.dart';
import 'package:turistear_aplication_v1/app/data/model/favorites_sites.dart';

class FavoritesList extends StatelessWidget {
  FavoritesSites favorites;
  FavoritesList(this.favorites, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(favorites.turisticName),
      subtitle: Text(favorites.description),
    );
  }
}
