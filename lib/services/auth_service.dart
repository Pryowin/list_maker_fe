import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static late final SharedPreferences _prefs;

  Future<void> loginUser(String userName) async {
    try {
      _prefs.setString('userName', userName);
    } on Exception catch (e) {
      if (kDebugMode) {
        debugPrint(e.toString());
      }
    }
  }

  bool isUserValid() {
    String? userName = _prefs.getString("userName");
    return userName != null;
  }

  void logoutUser() {
    _prefs.clear();
  }

  String? getUserName() {
    return _prefs.getString('userName') ?? 'No current user';
  }
}
