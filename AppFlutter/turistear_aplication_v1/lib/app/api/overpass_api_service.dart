import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:latlong2/latlong.dart';
import 'package:turistear_aplication_v1/app/api/dio_instance.dart';
import 'package:turistear_aplication_v1/app/data/model/favorites_sites.dart';
import 'package:turistear_aplication_v1/utils/calculate_bbox.dart';

class OverpassApiService {
  Future<List<FavoritesSites>> fetchTouristSites(
    String query,
    LatLng currentPosition,
    double radiusKm,
  ) async {
    final bbox = calculateBbox(currentPosition, radiusKm);
    final queryOverPass = """
      [out:json][timeout:25];
      (
        node["tourism"](${bbox.southwest.latitude},${bbox.southwest.longitude},${bbox.northeast.latitude},${bbox.northeast.longitude});
      );
      out center;
    """;

    try {
      final response = await DioInstance.post(
        "https://overpass-api.de/api/interpreter",
        data: {"data": queryOverPass},
      );

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }

        List<FavoritesSites> sites = [];

        if (response.data['elements'] != null &&
            response.data['elements'] is List) {
          for (var element in response.data['elements']) {
            sites.add(FavoritesSites.fromJson(element));
          }
        }

        return sites;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching tourist sites: $e');
      throw e;
    }
  }
}
