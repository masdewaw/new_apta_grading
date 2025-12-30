import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_apta_grading/core/repository/auth_repository.dart';
import 'package:new_apta_grading/core/utils/local_storage.dart';
import 'package:new_apta_grading/features/auth/data/model/login_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final response = await AuthRepository().login(
        LoginInputModel(email: event.email, password: event.password),
      );

      // Save user data to local storage
      await addStringStorage(StorageKey.accessToken, response.token);
      await addStringStorage(StorageKey.name, response.name);
      await addIntStorage(StorageKey.id, response.id);
      await addStringStorage(StorageKey.session, "logged");

      emit(AuthSuccess(user: response));
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      // Clear local storage
      await removeStorage(StorageKey.accessToken);
      await removeStorage(StorageKey.name);
      await removeStorage(StorageKey.id);
      await removeStorage(StorageKey.session);

      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }
}
