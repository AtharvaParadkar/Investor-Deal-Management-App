import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/app_strings.dart';
import '../repository/login_repository.dart';
import 'login_event.dart';
import 'login_state.dart';

/// BLoC for managing authentication state.
/// Handles login submission, session checking, and logout.
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  /// The login repository for authentication operations.
  final LoginRepository _loginRepository;

  /// Creates a [LoginBloc] with the given [loginRepository].
  LoginBloc({required LoginRepository loginRepository})
      : _loginRepository = loginRepository,
        super(const LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<LogoutRequested>(_onLogoutRequested);
    on<SessionChecked>(_onSessionChecked);
  }

  /// Handles login form submission.
  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginLoading());

    try {
      final user = await _loginRepository.login(event.email, event.password);
      if (user != null) {
        await _loginRepository.saveSession(user);
        emit(LoginSuccess(user));
      } else {
        emit(const LoginFailure(AppStrings.invalidCredentials));
      }
    } catch (e) {
      emit(LoginFailure('An error occurred: ${e.toString()}'));
    }
  }

  /// Handles logout request.
  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<LoginState> emit,
  ) async {
    await _loginRepository.clearSession();
    emit(const LoginLoggedOut());
  }

  /// Checks for an existing session on app start.
  Future<void> _onSessionChecked(
    SessionChecked event,
    Emitter<LoginState> emit,
  ) async {
    try {
      final user = await _loginRepository.getSession();
      if (user != null) {
        emit(LoginSessionRestored(user));
      } else {
        emit(const LoginInitial());
      }
    } catch (e) {
      emit(const LoginInitial());
    }
  }
}
