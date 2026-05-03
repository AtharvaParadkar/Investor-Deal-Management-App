import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/login_model.dart';

/// Repository for authentication operations.
/// Uses hardcoded credentials and SharedPreferences for session persistence.
class LoginRepository {
  /// SharedPreferences key for storing session data.
  static const String _sessionKey = 'user_session';

  /// Hardcoded valid credentials for demo purposes.
  static const Map<String, Map<String, String>> _validCredentials = {
    'investor@dealflow.com': {
      'password': 'password123',
      'role': 'investor',
    },
    'admin@dealflow.com': {
      'password': 'admin456',
      'role': 'admin',
    },
  };

  /// Attempts to authenticate with the given [email] and [password].
  /// Returns a [LoginModel] on success, null on failure.
  Future<LoginModel?> login(String email, String password) async {
    // Simulate network latency
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

  /// Persists the user session to local storage.
  Future<void> saveSession(LoginModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_sessionKey, jsonEncode(user.toJson()));
  }

  /// Retrieves the stored user session, if any.
  Future<LoginModel?> getSession() async {
    final prefs = await SharedPreferences.getInstance();
    final sessionJson = prefs.getString(_sessionKey);
    if (sessionJson != null) {
      final map = jsonDecode(sessionJson) as Map<String, dynamic>;
      return LoginModel.fromJson(map);
    }
    return null;
  }

  /// Clears the stored session (logout).
  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_sessionKey);
  }
}
