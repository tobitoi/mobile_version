import 'package:equatable/equatable.dart';
import 'package:mobile_version/data/class/class.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationUninitialized extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  final String username;
  final String email;
  final String image;
  final List<String> roles;
  final List<Menu> menuResponse;

  AuthenticationAuthenticated(
      this.username, this.email, this.image, this.menuResponse, this.roles);

  @override
  List<Object> get props => [username, email, image, menuResponse];

  @override
  String toString() =>
      'Authenticated { displayName: $username,$email,$image,$menuResponse,$roles}';
}

class AuthenticationUnauthenticated extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}
