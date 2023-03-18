import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/auth_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepositoryImpl authRepo;

  AuthBloc({required this.authRepo}) : super(AuthUnauthenticated()) {
    on<AuthSignUp>(_onSignUp);
    on<AuthSignIn>(_onSignIn);
    on<AuthSignOut>(_onSignOut);
    on<AuthGoogleSignIn>(_onGoogleSignIn);
  }

  void _onSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      await authRepo.signUp(email: event.email, password: event.password);
      emit(AuthAuthenticated());
    } catch (e) {
      emit(AuthError(error: e.toString()));
      emit(AuthUnauthenticated());
    }
  }

  void _onSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      await authRepo.signIn(email: event.email, password: event.password);
      emit(AuthAuthenticated());
    } catch (e) {
      emit(AuthError(error: e.toString()));
      emit(AuthUnauthenticated());
    }
  }

  void _onSignOut(AuthSignOut event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await authRepo.signOut();
    emit(AuthAuthenticated());
  }

  void _onGoogleSignIn(AuthGoogleSignIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      await authRepo.signInWithGoogle();
      emit(AuthAuthenticated());
    } catch (e) {
      emit(AuthError(error: e.toString()));
      emit(AuthUnauthenticated());
    }
  }
}
