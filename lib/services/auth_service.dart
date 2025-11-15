import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _userKey = 'app_username';
  static const String _passKey = 'app_password';

  Future<bool> isUserRegistered() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_userKey);
  }

  Future<void> registerUser(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, username);
    await prefs.setString(_passKey, password);
  }

  Future<bool> login(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final storedUser = prefs.getString(_userKey);
    final storedPass = prefs.getString(_passKey);

    return storedUser == username && storedPass == password;
  }
}