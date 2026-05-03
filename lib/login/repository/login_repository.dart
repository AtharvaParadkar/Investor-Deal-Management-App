import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/login_model.dart';

/// Handles authentication using hardcoded credentials and SharedPreferences for session.
class LoginRepository {
  static const String _sessionKey = 'user_session';

  static const Map<String, Map<String, String>> _validCredentials = {
    'investor@dealflow.com': {'password': 'password123', 'role': 'investor'},
    'admin@dealflow.com': {'password': 'admin456', 'role': 'admin'},
  };

  Future<LoginModel?> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 1200));
    final credentials = _validCredentials[email.trim().toLowerCase()];
    if (credentials != null && credentials['password'] == password) {
      return LoginModel(
        email: email.trim().toLowerCase(),
        role: credentials['role']!,
      );
    }
    return null;
  }

  Future<void> saveSession(LoginModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_sessionKey, jsonEncode(user.toJson()));
  }

  Future<LoginModel?> getSession() async {
    final prefs = await SharedPreferences.getInstance();
    final sessionJson = prefs.getString(_sessionKey);
    if (sessionJson != null) {
      return LoginModel.fromJson(jsonDecode(sessionJson));
    }
    return null;
  }

  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_sessionKey);
  }
}
