import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationUninitialized extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  final String username;
  final String email;
  final String image;

  AuthenticationAuthenticated(this.username,this.email,this.image);

  @override
  List<Object> get props => [username,email,image];

  @override
  String toString() => 'Authenticated { displayName: $username,$email,$image }';
}

class AuthenticationUnauthenticated extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}