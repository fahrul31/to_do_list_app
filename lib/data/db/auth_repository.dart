import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final String userKey = "user";

  Future<String?> getToken() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(userKey);
  }

  Future<bool> setToken(String token) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.setString(userKey, token);
  }
}
