import 'package:shared_preferences/shared_preferences.dart';

class RememberTokenPrefs {
  //save-remember User-Info
  static Future<void> storeTokenInfo(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('token', token);
  }

  //get-read  token-info
  static Future<String?> readTokenInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("token");
  }

  static Future<bool> isUserLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // Verifica si el usuario está autenticado utilizando tus criterios
    // Por ejemplo, puedes comprobar si existe un token, etc.
    // Retorna true si el usuario está autenticado, false de lo contrario.
    return preferences.getString('token') != null;
  }
}
