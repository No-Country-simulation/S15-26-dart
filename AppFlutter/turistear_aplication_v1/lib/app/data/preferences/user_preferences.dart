import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turistear_aplication_v1/app/data/model/user.dart';

class RememberUserPrefs {
  //save-remember User-Info
  static Future<void> storeUserInfo(User userInfo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userJsonData = jsonEncode(userInfo.toJson());

    await preferences.setString("currentUser", userJsonData);
  }

  //get-read  User-info
  static Future<User?> readUserInfo() async {
    User? currentUserInfo;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userInfo = preferences.getString("currentUser");
    if (userInfo != null) {
      Map<String, dynamic> userDataMap = jsonDecode(userInfo);
      currentUserInfo = User.fromJson(userDataMap);
    }
    return currentUserInfo;
  }

  static Future<void> removeInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove("currentUser");
    await preferences.remove("token");
  }

  // Save recent searches
  static Future<void> storeRecentSearch(String search) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> recentSearches =
        preferences.getStringList("recentSearches") ?? [];

    if (!recentSearches.contains(search)) {
      recentSearches.add(search);
      await preferences.setStringList("recentSearches", recentSearches);
    }
  }

  // Get recent searches
  static Future<List<String>> getRecentSearches() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getStringList("recentSearches") ?? [];
  }
}
