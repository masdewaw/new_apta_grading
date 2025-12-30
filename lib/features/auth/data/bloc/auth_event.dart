part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

/// Event when user requests to login
final class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;

  AuthLoginRequested({required this.email, required this.password});
}

/// Event when user requests to logout
final class AuthLogoutRequested extends AuthEvent {}
