part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

/// Initial state before any authentication action
final class AuthInitial extends AuthState {}

/// Loading state during authentication process
final class AuthLoading extends AuthState {}

/// Success state after successful authentication
final class AuthSuccess extends AuthState {
  final LoginResponseModel user;

  AuthSuccess({required this.user});
}

/// Failure state when authentication fails
final class AuthFailure extends AuthState {
  final String message;

  AuthFailure({required this.message});
}
