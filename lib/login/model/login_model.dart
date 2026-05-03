class LoginModel {
  final String email;
  final String role;

  const LoginModel({required this.email, required this.role});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      email: json['email'] as String,
      role: json['role'] as String,
    );
  }

  Map<String, dynamic> toJson() => {'email': email, 'role': role};
}
