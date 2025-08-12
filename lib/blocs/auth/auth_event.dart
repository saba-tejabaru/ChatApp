part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthCheckRequested extends AuthEvent {}

class AuthLoggedIn extends AuthEvent {
  final String email;
  final String password;
  final String role;

  AuthLoggedIn({required this.email, required this.password, required this.role});

  @override
  List<Object?> get props => [email, password, role];
}

class AuthLoggedOut extends AuthEvent {}
