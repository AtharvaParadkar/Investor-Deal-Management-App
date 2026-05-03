/// Model representing an authenticated user session.
/// Stores the user's email and role for authorization logic.
class LoginModel {
  /// The user's email address.
  final String email;

  /// The user's role — either "investor" or "admin".
  final String role;

  /// Creates a [LoginModel] with the given [email] and [role].
  const LoginModel({
    required this.email,
    required this.role,
  });

  /// Creates a [LoginModel] from a JSON map.
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      email: json['email'] as String,
      role: json['role'] as String,
    );
  }

  /// Converts this model to a JSON map for storage.
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'role': role,
    };
  }
}
