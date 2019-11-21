import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:mobile_version/data/class/class.dart';
import 'package:mobile_version/data/response/response..dart';

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
  final BongkarMuatResponse bongkarMuat;

  const HomeLoaded({@required this.visit, this.bongkarMuat})
      : assert(visit != null, bongkarMuat != null);

  @override
  List<Object> get props => [visit];

  @override
  String toString() =>
      'HomeLoaded { Visit and bongkar muat: $visit, $bongkarMuat}';
}

class HomeNotLoaded extends HomeState {
  final String error;

  const HomeNotLoaded({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'HomeNotLoaded { error: $error }';
}

class LoginSuccess extends HomeState {
  final String username;

  const LoginSuccess({@required this.username});
  @override
  List<Object> get props => [username];

  @override
  String toString() => 'LoginSuccess { username: $username }';
}
