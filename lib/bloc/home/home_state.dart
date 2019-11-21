import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:mobile_version/data/class/class.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoaded extends HomeState {
  final Visit visit;

  const HomeLoaded({@required this.visit}) : assert(visit != null);

  @override
  List<Object> get props => [visit];

  @override
  String toString() => 'HomeLoaded { Visit: $visit }';
}

class HomeNotLoaded extends HomeState {
  final String error;

  const HomeNotLoaded({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'HomeNotLoaded { error: $error }';
}

class LoginSuccess extends HomeState{
  final String username;

  const LoginSuccess({@required this.username});
  @override
  List<Object> get props => [username];

  @override
  String toString() => 'LoginSuccess { username: $username }';
}
