import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/app_strings.dart';
import '../repository/login_repository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _loginRepository;

  LoginBloc({required LoginRepository loginRepository})
      : _loginRepository = loginRepository,
        super(const LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<LogoutRequested>(_onLogoutRequested);
    on<SessionChecked>(_onSessionChecked);
  }

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

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<LoginState> emit,
  ) async {
    await _loginRepository.clearSession();
    emit(const LoginLoggedOut());
  }

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
