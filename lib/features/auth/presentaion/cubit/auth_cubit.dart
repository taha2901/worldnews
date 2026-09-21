import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worldnews/features/auth/data/auth_repo.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({AuthRepository? authRepository})
      : _authRepository = authRepository ?? AuthRepository(),
        super(const AuthInitial()) {
    _authSubscription = _authRepository.authStateChanges.listen((user) {
      if (isClosed) return;
      emit(user != null ? AuthAuthenticated(user) : const AuthUnauthenticated());
    });

    checkAuth();
  }

  final AuthRepository _authRepository;
  StreamSubscription<User?>? _authSubscription;

  void _safeEmit(AuthState newState) {
    if (!isClosed) {
      emit(newState);
    }
  }

  Future<void> checkAuth() async {
    final user = _authRepository.currentUser;
    _safeEmit(user != null ? AuthAuthenticated(user) : const AuthUnauthenticated());
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());

    try {
      final user = (await _authRepository.signInWithEmailPassword(
        email: email,
        password: password,
      )).user;

      _safeEmit(user != null ? AuthAuthenticated(user) : const AuthUnauthenticated());
    } on FirebaseAuthException catch (error) {
      _safeEmit(AuthFailure(error.message ?? 'Login failed'));
    } catch (error) {
      _safeEmit(AuthFailure(error.toString()));
    }
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());

    try {
      final user = (await _authRepository.registerWithEmailPassword(
        email: email,
        password: password,
      )).user;

      _safeEmit(user != null ? AuthAuthenticated(user) : const AuthUnauthenticated());
    } on FirebaseAuthException catch (error) {
      _safeEmit(AuthFailure(error.message ?? 'Registration failed'));
    } catch (error) {
      _safeEmit(AuthFailure(error.toString()));
    }
  }

  Future<void> logout() async {
    _safeEmit(const AuthLoading());

    try {
      await _authRepository.signOut();
      _safeEmit(const AuthUnauthenticated());
    } catch (error) {
      _safeEmit(AuthFailure(error.toString()));
    }
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}