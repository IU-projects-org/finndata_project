part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {}

class Loading extends AuthState {
  @override
  List<Object?> get props => [];
}

class Authenticated extends AuthState {
  @override
  List<Object?> get props => [];
}

class UnAuthenticated extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthError extends AuthState {
  AuthError(this.error);
  // ignore: prefer_typing_uninitialized_variables
  final error;
  @override
  List<Object?> get props => [error];
}
