import 'package:equatable/equatable.dart';
import '../model/login_model.dart';

/// Base class for all login-related states.
abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

/// Default initial state before any action.
class LoginInitial extends LoginState {
  const LoginInitial();
}

/// State while credentials are being validated.
class LoginLoading extends LoginState {
  const LoginLoading();
}

/// State when login is successful.
class LoginSuccess extends LoginState {
  /// The authenticated user model.
  final LoginModel user;

  const LoginSuccess(this.user);

  @override
  List<Object?> get props => [user.email, user.role];
}

/// State when login fails (invalid credentials).
class LoginFailure extends LoginState {
  /// Error message to display.
  final String message;

  const LoginFailure(this.message);

  @override
  List<Object?> get props => [message];
}

/// State when an existing session is restored on app start.
class LoginSessionRestored extends LoginState {
  /// The restored user model.
  final LoginModel user;

  const LoginSessionRestored(this.user);

  @override
  List<Object?> get props => [user.email, user.role];
}

/// State after successful logout.
class LoginLoggedOut extends LoginState {
  const LoginLoggedOut();
}
