import 'package:turistear_aplication_v1/app/data/model/itenerary.dart';

class API {
  //localhost:3001
  static const hostConnect = "localhost:3001/v1";

  // User
  // static const user = '$hostConnect/user';
  // static const signUp = '$user/signup';
  // static const validateEmail = '$user/validateEmail';
  // static const login = '$user/login';
  // static const results = '$user/';
  // static const updatePass = '$user/updatePassword';
  // static const validateOldPass = '$user/validateOldPass';

  //Itenerary
  static const itinerary = '$hostConnect/itinerary';
  static const registerItenerary = '$itinerary/createItinerary';
}
