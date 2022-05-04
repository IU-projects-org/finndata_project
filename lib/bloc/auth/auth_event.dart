part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInRequested extends AuthEvent {
  SignInRequested(this.email, this.password);
  final String email;
  final String password;
}

class SignUpRequested extends AuthEvent {
  SignUpRequested(this.email, this.password);
  final String email;
  final String password;
}

class SignOutRequested extends AuthEvent {}
