import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static const String _isLoggedInKey = 'isLoggedIn';

  // Save login state
  static Future<void> saveLoginState(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, isLoggedIn);
  }

  // Retrieve login state
  static Future<bool> getLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // Clear login state
  static Future<void> clearLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_isLoggedInKey);
  }
}
