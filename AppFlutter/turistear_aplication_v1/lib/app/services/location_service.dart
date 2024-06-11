import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<LatLng?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verificar si el servicio de localización está habilitado.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // El servicio de localización no está habilitado.
      return null;
    }

    // Verificar el permiso de localización.
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Solicitar permiso de localización.
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // El permiso de localización fue denegado.
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // El permiso de localización fue denegado permanentemente.
      return null;
    }

    // Obtener la posición actual del dispositivo.
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Devolver la posición actual como un objeto LatLng.
    return LatLng(position.latitude, position.longitude);
  }
}
