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
    Map<String, dynamic> userDataMap = jsonDecode(userInfo!);
    currentUserInfo = User.fromJson(userDataMap);
    return currentUserInfo;
  }

  static Future<void> removeInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove("currentUser");
    await preferences.remove("token");
  }
}
