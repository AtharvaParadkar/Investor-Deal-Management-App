import '../model/login_model.dart';

abstract class LoginState {
  const LoginState();
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginSuccess extends LoginState {
  final LoginModel user;
  const LoginSuccess(this.user);
}

class LoginFailure extends LoginState {
  final String message;
  const LoginFailure(this.message);
}

class LoginSessionRestored extends LoginState {
  final LoginModel user;
  const LoginSessionRestored(this.user);
}

class LoginLoggedOut extends LoginState {
  const LoginLoggedOut();
}
