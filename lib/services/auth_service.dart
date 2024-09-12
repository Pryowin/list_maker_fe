import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static late final SharedPreferences _prefs;

  Future<void> loginUser(
      String userName, String token, String refreshToken) async {
    try {
      _prefs.setString('userName', userName);
      _prefs.setString('token', token);
      _prefs.setString('refreshToken', refreshToken);
    } on Exception catch (e) {
      if (kDebugMode) {
        debugPrint(e.toString());
      }
    }
  }

  Future<bool> isUserLoggedIn() async {
    String? userName = await _prefs.getString("userName");
    return userName != null;
  }

  void logoutUser() {
    _prefs.clear();
  }

  String? getUserName() {
    return _prefs.getString('userName') ?? 'No current user';
  }

  String? getToken() {
    return _prefs.getString('token');
  }

  String? getRefreshToken() {
    return _prefs.getString('refreshToken');
  }
}
