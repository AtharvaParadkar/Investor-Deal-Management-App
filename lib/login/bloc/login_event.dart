import 'package:equatable/equatable.dart';

/// Base class for all login-related events.
abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

/// Triggered when the user submits the login form.
class LoginSubmitted extends LoginEvent {
  /// The entered email address.
  final String email;

  /// The entered password.
  final String password;

  const LoginSubmitted({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

/// Triggered when the user requests to logout.
class LogoutRequested extends LoginEvent {
  const LogoutRequested();
}

/// Triggered on app start to check for an existing session.
class SessionChecked extends LoginEvent {
  const SessionChecked();
}
