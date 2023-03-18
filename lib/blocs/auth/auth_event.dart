part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthSignUp extends AuthEvent {
  final String email;
  final String password;

  const AuthSignUp({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class AuthSignIn extends AuthEvent {
  final String email;
  final String password;

  const AuthSignIn({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class AuthGoogleSignIn extends AuthEvent {}

class AuthSignOut extends AuthEvent {}
